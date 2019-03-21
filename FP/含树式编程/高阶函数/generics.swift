//
//  generics.swift
//  含树式编程
//
//  Created by 于龙 on 2019/3/18.
//  Copyright © 2019 于龙. All rights reserved.
//

import Foundation

func noOp<T>(_ x: T) -> T {
    return x
}

func noOpAny(_ x: Any) -> Any {
    return x
}

func curry<A,B,C>(_ f: @escaping (A,B)->C) -> ((A) -> (B) -> C) {
    return { x in
        { y in
           f(x,y)
        }
    }
}

func 泛型() {
    //泛型可以用于定义灵活的函数，类型检查仍然由编译器负责；
    //Any 类型则可以避开 Swift 的类型系统 (所以应该尽可能避免使用)。
}
