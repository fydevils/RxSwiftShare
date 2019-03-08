//
//  BaseVC.swift
//  RxShareDemo
//
//  Created by 吴栋 on 2019/3/7.
//  Copyright © 2019 foryou. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx


class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white

        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 10, y: 20, width: 100, height: 40)
        button.setTitle("返回", for: .normal)
        button.backgroundColor = UIColor.yellow
        button.addTarget(self, action: #selector(tagPressed), for: .touchUpInside)
        self.view .addSubview(button)

    }
    
    @objc func tagPressed(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
//    func pushAnother() {
//        let button = UIButton.init(type: .custom)
//        button.frame = CGRect.init(x: self.view.frame.size.width-110, y: 20, width: 100, height: 40)
//        button.setTitle("另一个样例", for: .normal)
//        button.backgroundColor = UIColor.yellow
//        button.addTarget(self, action: #selector(push), for: .touchUpInside)
//        self.view .addSubview(button)
//    }
//    
//    @objc func push(){
//
//        self.present(vc, animated: true, completion: nil)
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
