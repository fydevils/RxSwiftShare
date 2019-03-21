//
//  ViewController.swift
//  含树式编程
//
//  Created by 于龙 on 2018/10/10.
//  Copyright © 2018 于龙. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var imgView1: UIImageView!
    @IBOutlet weak var imgView2: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        高阶含树()
        靠诶妹纸()
        //泛型介绍之慢扑()
        //泛型介绍之菲尔特()
        //型介绍之瑞丢斯()
//        使用MFR()
        //可选值()
        //不可变()
        //枚举()
        //纯含树式数据结构()
//        字典树()
//        var image = 图表()
//        image = testChart()
//        self.imgView.image = image
        
//        迭代器()
//        testSequence()
//        testLazy()
//        testScan()
//        柯里化()
    }

    func 靠诶妹纸(){
        let url = URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1539179436578&di=6f97b27b9730edb68a11573374b883cc&imgtype=0&src=http%3A%2F%2F03img.mopimg.cn%2Fmobile%2F20171105%2F20171105231159_5e49acce6d64838d18d2ea5d79b751d0_3.jpeg")!

//        let imageView = UIImageView(image: image)
        let image = CIImage(contentsOf: url)!
        let radius = 5.0
        let color = UIColor.red.withAlphaComponent(0.2)
        let blurredImage = blur(radius: radius)(image)
        let overlayImage = overlay(color: color)(blurredImage)
        self.imgView.image = UIImage(ciImage: image)
        self.imgView1.image = UIImage(ciImage: blurredImage)
        self.imgView2.image = UIImage(ciImage: overlayImage)
        
        let blurAndOverlay = compose(filter: blur(radius: radius), with: overlay(color: color))
        self.imgView.image = UIImage(ciImage: blurAndOverlay(image))

        
        let blurAndOverlay2 = blur(radius: radius) >>> overlay(color: color)
        _ = blurAndOverlay2(image)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

