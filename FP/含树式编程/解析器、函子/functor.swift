//
//  functor.swift
//  含树式编程
//
//  Created by 于龙 on 2019/3/20.
//  Copyright © 2019 于龙. All rights reserved.
//

import Foundation

func cartesianProduct1<A,B>(xs: [A], ys: [B]) -> [(A,B)] {
    var result: [(A,B)] = []
    for x in xs {
        for y in ys {
            result += [(x,y)]
        }
    }
    return result
}

func cartesianProduct<A,B>(xs: [A], ys: [B]) -> [(A,B)] {
    return xs.flatMap{
        x in
        ys.flatMap{
            y in
            [(x,y)]
        }
    }
}

func testFunctor()  {
    
}
