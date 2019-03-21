//
//  City.swift
//  含树式编程
//
//  Created by 于龙 on 2019/3/18.
//  Copyright © 2019 于龙. All rights reserved.
//

import Foundation

struct City {
    let name:String
    let population:Int
}

extension City{
    func scalingPopulation() -> City {
        return City(name: self.name, population: self.population * 1000)
    }
}


//“假设我们现在想筛选出居民数量至少一百万的城市，并打印一份这些城市的名字及总人口数的列表。我们可以定义一个辅助函数来换算居民数量”

func 使用MFR(){
    
    let paris = City(name: "Paris", population: 2241)
    let madrid = City(name: "Madrid", population: 3165)
    let amsterdam = City(name: "Amsterdam", population: 827)
    let berlin = City(name: "Berlin", population: 3562)
    let cities = [paris, madrid, amsterdam, berlin]
    
    /*
     我们首先将居民数量少于一百万的城市过滤掉。
     然后将剩下的结果通过 scalingPopulation 函数进行 map 操作。
     最后，使用 reduce 函数来构建一个包含城市名字和人口数量列表的 String。
     这里我们使用了 Swift 标准库中 Array 类型的 map、filter 和 reduce 定义。于是，我们可以顺利地链式使用过滤和映射的结果。表达式 cities.filter(..) 的结果是一个数组，对其调用 map；然后这个返回值调用 reduce 即可得到最终结果。
     */
    let result = cities
        .filter{
            $0.population > 1000
        }
        .map{
            $0.scalingPopulation()
        }
        .reduce("City:Population")
        {
            result,city in
            return result + "\n" + "\(city.name):\(city.population)"
        }
    print(result)
}
