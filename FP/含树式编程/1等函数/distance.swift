//
//  distance.swift
//  函数式编程
//
//  Created by 于龙 on 2018/10/10.
//  Copyright © 2018 于龙. All rights reserved.
//

import Foundation

typealias Distance = Double

struct Position {
    var x: Double
    var y: Double
}

extension Position{
    func within(range: Distance) -> Bool {
        return sqrt(x * x + y * y) <= range
    }
    func minus(_ p: Position) -> Position {
        return Position(x: x - p.x, y: y - p.y)
    }
    var length: Double {
        return sqrt(x * x + y * y)
    }
}

struct Ship {
    var position: Position
    var fringRange: Distance
    var unsafeRange: Distance
}

extension Ship {
    func canEngage(ship target: Ship , friendly: Ship) -> Bool {
        let targetDistance = target.position.minus(position).length
        let friendlyDistance = friendly.position.minus(position).length
        return targetDistance <= fringRange
            && targetDistance > unsafeRange
            && friendlyDistance > unsafeRange
    }
}

func pointRange(point: Position) -> Bool {
    
    return true
}

typealias Region = (Position) -> Bool

func circle(radius: Distance) -> Region {
    return {
        point in point.length <= radius
    }
}

func circle2(radius: Distance, center: Position) -> Region {
    return {
        point in point.minus(center).length <= radius
    }
}

func shift(_ region:@escaping Region, by offset: Position) -> Region {
    return {
        point in region(point.minus(offset))
    }
}

func invert(_ region: @escaping Region) -> Region {
    return {
        point in !region(point)
    }
}

func intersect(_ region: @escaping Region, with other: @escaping Region)
    -> Region {
        return { point in region(point) && other(point) }
}

func union(_ region: @escaping Region, with other: @escaping Region)
    -> Region {
        return { point in region(point) || other(point) }
}

func subtract(_ region: @escaping Region, from original: @escaping Region)
    -> Region {
        return intersect(original, with: invert(region))
}

extension Ship {
    func canSafelyEngage_1(ship target: Ship, friendly: Ship) -> Bool {
        let rangeRegion = subtract(circle(radius: unsafeRange),
                                   from: circle(radius: fringRange))
        let firingRegion = shift(rangeRegion, by: position)
        let friendlyRegion = shift(circle(radius: unsafeRange),
                                   by: friendly.position)
        let resultRegion = subtract(friendlyRegion, from: firingRegion)
        return resultRegion(target.position)
    }
}

func 高阶含树() {
    let p = Position(x: 10, y: 10)
    let anotherP = Position(x: 20, y: 20)
    let q: Position = p.minus(anotherP)
    
    let shifted = shift(circle(radius: 10), by: Position(x: 5, y: 5))
}
