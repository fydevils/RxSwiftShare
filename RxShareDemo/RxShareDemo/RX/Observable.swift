//
//  Observable.swift
//  TestRX
//
//  Created by 于龙 on 2019/1/9.
//  Copyright © 2019 foryou. All rights reserved.
//

import Foundation
import RxSwift

public func example(of description: String, action: ()->Void){
    print("\n--- Example of:", description, "---")
    action()
}

func 哦不泽窝包(){
    example(of: "just,of,from"){
        let one = 1
        let two = 2
        let three = 3
        
        let observable:Observable <Int> = Observable<Int>.just(one)
        
        let observable2:Observable = Observable.of(one,two,three)
        let observable3:Observable = Observable.of([one,two,three])
        
        let observable4:Observable = Observable.from([one,two,three])
        
        observable2.subscribe(onNext:{
            value in
            print("=============\(value)")
        })
    }
    
    example(of: "subscribe") { 
        let one = 1
        let two = 2
        let three = 3
        let observable = Observable.of(one,two,three)
        
        //            let _ = observable.subscribe{
        //                event in
        //                if let element = event.element {
        //                    print(element)
        //                }
        //            }
        
        let _ = observable.subscribe(
            onNext:{
                element in print(element)
        },
            onCompleted:{
                print("completed")
        })
    }
    
    example(of: "empty") {
        let _ = Observable<Void>.empty().subscribe(onCompleted:{
            print("completed")
        })
    }
    
    example(of: "never") {
        let _ = Observable<Any>.never().subscribe(
            onNext: { element in
                print(element)
        },
            onCompleted: {
                print("Completed")
        }
        )
    }
    
    example(of: "range") {
        let observable = Observable<Int>.range(start: 0, count: 10)
        observable.subscribe(
            onNext:{ i in
                let n = Double(i)
                let fibonacci = Int(((pow(1.61803, n) - pow(0.61803, n)) / 2.23606).rounded())
                print(fibonacci)
        })
    }
    
    example(of: "dispose") {
        let observable = Observable.of("A","B","C")
        let subscription = observable.subscribe{
            event in
            print(event)
        }
        subscription.dispose()
    }
    
    example(of: "DisposeBag") {
        let disposeBag = DisposeBag()
        Observable.of("A","B","C").subscribe{
            print($0)
            }.disposed(by: disposeBag)
    }
    
    example(of: "create") {
        let _ = Observable<String>.create {
            observer in
            observer.onNext("1")
            observer.onCompleted()
            observer.onNext("2")
            return Disposables.create()
            }
            
            .subscribe(
                onNext: { print($0) },
                onError: { print($0) },
                onCompleted: { print("Completed") },
                onDisposed: { print("Disposed") }
            )
            .disposed(by: disposeBag)
    }
    
    example(of: "deferred") { //延迟
        var flip = false
        let factory: Observable<Int> = Observable.deferred{
            flip = !flip
            if flip{
                return Observable.of(1,2,3)
            }else{
                return Observable.of(4,5,6)
            }
        }
        
        for _ in 0...3{
            factory.subscribe(
                onNext:{
                    print($0, terminator:"")
            }).disposed(by: disposeBag)
        }
    }
    
    
    example(of: "deferred2") {
        var isOdd = true
        let factory: Observable<Int> = Observable.deferred{
            isOdd = !isOdd
            if isOdd {
               return  Observable.of(1,3,5,7)
            }else {
               return Observable.of(2,4,6,8)
            }
        }
        
        factory.subscribe{
            event in
            print("\(isOdd)", event)
        }
        
        factory.subscribe{
            event in
            print("\(isOdd)", event)
        }
    }
    
    example(of: "generate") {
        
        Observable
            .generate(initialState: 0,
                      condition: { $0 <= 10},
                      iterate: {$0 + 2}
            )
            .subscribe(
                onNext:{ element in
                    print(element)
            })
            .disposed(by: disposeBag)
    }
    
    example(of: "interval") {
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable.subscribe{ event in
            print(event)
        }.disposed(by: disposeBag)
    }
    
    example(of: "timer") {
        let observable = Observable<Int>.timer(5, scheduler: MainScheduler.asyncInstance)
        observable.subscribe{ event in
            print(event)
        }.disposed(by: disposeBag)
    }
    
    example(of: "timer2") {
        let observable = Observable<Int>.timer(5, period: 1, scheduler: MainScheduler.asyncInstance)
        observable.subscribe{ event in
            print(event)
            }.disposed(by: disposeBag)
    }
    
    //        example(of: "Single") {
    //            enum FileReadError: Error {
    //                case fileNotFound, unreadable,encodingFailed
    //            }
    //            func loadText(from name: String) -> Single<String> {
    //                return Single.create{
    //                }
    //            }
    //        }
}
