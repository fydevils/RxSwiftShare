//
//  filter.swift
//  含树式编程
//
//  Created by 于龙 on 2019/3/20.
//  Copyright © 2018 于龙. All rights reserved.
//

import Foundation

//简单的查找
func getSwiftFiles(in files: [String]) -> [String] {
    var result: [String] = []
    for file in files {
        if file.hasSuffix(".swift") {
            result.append(file)
        }
    }
    return result
}
//扩展数组的通用查找
extension Array {
    func filter(_ includeElement: (Element) -> Bool) -> [Element] {
        var result: [Element] = []
        for x in self where includeElement(x) {
            result.append(x)
        }
        return result
    }
}
//根据扩展定义方法
func getSwiftFilter2(in files:[String]) -> [String] {
    return files.filter{
        file in
        file.hasSuffix(".swift")
    }
}

func 泛型介绍之菲尔特(){
    let exampleFiles = ["README.md", "HelloWorld.swift", "FlappyBird.swift"]
    print(getSwiftFiles(in: exampleFiles))
}
