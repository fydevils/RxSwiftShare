//
//  Operator.swift
//  TestRX
//
//  Created by 于龙 on 2019/2/22.
//  Copyright © 2019 foryou. All rights reserved.
//

import Foundation
import RxSwift

func 奥普瑞特尔()
{
    example(of: "ignoreElement") {
        
        let strikes = PublishSubject<String>()
        strikes.ignoreElements().subscribe{
            _ in
            print("You are out!")
            }.disposed(by: disposeBag)
        
        strikes.onNext("X")
        strikes.onNext("X")
        strikes.onNext("X")
        strikes.onCompleted()
    }
    
    example(of: "elementAt") {
        let strikes = PublishSubject<String>()
        strikes
            .elementAt(2)
            .subscribe(onNext: { event in
                print(event)
            })
            .disposed(by: disposeBag)
        strikes.onNext("X")
        strikes.onNext("Y")
        strikes.onNext("Z")
        strikes.onCompleted()
    }
    
    example(of: "filter") {
        let strikes = PublishSubject<Int>()
        strikes.filter{ integer in
            return integer % 2 == 0
            }.subscribe(
                onNext:{
                    print($0)
            }).disposed(by: disposeBag)
        
        strikes.onNext(1)
        strikes.onNext(2)
        strikes.onNext(3)
        strikes.onNext(4)
        strikes.onNext(5)
    }/* 2,4 */
    
    example(of: "skip") {
        Observable.of(2,3,4,5,6)
            .skip(2).subscribe(onNext:{
                print($0)
            })
            .disposed(by: disposeBag)
    } /* 4,5,6*/
    
    example(of: "skipWhile") {
        Observable.of(2,3,4,4).skipWhile{
            integer in
            integer % 2 == 1 //符合就跳，调到第一个不符合的开始后面的都emit
            }.subscribe(onNext:{
                print($0)
            }).disposed(by: disposeBag)
    }/*2, 3,4,4*/
    
    example(of: "skipUntil") {
        let subject = PublishSubject<String>()
        let trigger = PublishSubject<String>()
        subject.skipUntil(trigger).subscribe(onNext:{
            print($0)
        }).disposed(by: disposeBag)
        
        subject.onNext("X")
        subject.onNext("Y")
        trigger.onNext("X")
        subject.onNext("Z")
    }/*Z*/
    example(of: "test") {
        
        let numbers = Observable<Int>.create{
            observer in
            let start = getStartNumber()
            observer.onNext(start)
            observer.onNext(start+1)
            observer.onNext(start+2)
//            observer.onCompleted()
            return Disposables.create()
        }
        
        numbers.share().subscribe(onNext:{
            el in
            print("element [\(el)]")
        },onCompleted:{
            print("---------------")
        }).disposed(by: disposeBag) /*123*/
        
        numbers.share().subscribe(onNext:{
            el in
            print("element ++[\(el)]")
        },onCompleted:{
            print("---------------")
        }).disposed(by: disposeBag)/**/
    }
    
    example(of: "flatMap") {
        let ryan = Student(score: BehaviorSubject(value: 80))
        let charlotte = Student(score: BehaviorSubject(value: 90))
        let student = PublishSubject<Student>()
        
        student.flatMap{
            $0.score
            }.subscribe(onNext:{
                print($0)
            }).disposed(by: disposeBag)
        
        student.onNext(ryan)
        ryan.score.onNext(85)
        student.onNext(charlotte)
        ryan.score.onNext(95)
        charlotte.score.onNext(100)
        
    }
    
    example(of: "flapMap1") {
        let disposeBag = DisposeBag()
        let first = BehaviorSubject(value: "👦🏻")
        let second = BehaviorSubject(value: "🅰️")
        let variable = Variable(first)
        
        variable.asObservable()
            .flatMap { $0 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        first.onNext("🐱")
        variable.value = second
        second.onNext("🅱️")
        first.onNext("🐶")
    }
    
    example(of: "flapMapLastest") {
        let disposeBag = DisposeBag()
        let first = BehaviorSubject(value: "👦🏻")
        let second = BehaviorSubject(value: "🅰️")
        let variable = Variable(first)
        
        variable.asObservable()
            .flatMapLatest { $0 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        first.onNext("🐱")
        variable.value = second
        second.onNext("🅱️")
        first.onNext("🐶")
    }
    
    example(of: "materialize and dematerialize") {
        enum MyError: Error {
            case anError
        }
        
        let ryan = Student(score: BehaviorSubject(value: 80))
        let charlotte = Student(score: BehaviorSubject(value: 100))
        let student = BehaviorSubject(value: ryan)
        
        let studentScore = student.flatMapLatest{
            $0.score
            }
        studentScore.subscribe(onNext:{
                print($0)
            }).disposed(by: disposeBag)
        
        ryan.score.onNext(85)
        ryan.score.onError(MyError.anError)
        ryan.score.onNext(90)
        student.onNext(charlotte)
    }
}

var start = 0

func getStartNumber() -> Int {
    start += 1
    return start
}

struct Student {
    var score: BehaviorSubject<Int>
}
