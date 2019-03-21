//
//  dicTree.swift
//  含树式编程
//
//  Created by 于龙 on 2018/10/17.
//  Copyright © 2018 于龙. All rights reserved.
//

import Foundation

//字典树的自动补全
extension String {
    func complete(history: [String]) -> [String] {
        return history.filter{
            str in
            return str.hasPrefix(self)
        }
    }
}
//字典树
struct Trie <Element:Hashable>{
    let isElement: Bool   //这个布尔值会标记截止于当前节点的字符串是否在树中
    let children: [Element:Trie<Element>]
}
//空的字典树
extension Trie {
    init() {
        self.isElement = false
        self.children = [:]
    }
}

//元素展平为数组
extension Trie {
    var elements:[[Element]]{
        var result: [[Element]] = isElement ? [[]] : []
        for (key, value) in children {
            result += value.elements.map { [key] + $0 }
        }
        return result
    }
}

//数组切片
extension Array{
    var slice: ArraySlice<Element>{
        return ArraySlice(self)
    }
}
/*
 我们之所以为 ArraySlice 而不是 Array 定义 decomposed，是因为性能上的原因。
 Array 中的 dropFirst 方法的复杂度是 O(n)，而 ArraySlice 中 dropFirst 的复杂度则为 O(1)。
 因此，此处的 decomposed 也只具有 O(1) 的复杂度
 */
extension ArraySlice {
    var decomposed: (Element, ArraySlice<Element>)? {
        return isEmpty ? nil : (self[startIndex], self.dropFirst())
    }
}
//我们可以抛开 for 循环或是 reduce 函数，而使用 decompose 函数递归地对一个数组的元素求和
func sum(_ integers: ArraySlice<Int>) -> Int {
    guard let (head, tail) = integers.decomposed else { return 0 }
    return head + sum(tail)
}
//我们现在可以使用 ArraySlice 的辅助方法 decomposed 来为数组切片编写一个查询函数：给定一个由一些 Element 组成的键组，遍历一棵字典树，来逐一确定对应的键是否储存在树中
extension Trie{
    func lookup(key: ArraySlice<Element>) -> Bool {
        guard let (head,tail) = key.decomposed else {return isElement}
        guard let subtrie = children[head] else {return false}
        return subtrie.lookup(key:tail)
    }
}
//我们也可以对 lookup 函数小作修改，给定一个前缀键组，使其返回一个含有所有匹配元素的子树
extension Trie{
    func lookup1(key: ArraySlice<Element>) -> Trie<Element>? {
        guard let (head,tail) = key.decomposed else {return self}
        guard let remainder = children[head] else {return nil}
        return remainder.lookup1(key: tail)
    }
}

extension Trie{
    func complete(key: ArraySlice<Element>) -> [[Element]] {
        if let elements = lookup1(key: key)?.elements{
            return elements
        }
        return []
    }
}

/*
 “如果传入的键组不为空，且能够被分解为 head 与 tail，我们就用 tail 递归地创建一棵字典树。然后创建一个新的字典 children，以 head 为键存储这个刚才递归创建的字典树。最后，我们用这个字典创建一棵新的字典树。因为输入的 key 非空，这意味着当前键组尚未被全部存入，所以 isElement 应该是 false。”
 “如果传入的键组为空，我们可以创建一棵没有子节点的空字典树，用于储存一个空字符串，并将 isElement 赋值为 true。”
 */
extension Trie {
    init(_ key: ArraySlice<Element>) {
        if let (head,tail) = key.decomposed {
            let children = [head: Trie(tail)]
            self = Trie(isElement:false,children:children)
        }else {
            self = Trie(isElement:true,children:[:])
        }
    }
}

//插入函数
/*
 如果键组为空，我们将 isElement 设置为 true，然后不再修改剩余的字典树。
 如果键组不为空，且键组的 head 已经存在于当前节点的 children 字典中，我们只需要递归地调用该函数，将键组的 tail 插入到对应的子字典树中。
 如果键组不为空，且第一个键 head 并不是该字典树中 children 字典的某条记录，就创建一棵新的字典树来储存键组中剩下的键。然后，以 head 键对应新的字典树，储存在当前节点中，完成插入操作
 */
extension Trie {
    func inserting(_ key: ArraySlice<Element>) -> Trie<Element> {
        guard let (head,tail) = key.decomposed else { return Trie(isElement: true, children: children) }
        var newChildren = children
        if let nextTrie = children[head] {
            newChildren[head] = nextTrie.inserting(tail)
        }else {
            newChildren[head] = Trie(tail)
        }
        return Trie(isElement: isElement, children: newChildren)
    }
}

//通过单词列构建字典树
extension Trie {
    static func build(words: [String]) -> Trie<Character> {
        let emptyTrie = Trie<Character>()
        return words.reduce(emptyTrie){
            trie,word in
            trie.inserting(Array(word.characters).slice)
        }
    }
}

//我们通过调用之前定义的 complete 方法，并将结果转换回字符串，就能得到一组经过我们自动补全的单词了
extension String {
    func complete(_ knownWords: Trie<Character>) -> [String] {
        let chars = Array(characters).slice
        let completed = knownWords.complete(key: chars)
        return completed.map{
            chars in
            self + String(chars)
        }
    }
}

//extension Trie {
//    func inserting2<S: Sequence>(key: S) -> Trie<Element> {
//        <#function body#>
//    }
//}

func 字典树(){
    let t = Trie(isElement: false,
                 children: [
                    "c":Trie(isElement: false,
                             children: [
                                "a": Trie(isElement: false,
                                          children: [
                                            "r":Trie(isElement: true,
                                                     children:[
                                                        "t":Trie(isElement: true,
                                                                 children: [:]
                                                        )]
                                            ),
                                            "t":Trie(isElement: true,
                                                     children: [:]
                                            )]
                                )]
                    )]
    )
    print(t.elements)
    let insertedT = t.inserting(["d","o","g"].slice)
    let insertedT2 = insertedT.inserting(["d","o","s"].slice)
    print(insertedT.elements)
    print(insertedT2.elements)
    print(t.complete(key: ["c","a"].slice))
    print(sum([1,2,3,4,5].slice))
//
//    let sliceArray = ArraySlice.init([1,2,3,4,5])
//    print(sum(sliceArray))
    
    let contents = ["cat","car","cart","dog"]
    let trieOfWords = Trie<Character>.build(words: contents)
    print(trieOfWords.elements)
    
    let completeStrings = "car".complete(trieOfWords)
    print(completeStrings)
}
