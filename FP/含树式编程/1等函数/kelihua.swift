//
//  kelihua.swift
//  含树式编程
//
//  Created by 于龙 on 2018/12/8.
//  Copyright © 2018 于龙. All rights reserved.
//

import Foundation

class MyClass {
    func method(number: Int) -> Int {
        return number + 1
    }
}

func add1(_ x: Int,_ y: Int) -> Int {
    return x + y
}

func add2(_ x: Int) -> (Int) -> Int {
    return { $0 + x }
}

func printInt(i: Int) {
    print(i)
}

func 柯里化() {
    
    add1(1, 2)
    add2(1)(2)
    
    let f = MyClass.method
    let object = MyClass()
    let result = f(object)(1)
    
    
    let g = {
        (obj: MyClass) in obj.method
    }
}
