//
//  Map.swift
//  含树式编程
//
//  Created by 于龙 on 2019/3/20.
//  Copyright © 2018 于龙. All rights reserved.
//

import Foundation
//整数加一
func increment(array: [Int]) -> [Int] {
    var result: [Int] = []
    for x in array {
        result.append(x+1)
    }
    return result
}
//大宝乘2
func double(array: [Double]) -> [Double] {
    var result: [Double] = []
    for x in array {
        result.append(x * 2)
    }
    return result
}
//抽离相同
func compute(array: [Int],transform: (Int)-> Int) -> [Int] {
    var result: [Int] = []
    for x in array {
        result.append(transform(x))
    }
    return result
}
//精简大宝含树
func double2(array: [Int]) -> [Int] {
    return compute(array: array){
        $0 * 2
    }
}

//返回bool  会有问题 ，定义新版本的compute函数?
func isEven(array: [Int]) -> [Bool] {
    return compute2(array: array){
        x in
        return x % 2 == 0
    }
}
//泛型版本
func compute2<T>(array: [Int],transform: (Int)-> T) -> [T] {
    var result: [T] = []
    for x in array {
        result.append(transform(x))
    }
    return result
}
//没有理由只接受int的数组
func compute3<Element,T>(array: [Element],transform:(Element)->T) -> [T] {
    var result: [T] = []
    for x in array {
        result.append(transform(x))
    }
    return result
}

//双泛型实现单泛型
func genericCompute3<T>(array:[Int],transform:(Int)->T) -> [T] {
    return compute3(array: array, transform: transform)
}
//扩展array
extension Array {
    func map<T>(_ transform:(Element)->T) -> [T] {
        var result:[T] = []
        for x in self {
            result.append(transform(x))
        }
        return result
    }
}

//
func genericCompute<T>(array: [Int],transform:(Int)->T) -> [T] {
    return array.map(transform)
}

func 泛型介绍之慢扑(){
    let result = double2(array: [1,2,3,4,5,4,44])
    print(result)
    
    let result1 = isEven(array: [1,2,3,4,5,67,54])
    print(result1)
    
}
