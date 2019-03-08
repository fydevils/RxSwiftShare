//
//  StepSlider.swift
//  RxShareDemo
//
//  Created by 吴栋 on 2019/3/8.
//  Copyright © 2019 FY. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class StepSlider: BaseVC {
    let disposeBag = DisposeBag()

    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var slider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider.rx.value.asObservable()
            .subscribe(onNext: {
                print("当前值为：\($0)")
            })
            .disposed(by: disposeBag)

        stepper.rx.value.asObservable()
            .subscribe(onNext: {
                print("当前值为：\($0)")
            })
            .disposed(by: disposeBag)

        slider.rx.value
            .map{ Double($0) }  //由于slider值为Float类型，而stepper的stepValue为Double类型，因此需要转换
            .bind(to: stepper.rx.stepValue)
            .disposed(by: disposeBag)
        // Do any additional setup after loading the view.
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
