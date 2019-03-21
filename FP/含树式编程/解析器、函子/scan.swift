//
//  scan.swift
//  含树式编程
//
//  Created by 于龙 on 2019/3/20.
//  Copyright © 2019 于龙. All rights reserved.
//

import Foundation

typealias Parser1<Result> = (String)->(Result,String)?
//事实证明，直接操作字符串的性能其实会很差。所以在选择输入和剩余部分的类型时，我们会使用 String.CharacterView 而不是字符串。别小看这点微不足道的改动，它会使性能得到大幅提升

struct Parser<Result> {
    typealias Stream = String.CharacterView
    let parse:(Stream)->(Result,Stream)?
}


func character(matching condition: @escaping (Character)->Bool) -> Parser<Character> {
    return Parser<Character>{ input in
        guard let char = input.first, condition(char) else {return nil}
        return (char,input.dropFirst())
    }
}

func testScan() {
    let one = character {$0 == "1"}
    print(one.parse("123".characters))
}
