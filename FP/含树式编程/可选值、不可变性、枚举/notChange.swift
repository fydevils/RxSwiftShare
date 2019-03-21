//
//  notChange.swift
//  含树式编程
//
//  Created by 于龙 on 2019/3/20.
//  Copyright © 2018 于龙. All rights reserved.
//

import Foundation

struct PointStruct {
    var x: Int
    var y: Int
}

class PointClass {
    var x: Int
    var y: Int
    init(x: Int,y: Int) {
        self.x = x
        self.y = y
    }
}

//总是到0
func setStructToOrigin(point: PointStruct) -> PointStruct {
    var newPoint = point
    newPoint.x = 0
    newPoint.y = 0
    return newPoint
}

func setClassToOrigin(point: PointClass) -> PointClass {
    point.x = 0
    point.y = 0
    return point
}

func 不可变(){
    var classPoint = PointClass(x: 100, y: 100)
    var classOrigin = setClassToOrigin(point: classPoint)
}
