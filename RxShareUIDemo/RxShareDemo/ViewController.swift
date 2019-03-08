//
//  ViewController.swift
//  RxShareDemo
//
//  Created by 吴栋 on 2019/3/8.
//  Copyright © 2019 FY. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let array = ["UILabel","UITextField","TextviewVC","UIButton","Swi-Sege","Slider_Steper","DoubleBindVC","UIGesture","UIDatePickerVC","UIDatePickerVC2","UITableView1VC","UITableView2VC","UITableviewReload","UITableViewEdit","CompareVC"]
        
        //在遍历数组的时候，Swift还提供了一种特别方便的方式（利用元祖）
        for (index,value) in array.enumerated() {
            //index是下标，value是值
            //这样使得遍历数组能写的更加简洁优雅
            
            let line = index/10
            let row = index%10
            let button = UIButton.init(type: .custom)
            button.tag = 10000+index
            button.frame = CGRect.init(x: 10+200*line, y: 50*row+64, width: 150, height: 40)
            button.setTitle(value, for: .normal)
            button.backgroundColor = UIColor.green
            button.addTarget(self, action: #selector(self.orderDetailClicked(_:)), for: .touchUpInside)
            self.view .addSubview(button)
        }
    }
    
    @objc func orderDetailClicked(_ butoton:UIButton){
        
        var vc:UIViewController = UIViewController()
        
        if butoton.tag == 10000 {
            vc = LabelVC()
        } else if butoton.tag == 10001 {
            vc = TextFieldVC()
        } else if butoton.tag == 10002 {
            vc = TextviewVC()
        } else if butoton.tag == 10003 {
            vc = UIButtonVC()
        } else if butoton.tag == 10004 {
            vc = UISwitchVC()
        } else if butoton.tag == 10005 {
            vc = StepSlider()
        } else if butoton.tag == 10006 {
            vc = DoubleBindVC()
        } else if butoton.tag == 10007 {
            vc = UIGestureRecognizerVC()
        } else if butoton.tag == 10008 {
            vc = UIDatePickerVC()
        } else if butoton.tag == 10009 {
            vc = UIDatePickerVC2()
        } else if butoton.tag == 10010 {
            vc = UITableView1VC()
        } else if butoton.tag == 10011 {
            vc = UITableView2VC()
        } else if butoton.tag == 10012 {
            vc = UITableviewReload()
            self.navigationController?.pushViewController(vc, animated: true)
            return
        } else if butoton.tag == 10013 {
            vc = UITableViewEdit()
            self.navigationController?.pushViewController(vc, animated: true)
            return
        } else if butoton.tag == 10014 {
            vc = CompareVC()
        } else if butoton.tag == 10010 {
            vc = UITableView1VC()
        } else if butoton.tag == 10010 {
            vc = UITableView1VC()
        }

        self.present(vc, animated: true, completion: nil)
    }
}

