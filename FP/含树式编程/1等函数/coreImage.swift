//
//  coreImage.swift
//  函数式编程
//
//  Created by 于龙 on 2019/3/19.
//  Copyright © 2018 于龙. All rights reserved.
//

import Foundation
import CoreImage
import UIKit
//滤镜类型
typealias Filter = (CIImage) -> CIImage
//高斯模糊滤镜
func blur(radius: Double) -> Filter {
    return { image in
        let parameters: [String: Any] = [
            kCIInputRadiusKey:radius,
            kCIInputImageKey:image
        ]
        guard let filter = CIFilter(name: "CIGaussianBlur", withInputParameters: parameters) else {
            fatalError()
        }
        
        guard let outputImage = filter.outputImage else {
            fatalError()
        }
        return outputImage
    }
}
//颜色叠层
func generate(color:UIColor) -> Filter {
    return {_ in
        let parameters = [kCIInputColorKey: CIColor(cgColor: color.cgColor)]
        guard let filter = CIFilter(name: "CIConstantColorGenerator",
                                    withInputParameters: parameters)
            else { fatalError() }
        guard let outputImage = filter.outputImage
            else { fatalError() }
        return outputImage
    }
}
//合成滤镜
func compositeSourceOver(overlay: CIImage) -> Filter {
    return { image in
        let parameters = [
            kCIInputBackgroundImageKey:image,
            kCIInputImageKey:overlay
        ]
        guard let filter = CIFilter(name: "CISourceOverCompositing", withInputParameters: parameters) else {
            fatalError()
        }
        guard let outputImage = filter.outputImage else {
            fatalError()
        }
        return outputImage.cropped(to: image.extent)
    }
}
//颜色叠层滤镜
func overlay(color: UIColor) -> Filter {
    return { image in
        let overlay = generate(color: color)(image).cropped(to: image.extent)
        return compositeSourceOver(overlay: overlay)(image)
    }
}
//将滤镜合二为一
func compose(filter filter1: @escaping Filter, with filter2:@escaping Filter) -> Filter {
    return { image in
        filter2(filter1(image))
    }
}

infix operator >>>
func >>>(filter1: @escaping Filter, filter2:@escaping Filter) -> Filter {
    return { image in
        filter2(filter1(image))
    }
}

infix operator <<<
func <<< <A,B,C>(f:@escaping (A)->B,g:@escaping (B)->C) -> (A)->C {
    return { x in
        g(f(x))
    }
}

func carry<A,B,C>(_ f:@escaping (A,B)->C) -> (A)->(B)->C {
    return {x in {y in f(x,y)}}
}

