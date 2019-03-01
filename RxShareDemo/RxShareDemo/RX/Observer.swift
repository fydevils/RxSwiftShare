//
//  Observer.swift
//  RxShareDemo
//
//  Created by 于龙 on 2019/2/22.
//  Copyright © 2019 foryou. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

func 哦不泽窝尔(){
    
    example(of: "AnyObserver") {
        let observer: AnyObserver<String> = AnyObserver.init(eventHandler: { (event) in
            switch event {
            case .next(let data):
                print(data)
            case .error(let error):
                print(error)
            case .completed:
                print("completed")
            }
        })
        let observable = Observable.of("A","B","C")
        observable.subscribe(observer).disposed(by: disposeBag)
    }
    
    example(of: "Binder") {
        
        let label = UILabel()
        
        let observer: Binder<String> = Binder(label) { view,text in
            print(text)
            view.text = text
        }
        
        let observable = Observable.of("A","B","C")
        observable.bind(to: observer).disposed(by: disposeBag)
    }
    
    //系统自带可绑定属性
    example(of: "SystemBinder") {
        let label = UILabel()
        let observable = Observable.of("A","B","C")
        observable.bind(to:label.rx.text).disposed(by: disposeBag)
    }
    
    example(of: "ExtensionBinder") {
        let label = UILabel()
        let observable = Observable<CGFloat>.of(12,14,16)
        observable.bind(to:label.rx.fontSize).disposed(by: disposeBag)
    }
}

