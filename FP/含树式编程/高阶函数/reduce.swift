//
//  reduce.swift
//  含树式编程
//
//  Created by 于龙 on 2019/3/19.
//  Copyright © 2018 于龙. All rights reserved.
//

import Foundation

//定义一个计算数组中所有整型值之和的函数非常简单：
func sum(integers: [Int]) -> Int {
    var result: Int = 0
    for x in integers {
        result += x
    }
    return result
}

// *
func product(integers: [Int]) -> Int {
    var result: Int = 1
    for x in integers {
        result = x * result
    }
    return result
}
//拼接
func concatenate(strings: [String]) -> String {
    var result: String = ""
    for string in strings {
        result += string
    }
    return result
}

//加行首
func prettyPrint(strings: [String]) -> String {
    var result: String = "Entries in the array xs:\n"
    for string in strings {
        result = " " + result + string + "\n"
    }
    return result
}

//展平
func flatten<T>(_ xss:[[T]]) -> [T] {
    var result: [T] = []
    for x in xss {
        result += x
    }
    return result
}

/*
 这些函数有什么共同点呢？它们都将变量 result 初始化为某个值。随后对输入数组的每一项进行遍历，最后以某种方式更新结果。
 为了定义一个可以体现所需类型的泛型函数，我们需要对两份信息进行抽象：赋给 result 变量的初始值，和用于在每一次循环中更新 result 的函数
 */

//扩展
extension Array{
    func reduce<T>(_ initial:T,combine:(T,Element)->T) -> T {
        var result = initial
        for x in self {
            result = combine(result,x)
        }
        return result
    }
}

//扩展实现 +
func sumUsingReduce(intergers:[Int])->Int{
    return intergers.reduce(0){
        result , x in
        result + x
    }
}

// *
func productUsingReduce(integers: [Int]) -> Int {
    return integers.reduce(1, combine: *)
}

//拼接
func concatenateUsingReduce(strings: [String]) -> String {
    return strings.reduce("", combine: +)
}

//展平使用reduce
func flattenUsingReduce<T>(_ xss:[[T]]) -> [T] {
    return xss.reduce([], combine: +)
//    return xss.reduce([]){
//        result , x in
//        result + x
//    }
}

//使用reduce重写 map和filter

extension Array {
    func mapUsingReduce<T>(_ transform:(Element)->T) -> [T] {
        return self.reduce([]){
            result , x in
            return result + [transform(x)]
        }
    }
    func fliterUsingReduce(_ includeElement:(Element)->Bool) -> [Element] {
        return self.reduce([]){
            result , x in
            return includeElement(x) ? result + [x]:result
        }
    }
}



func 型介绍之瑞丢斯(){
    let s = sum(integers: [1,2,3,4])
    print(s)  //10
    
    let mulit = productUsingReduce(integers: [2,3,4])
    print(mulit) //24
    
    let xss = [["a","b","c"],[1,2,3]]
    print(flatten(xss))
    //["a", "b", "c", 1, 2, 3]
}
