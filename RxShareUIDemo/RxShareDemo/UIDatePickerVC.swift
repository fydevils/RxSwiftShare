//
//  UIDatePickerVC.swift
//  RxShareDemo
//
//  Created by 吴栋 on 2019/3/7.
//  Copyright © 2019 foryou. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UIDatePickerVC: BaseVC {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var label: UILabel!
    
    //日期格式化器
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日 HH:mm"
        return formatter
    }()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.rx.date
            .map { [weak self] in
                "当前选择时间: " + self!.dateFormatter.string(from: $0)
            }
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
