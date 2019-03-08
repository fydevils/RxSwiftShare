//
//  TextFieldVC.swift
//  RxShareDemo
//
//  Created by 吴栋 on 2019/3/7.
//  Copyright © 2019 foryou. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class TextFieldVC: BaseVC {

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        jianting()
//        jiantingduozhongzhuangtai()
        jiantingduogezhuangtai()
    }
    
    func jianting() {
        //创建文本输入框
        let inputField = UITextField(frame: CGRect(x:10, y:80, width:200, height:30))
        inputField.borderStyle = UITextField.BorderStyle.roundedRect
        self.view.addSubview(inputField)
        
        //创建文本输出框
        let outputField = UITextField(frame: CGRect(x:10, y:150, width:200, height:30))
        outputField.borderStyle = UITextField.BorderStyle.roundedRect
        self.view.addSubview(outputField)
        
        //创建文本标签
        let label = UILabel(frame:CGRect(x:20, y:190, width:300, height:30))
        self.view.addSubview(label)
        
        //创建按钮
        let button:UIButton = UIButton(type:.system)
        button.frame = CGRect(x:20, y:230, width:40, height:30)
        button.setTitle("提交", for:.normal)
        self.view.addSubview(button)
        
        
        //当文本框内容改变
        let input = inputField.rx.text.orEmpty.asDriver() // 将普通序列转换为 Driver
            .throttle(2) //在主线程中操作，0.3秒内值若多次改变，取最后一次
        
        //内容绑定到另一个输入框中
        input.drive(outputField.rx.text)
            .disposed(by: disposeBag)
        
        //内容绑定到文本标签中
        input.map{ "当前字数：\($0.count)" }
            .drive(label.rx.text)
            .disposed(by: disposeBag)
        
        //根据内容字数决定按钮是否可用
        input.map{ $0.count > 5 }
            .drive(button.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    
    func jiantingduozhongzhuangtai() {
        //创建文本输入框
        let textField = UITextField(frame: CGRect(x:10, y:80, width:200, height:30))
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        self.view.addSubview(textField)
        
        //当文本框内容改变时，将内容输出到控制台上
        textField.rx.text.orEmpty.asObservable()
            .subscribe(onNext: {
                print("您输入的是：\($0)")
            })
            .disposed(by: disposeBag)
        
        
        textField.rx.controlEvent([.editingDidBegin,.editingDidEnd]) //状态可以组合
            .asObservable()
            .subscribe(onNext: {
                print("开始编辑内容!=====\($0)")
            }).disposed(by: disposeBag)
    }

    //同时监听多个 textField 内容的变化（textView 同理）
    
    func jiantingduogezhuangtai() {
        
        
        //创建文本输入框
        let inputField = UITextField(frame: CGRect(x:10, y:80, width:200, height:30))
        inputField.placeholder = "区号"
        inputField.borderStyle = UITextField.BorderStyle.roundedRect
        self.view.addSubview(inputField)
        
        //创建文本输出框
        let outputField = UITextField(frame: CGRect(x:10, y:150, width:200, height:30))
        outputField.borderStyle = UITextField.BorderStyle.roundedRect
        outputField.placeholder = "号码"
        self.view.addSubview(outputField)

        self.view.backgroundColor = UIColor.white
        //创建文本标签
        let label = UILabel(frame:CGRect(x:150, y:200, width:300, height:100))
        self.view.addSubview(label)
        
        Observable.combineLatest(inputField.rx.text.orEmpty, outputField.rx.text.orEmpty) {
            textValue1, textValue2 -> String in
            return "你输入的号码是：\(textValue1)-\(textValue2)"
            }
            .map { $0 }
            .bind(to: label.rx.text)
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
