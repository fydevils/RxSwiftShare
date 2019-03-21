//
//  Iterators.swift
//  含树式编程
//
//  Created by 于龙 on 2018/10/18.
//  Copyright © 2018 于龙. All rights reserved.
//

import Foundation

/*
 在 Objective-C 和 Swift 中，我们常常使用数据类型 Array 来表示一组有序元素。
 虽然数组简单而又快捷，但总会有并不适合用数组来解决的场景出现。
 举个例子，在总数接近无穷的时候，你可能不想对数组中所有的元素进行计算；或者你并不想使用全部的元素。
 在这些情况下，你可能会更希望使用一个迭代器来代替数组
 */

//迭代器是每次根据请求生成数组新元素的过程。任何类型只要遵守以下协议，那么它就是一个迭代器
protocol IteratorProtocol {
    associatedtype Element
    mutating func next()->Element?
}
//数组倒置
struct ReverseIndexIterator: IteratorProtocol {
    var index: Int
    init<T>(array:[T]){
        index = array.endIndex - 1
    }
    mutating func next() -> Int? {
        guard index >= 0 else {return nil}
        defer {index -= 1}
        return index
    }
}

//生成2的幂值的迭代器
struct PowerIterator: IteratorProtocol {
    var power: NSDecimalNumber = 1
    mutating func next() -> NSDecimalNumber? {
        power = power.multiplying(by: 2)
        return power
    }
}
//监控大于1000的幂值
extension PowerIterator {
    mutating func find(where predicate:(NSDecimalNumber) -> Bool) -> NSDecimalNumber? {
        while let x = next() {
            if predicate(x){
                return x
            }
        }
        return nil
    }
}
struct FileLinesIterator: IteratorProtocol {
    let lines:[String]
    var currentLine: Int = 0
    init(filename: String) throws {
        let contents: String = try String(contentsOfFile: filename)
        lines = contents.components(separatedBy: .newlines)
    }
    mutating func next() -> String? {
        guard currentLine < lines.endIndex else {return nil}
        defer {
            currentLine += 1
        }
        return lines[currentLine]
    }
}

//泛型find
extension IteratorProtocol {
    
    mutating func find(predicate: (Element) -> Bool) -> Element? {
        while let x = next() {
            if predicate(x) {
                return x
            }
        }
        return nil
    }
}
//组合迭代器
struct LimitIterator<I: IteratorProtocol>: IteratorProtocol {
    var limit = 0
    var iterator: I
    init(limit: Int, iterator: I) {
        self.limit = limit
        self.iterator = iterator
    }
    mutating func next() -> I.Element? {
        guard limit > 0 else {return nil}
        limit -= 1
        return iterator.next()
    }
}

//AnyIterator迭代器

extension Int {
    func countDown() -> AnyIterator<Int> {
        var i = self - 1
        return AnyIterator{
            guard i >= 0 else {return nil}
            defer {i -= 1}
            return i
        }
    }
}
//
func +<I: IteratorProtocol, J: IteratorProtocol>(first: I, second: J) -> AnyIterator<I.Element> where I.Element == J.Element {
    var i = first
    var j = second
    return AnyIterator { i.next() ?? j.next()}
}

//
func +<I: IteratorProtocol, J: IteratorProtocol>(first: I, second: @escaping ()->J) -> AnyIterator<I.Element> where I.Element == J.Element {
    var one = first
    var other: J? = nil
    return AnyIterator {
        if other != nil {
            return other!.next()
        } else if let result = one.next() {
            return result
        }else {
            other = second()
            return other!.next()
        }
    }
}

func 迭代器()  {
    let letters = ["A","B","C"]
    var iterator = ReverseIndexIterator(array: letters)
    while let i = iterator.next() {
        print("Element \(i) of the array is \(letters[i])")
    }
    var powerIterator = PowerIterator()
    print(powerIterator.find {$0.intValue > 1000} as Any)
}
