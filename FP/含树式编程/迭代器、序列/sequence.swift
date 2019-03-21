//
//  sequence.swift
//  含树式编程
//
//  Created by 于龙 on 2019/3/20.
//  Copyright © 2019 于龙. All rights reserved.
//

import Foundation

//每一个序列都有一个关联的迭代器类型和一个创建新迭代器的方法。我们可以据此使用该迭代器来遍历序列
protocol FYSequence {
    associatedtype Iterator: IteratorProtocol
    func makeIterator() -> Iterator
}

struct ReverseArrayIndices<T>: FYSequence {
   
    let array: [T]
    init(array: [T]) {
        self.array = array
    }
    func makeIterator() -> ReverseIndexIterator {
        return ReverseIndexIterator(array: array)
    }
    
}

func testSequence() {
    
    let array = ["one","two","three"]
    let reverseIndices = ReverseArrayIndices(array: array)
    var reverseIterator = reverseIndices.makeIterator()
    
    while let i = reverseIterator.next() {
        print("Index \(i) is \(array[i])")
    }
    
//    for i in ReverseArrayIndices(array: array) {
//        print("Index \(i) is \(array[i])")
//    }
}
