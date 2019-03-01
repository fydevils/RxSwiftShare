//
//  UILabel+RxExtension.swift
//  RxShareDemo
//
//  Created by 于龙 on 2019/2/22.
//  Copyright © 2019 foryou. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

extension Reactive where Base: UILabel {
    
    public var fontSize: Binder<CGFloat> {
        return Binder(self.base) { label,fontSize in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}
