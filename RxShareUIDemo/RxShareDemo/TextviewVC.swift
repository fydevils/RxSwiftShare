//
//  TextviewVC.swift
//  RxShareDemo
//
//  Created by 吴栋 on 2019/3/7.
//  Copyright © 2019 foryou. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class TextviewVC: BaseVC {

    let disposeBag = DisposeBag()
    
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
//        （1）UITextView 还封装了如下几个委托回调方法：
//
//        didBeginEditing：开始编辑
//        didEndEditing：结束编辑
//        didChange：编辑内容发生改变
//        didChangeSelection：选中部分发生变化
        
        self.textView.backgroundColor = UIColor.lightGray
        
        //开始编辑响应
        textView.rx.didBeginEditing
            .subscribe(onNext: {
                print("开始编辑")
            })
            .disposed(by: disposeBag)
        
        //结束编辑响应
        textView.rx.didEndEditing
            .subscribe(onNext: {
                print("结束编辑")
            })
            .disposed(by: disposeBag)
        
        //内容发生变化响应
        textView.rx.didChange
            .subscribe(onNext: {
                print("内容发生改变")
            })
            .disposed(by: disposeBag)
        
        //选中部分变化响应
        textView.rx.didChangeSelection
            .subscribe(onNext: {
                print("选中部分发生变化")
            })
            .disposed(by: disposeBag)

    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
