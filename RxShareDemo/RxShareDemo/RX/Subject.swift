//
//  撒布宅科特.swift
//  TestRX
//
//  Created by 于龙 on 2019/1/9.
//  Copyright © 2019 foryou. All rights reserved.
//

import Foundation
import RxSwift

enum MyError: Error {
    case anError
}

func print<T: CustomStringConvertible> (label: String, event: Event<T>) {
    print(label, event.element ?? event.error)
}

func 撒布宅科特() {
    /*最普通的 Subject，它不需要初始值就能创建
     订阅者从他们开始订阅的时间点起，可以收到订阅后 Subject 发出的新 Event，而不会收到他们在订阅前已发出的 Event
     */
    example(of: "PublishSubject") {
        let subject = PublishSubject<String>()
        subject.onNext("Is anyone listening?")
        
        let subscriptionOne = subject.subscribe(
            onNext: {
                string in
                print(string)
            }
        )
        subject.onNext("1")
        
        let subscriptionTwo = subject.subscribe{
            event in
            print("2)",event.element ?? event)
        }
        subject.onNext("3")
        subscriptionOne.dispose()
        subject.onNext("4")
        subject.onError(MyError.anError)
        subject.onNext("5")
        
        subject.subscribe{
            print("3)", $0.element ?? $0)
        }.disposed(by: disposeBag)
        
        subject.onNext("?")
        
        subject.subscribe{
            print("4)", $0.element ?? $0)
            }
        subject.onNext("666")

        
    }
    /*
     通过一个默认初始值来创建
     当一个订阅者来订阅它的时候，这个订阅者会立即收到 BehaviorSubjects 上一个发出的event。之后就跟正常的情况一样，它也会接收到 BehaviorSubject 之后发出的新的 event
     */
    example(of: "BehaviorSubject") {
        let subject = BehaviorSubject(value: "")
        subject.subscribe{
            print(label: "1)", event: $0)
        }.disposed(by: disposeBag)
        
        subject.onNext("X")
        
        subject.onError(MyError.anError)
        subject.subscribe{
            print(label: "2)", event: $0)
        }.disposed(by: disposeBag)
    }
    /*
     创建时候需要设置一个 bufferSize，表示它对于它发送过的 event 的缓存个数
     */
    example(of: "ReplaySubject") {
        // 1
        let subject = ReplaySubject<String>.create(bufferSize: 2)
        // 2
        subject.onNext("1")
        
//        subject.onNext("2")
//
//        subject.onNext("3")
        
        // 3
        subject.subscribe {
                print(label: "1)", event: $0)
            }.disposed(by: disposeBag)
        subject.subscribe {
                print(label: "2)", event: $0)
            }.disposed(by: disposeBag)
        
        subject.onNext("4")
        
        subject.subscribe{
            print(label: "3)", event: $0)
        }.disposed(by: disposeBag)
        subject.onError(MyError.anError)
    }
    
    /*
     对 BehaviorSubject 的封装，所以它也必须要通过一个默认的初始值进行创建
     简单地说就是 Variable 有一个 value 属性，我们改变这个 value 属性的值就相当于调用一般 Subjects 的 onNext() 方法，而这个最新的 onNext() 的值就被保存在 value 属性里了，直到我们再次修改它。
     */
    example(of: "Variable") {
        let variable = Variable("Initial value")
        variable.value = "New initial value"
        variable.asObservable().subscribe{
            print(label: "1====)", event: $0)
        }.disposed(by: disposeBag)
        variable.value = "1"
    }
}
