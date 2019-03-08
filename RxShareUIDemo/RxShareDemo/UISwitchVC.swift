//
//  UISwitchVC.swift
//  RxShareDemo
//
//  Created by 吴栋 on 2019/3/7.
//  Copyright © 2019 foryou. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx



class UISwitchVC: BaseVC {
    let disposeBag = DisposeBag()
    @IBOutlet weak var segmented: UISegmentedControl!
   @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        clickSwitch()
        clickSege()
    }
    
    
    func clickSwitch() {
        switch1.rx.isOn.asObservable()
            .subscribe(onNext: {
                print("当前开关状态：\($0)")
            })
            .disposed(by: disposeBag)
        
        switch1.rx.isOn
            .bind(to: button1.rx.isEnabled)
            .disposed(by: disposeBag)

    }
    
    
    func clickSege() {
        
        //创建一个当前需要显示的图片的可观察序列
        let showImageObservable: Observable<UIImage> =
            segmented.rx.selectedSegmentIndex.asObservable().map {
                let images = [UIColor.red, UIColor.black, UIColor.yellow]
                return UIImage.init(color: images[$0], size: CGSize.init(width: 10, height: 10))!
        }
        
        //把需要显示的图片绑定到 imageView 上
        showImageObservable.bind(to: imageView.rx.image)
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
// MARK: 颜色转UIImage
extension UIImage {
    
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1.0, height: 1.0)) {
        UIGraphicsBeginImageContextWithOptions(size, true, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(origin: CGPoint.zero, size: size))
        context?.setShouldAntialias(true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        guard let cgImage = image?.cgImage else {
            self.init()
            return nil
        }
        self.init(cgImage: cgImage)
    }
    
}
