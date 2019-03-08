//
//  DoubleBindVC.swift
//  RxShareDemo
//
//  Created by 吴栋 on 2019/3/7.
//  Copyright © 2019 foryou. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

struct UserViewModel {
    //用户名
    let username = Variable("guest")
//    let username = BehaviorRelay(value: "guest")
    
    //用户信息
    lazy var userinfo = {
        return self.username.asObservable()
            .map{ $0 == "hangge" ? "您是管理员" : "您是普通访客" }
            .share(replay: 1)
    }()
}

class DoubleBindVC: BaseVC {
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var label: UILabel!
    
    var userVM = UserViewModel()
    
    let disposeBag = DisposeBag()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //将用户名与textField做双向绑定
        userVM.username.asObservable().bind(to: textField.rx.text).disposed(by: disposeBag)

        textField.rx.text.orEmpty.bind(to: userVM.username).disposed(by: disposeBag)
        
        
//        双向绑定操作符是：<->。我们修改上面样例，可以发现代码精简了许多。
        //将用户名与textField做双向绑定
//        _ =  self.textField.rx.textInput <->  self.userVM.username
//        
//        //将用户信息绑定到label上
//        userVM.userinfo.bind(to: label.rx.text).disposed(by: disposeBag)

        
        
        //将用户信息绑定到label上
        userVM.userinfo.bind(to: label.rx.text).disposed(by: disposeBag)

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
