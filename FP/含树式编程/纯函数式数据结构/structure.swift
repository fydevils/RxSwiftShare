//
//  structure.swift
//  含树式编程
//
//  Created by 于龙 on 2018/10/11.
//  Copyright © 2018 于龙. All rights reserved.
//

import Foundation

/*
 所谓纯函数式数据结构 (Purely Functional Data Structures) 指的是那些具有不变性的高效的数据结构。
 像 C 或 C++ 这样的指令式语言中的数据结构往往是可变的，直接将这类数据结构使用在函数式语言中往往会水土不服。
 通过本章，我们想向您展示函数式语言中的纯函数式数据结构的构建方式和特点
 */

//实现 isEmpty contains insert
struct MySet <Element:Equatable> {
    var storage: [Element] = []
    func isEmpty() -> Bool {
        return storage.isEmpty
    }
    func contains(_ element:Element) -> Bool {
        return storage.contains(element)
    }
    func insert(_ x:Element) -> MySet {
        return contains(x) ? self : MySet(storage:storage+[x])
    }
}

/*
 这个定义规定了每一棵树，要么是：
 一个没有关联值的叶子 leaf，要么是
 一个带有三个关联值的节点 node，关联值分别是左子树，储存在该节点的值和右子树。
 我们需要在定义前面加上 indirect 来提示编译器不要直接在值类型中直接嵌套
 */

indirect enum BinarySearchTree<Element: Comparable>{
    case leaf
    case node(BinarySearchTree<Element>,Element,BinarySearchTree<Element>)
}
//链表
indirect enum LinkedList<Element: Comparable> {
    case empty
    case node(Element, LinkedList<Element>)
}

extension BinarySearchTree{
    init() {
        self = .leaf
    }
    init(_ value: Element) {
        self = .node(.leaf,value,.leaf)
    }
    
    var count: Int{
        switch self {
        case .leaf:
            return 0
        case let .node(left, _, right):
            return 1 + left.count + right.count
        }
    }
    
    var elements: [Element]{
        switch self {
        case .leaf:
            return []
        case let .node(left, x, right):
            return left.elements + [x] + right.elements
        }
    }
}

extension BinarySearchTree{
    
    func reduce<A>(left leafF: A, node nodeF:(A,Element,A) ->A) -> A {
        switch self {
        case .leaf:
            return leafF
        case let .node(left , x ,right):
            return nodeF(left.reduce(left: leafF, node: nodeF),x,right.reduce(left: leafF, node: nodeF))
        }
    }
}

// 根据reduce重写俩方法
extension BinarySearchTree {
    var elementsR: [Element]{
        return self.reduce(left: []){
            $0 + [$1] + $2
        }
    }
    var counts: Int{
        return self.reduce(left: 0){
            1 + $0 + $2
        }
    }
}

extension BinarySearchTree {
    var isEmpty: Bool{
        if case .leaf = self {
            return true
        }
        return false;
    }
}

// 搜索二叉树
extension BinarySearchTree {
    var isBTT: Bool {
        switch self {
        case .leaf:
            return true
        case let .node(left ,x ,right):
            return left.elements.all {y in y < x}
            && right.elements.all{y in y > x}
            && left.isBTT
            && right.isBTT
        }
    }
}

//二分查找
extension BinarySearchTree {
    
    func contains(_ x: Element) -> Bool {
        switch self {
        case .leaf:
            return false
        case let .node(_,y,_) where x == y:
            return true
        case let .node(left,y,_) where x < y:
            return left.contains(x)
        case let .node(_,y,right) where x > y:
            return right.contains(x)
        default:
            fatalError("The impossible occurred")
        }
    }
}

//插入操作
extension BinarySearchTree {
    mutating func insert(_ x: Element) {
        switch self {
        case .leaf:
            self = BinarySearchTree(x)
        case .node(var left, let y, var right):
            if x<y {left.insert(x)}
            if x>y {right.insert(x)}
            self = .node(left,y,right)
        }
    }
}

extension Sequence{
    func all(predicate: (Iterator.Element) -> Bool) -> Bool {
        for x in self where !predicate(x) {
            return false
        }
        return true
    }
}
    

func 纯含树式数据结构(){
    //链表
    let linkedList = LinkedList.node(1, .node(2, .node(3, .node(4, .empty))))
    print(linkedList)
    //二叉树
    let leaf:BinarySearchTree<Int> = BinarySearchTree.leaf
    let five:BinarySearchTree<Int> = BinarySearchTree.node(leaf, 5, leaf)
}
