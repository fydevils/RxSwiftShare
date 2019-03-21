//
//  lazy.swift
//  含树式编程
//
//  Created by 于龙 on 2019/3/20.
//  Copyright © 2019 于龙. All rights reserved.
//

import Foundation

/*
 利用 for 循环编写出的命令式版本会更为复杂。而我们一旦开始添加新的操作，代码会很快失控。再回头看这段代码时，也会难以理解到底在表达什么。而函数式版本则非常浅显：给定一个数组，过滤，然后映射。
 不过命令式版本还是有一个好处的：执行起来更快。它只对序列进行了一次迭代，并且将过滤和映射合并为一步。同时，数组 result 也只被创建了一次。在函数式版本中，不止序列被迭代了两次（过滤与映射各一次），还生成了一个过渡数组用于将 filter 的结果传递至 map 操作
 */
func testLazy() {
    //命令式版本
    var results: [Int] = []
    for element in 1...10{
        if element % 3 == 0{
            results.append(element * element)
        }
    }
    //函数式版本
    (1...10).filter{$0 % 3 == 0}.map{$0 * $0}
//    print(re//sult)
    
    //lazy
    (1...10).lazy.filter{$0 % 3 == 0}.map{ $0 * $0}
//    print(Array(lazyResult))
}
