//
//  CombineOperator.swift
//  TestRX
//
//  Created by 于龙 on 2019/1/17.
//  Copyright © 2019 foryou. All rights reserved.
//

import Foundation
import RxSwift

func 卡么拜宁奥普瑞特尔(){
    example(of: "startWith") {
        let numbers = Observable.of(2,3,4)
        
        numbers.startWith(1).subscribe(onNext:{
            value in
            print("=====\(value)")
        }).disposed(by: disposeBag)
        /*1、2、3、4*/
        numbers.subscribe(onNext:{
            value in
            print("+++++\(value)")
        }).disposed(by: disposeBag)
        /*2、3、4*/
    }
    example(of: "observable.concat") {
        let first = Observable.of(1,2,3)
        let second = Observable.of(4,5,6)
        let observable = Observable.concat([first,second])
        observable.subscribe(onNext:{
            value in
            print(value)
        }).disposed(by: disposeBag)
    }
    /*1、2、3、4、5、6*/
    
    example(of: "concat") {
        let germanCities = Observable.of("Berlin", "Münich", "Frankfurt")
        let spanishCities = Observable.of("Madrid", "Barcelona", "Valencia")
        
        let observable = germanCities.concat(spanishCities)
        observable.subscribe(onNext: { value in
            print(value)
        }).disposed(by: disposeBag)
    }
    /*
     Berlin
     Münich
     Frankfurt
     Madrid
     Barcelona
     Valencia
     */
    
    example(of: "concatMap") {
        let sequcences = [
            "Germany": Observable.of("Berlin", "Münich", "Frankfurt"),
            "Spain": Observable.of("Madrid", "Barcelona", "Valencia")
        ]
        let observable = Observable.of("Spain","Germany").concatMap{
            country in sequcences[country] ?? .empty()
        }
        observable.subscribe(onNext:{
            string in
            print(string)
        }).disposed(by: disposeBag)
    }
    /*
     Madrid
     Barcelona
     Valencia
     Berlin
     Münich
     Frankfurt
     */
    
    example(of: "merge") {
        let left = PublishSubject<String>()
        let right = PublishSubject<String>()
        let source = Observable.of(left,right)
        let observable = source.merge()
        observable.subscribe(onNext:{
            value in
            print(value)
        }).disposed(by: disposeBag)
        
        var leftValues = ["Berlin", "Münich", "Frankfurt"]
        var rightValues = ["Madrid","Barcelona","Valencia"]
        repeat  {
            if arc4random_uniform(2) == 0{
                if !leftValues.isEmpty{
                    left.onNext("Left: " + leftValues.removeFirst())
                }
            }else if !rightValues.isEmpty {
                right.onNext("Right: " + rightValues.removeFirst())
            }
        }while !leftValues.isEmpty || !rightValues.isEmpty
    }
    
    example(of: "combineLatest") {
        let left = PublishSubject<String>()
        let right = PublishSubject<String>()
        let observable = Observable.combineLatest(left,right){
            lastLeft,lastRight in
            "\(lastLeft) \(lastRight)"
        }
        
        observable.subscribe(onNext:{
            value in
            print(value)
        }).disposed(by: disposeBag)
        left.onNext("Hello,")
        right.onNext("World!")
        right.onNext("RxSwift")
        left.onNext("Have a good day")
    } /*
     Hello, World!
     Hello, RxSwift
     Have a good day RxSwift
     */
    
    example(of: "comebine user choice and value") {
        let choice: Observable<DateFormatter.Style> = Observable.of(.short,.long)
        let dates = Observable.of(Date())
        let observables = Observable.combineLatest(choice, dates){
            (format, when) -> String in
            let formatter = DateFormatter()
            formatter.dateStyle = format
            return formatter.string(from: when)
        }
        observables.subscribe(onNext:{
            value in
            print(value)
        }).disposed(by: disposeBag)
    }
    
    example(of: "zip") {
        enum Weather{
            case cloudy
            case sunny
        }
        let left: Observable<Weather> = Observable.of(Weather.sunny,Weather.cloudy,Weather.cloudy,Weather.sunny)
        let right = Observable.of("Lisbon", "Copenhagen", "London", "Madrid","Vienna")
        
        let observable = Observable.zip(left,right) {
            weather,city in
            return "It's \(weather) in \(city)"
        }
        observable.subscribe(onNext:{
            value in
            print(value)
        }).disposed(by: disposeBag)
        /*
         It's sunny in Lisbon
         It's cloudy in Copenhagen
         It's cloudy in London
         It's sunny in Madrid
         */
    }
    
    example(of: "withLastestFrom") {
        let button = PublishSubject<Void>()
        let textField = PublishSubject<String>()
        let observable = button.withLatestFrom(textField)
//        let observable = textField.sample(button)

        
        observable.subscribe(onNext:{
            value in
            print(value)
        }).disposed(by: disposeBag)
        
        textField.onNext("Par")
        textField.onNext("Pari")
        textField.onNext("Paris")
        button.onNext(())
        button.onNext(())
    }
    /*
     Paris
     Paris
     */
    
    example(of: "amb") {
        let left = PublishSubject<String>()
        let right = PublishSubject<String>()
        let obserable = left.amb(right)
        obserable.subscribe(onNext:{
            value in
            print(value)
        }).disposed(by: disposeBag)
        
        left.onNext("Lisbon")
        right.onNext("Copenhagen")
        left.onNext("London")
        left.onNext("Madrid")
        right.onNext("Vienna") 
    }
    /*
     only left
     */
    example(of: "switchLatest") {
        let one = PublishSubject<String>()
        let two = PublishSubject<String>()
        let three = PublishSubject<String>()
        let source = PublishSubject<Observable<String>>()
        
        let observable = source.switchLatest()
        observable.subscribe(onNext:{
            value in
            print(value)
        }).disposed(by: disposeBag)
        source.onNext(one)
        one.onNext("Some text from sequence one")
        two.onNext("Some text from sequcece two")
        source.onNext(two)
        two.onNext("More text from sequence two")
        one.onNext("and also from sequence one")
        source.onNext(three)
        two.onNext("Why don't you see me?")
        one.onNext("I'm alone, help me")
        three.onNext("Hey it's three. I win.")
        source.onNext(one)
        one.onNext("Nope. It's me, one!")
    }
    
    example(of: "reduce") {
        let source = Observable.of(1, 3, 5, 7, 9)
        let observable = source.reduce(0, accumulator: +)
        observable.subscribe(onNext: { value in
            print(value)
        }).disposed(by: disposeBag)
    }
    /*25*/

    example(of: "scan") {
        let source = Observable.of(1, 3, 5, 7, 9)
        source.scan(0, accumulator: +).subscribe(onNext:{
            value in
            print(value)
        }).disposed(by: disposeBag)
    }
    /*
     1、4、9、16、25
     */
 }
