//
//  enum.swift
//  含树式编程
//
//  Created by 于龙 on 2019/3/20.
//  Copyright © 2018 于龙. All rights reserved.
//

import Foundation

enum Encoding {
    case ascii
    case nextstep
    case japaneseEUC
    case utf8
}

extension Encoding {
    var nsStringEncoding: String.Encoding {
        switch self {
        case .ascii: return String.Encoding.ascii
        case .nextstep: return String.Encoding.nextstep
        case .japaneseEUC: return String.Encoding.japaneseEUC
        case .utf8: return String.Encoding.utf8
        }
    }
}

extension Encoding {
    init?(encoding: String.Encoding) {
        switch encoding {
        case String.Encoding.ascii: self = .ascii
        case String.Encoding.nextstep: self = .nextstep
        case String.Encoding.japaneseEUC: self = .japaneseEUC
        case String.Encoding.utf8: self = .utf8
        default: return nil
        }
    }
}

extension Encoding{
    var localizedName: String{
        return String.localizedName(of: nsStringEncoding)
    }
}

enum LookupError: Error{
    case capitalNotFound
    case populationNotFound
}

enum PopulationResult {
    case success(Int)
    case error(LookupError)
}

//重写
func populationOfCapital(country: String) -> PopulationResult {
    guard let capital = capitals[country] else {
        return PopulationResult.error(LookupError.capitalNotFound)
    }
    guard let population = cities[capital] else {
        return PopulationResult.error(LookupError.populationNotFound)
    }
    return PopulationResult.success(population)
}

//系统throw

func poputaionOfCapital(country: String) throws -> Int {
    guard let capital = capitals[country] else { throw LookupError.capitalNotFound }
    guard let population = cities[capital] else { throw LookupError.populationNotFound }
    return population
}

enum Result<T> {
    case success(T)
    case error(Error)
}

func 枚举(){
    let exampleSuccess: PopulationResult = PopulationResult.success(1000)
    switch populationOfCapital(country: "France") {
    case let .success(population):
        print("France's capital has \(population) thousand inhabitants")
    case let .error(error):
        print("Error:\(error)")
    }
    
    do {
        let popultaion = try poputaionOfCapital(country: "France")
        print("France's capital has \(popultaion) thousand inhabitants")
    } catch {
        print("Error:\(error)")
    }
}
