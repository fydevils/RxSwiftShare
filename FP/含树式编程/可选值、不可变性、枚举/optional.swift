//
//  optional.swift
//  含树式编程
//
//  Created by 于龙 on 2019/3/20.
//  Copyright © 2018 于龙. All rights reserved.
//

import Foundation

func increment(optional: Int?) -> Int? {
    guard let x = optional else {
        return nil
    }
    return x + 1
}

extension Optional{
    func map<U>(_ transform: (Wrapped)->U) -> U? {
        guard let x = self else {
            return nil
        }
        return transform(x)
    }
}

extension Optional{
    func flatMap<U>(_ transform:(Wrapped)-> U?) -> U? {
        guard let x = self else {
            return nil
        }
        return transform(x)
    }
}

//重写
func incrementWithOptional(optaional: Int?) -> Int? {
    return optaional.map{
        $0 + 1
    }
}
//flatmap 重写
func addWithFlatmap(_ optionalX: Int?, _ optionalY: Int?) -> Int?{
    
    return optionalX.flatMap{
        x in
        optionalY.flatMap{
            y in
            return x +  y
        }
    }
}

let cities = ["Paris": 2241, "Madrid": 3165, "Amsterdam": 827, "Berlin": 3562]
let madridPopulation: Int? = cities["Madrid"]

let capitals = [
    "France": "Paris",
    "Spain": "Madrid",
    "The Netherlands": "Amsterdam",
    "Belgium": "Brussels"
]

//根据国家获取首都的人口
func popultationOfCapital(country: String) -> Int? {
    guard let capital = capitals[country], let poputation = cities[capital]
        else {return nil}
    return poputation * 1000
}

//flatmap 重写
func populationOfCapital2(country: String) -> Int? {
    return capitals[country].flatMap{
        capital in
        cities[capital].flatMap{
            population in
            population * 1000
        }
    }
}
//链式重写
func populationOfCapital3(country: String) -> Int? {
    return capitals[country].flatMap{
        capital in
        cities[capital]
        }.flatMap{
            population in
            population * 1000
    }
}

func 可选值(){

    switch madridPopulation {
    case 0?: print("Nobody in Madrid")
    case (1..<1000)?: print("Less than a million in Madrid")
    case let x?: print("\(x) people in Madrid")
    case nil: print("We don't know about Madrid")
    }
    //

}
