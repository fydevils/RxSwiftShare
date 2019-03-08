//
//  CompareVC.swift
//  RxShareDemo
//
//  Created by 吴栋 on 2019/3/8.
//  Copyright © 2019 FY. All rights reserved.
//

import UIKit

class CompareVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let numbers = [1,2,3,4]
        let result = numbers.map { $0 + 2 }
        let flatMapresult = numbers.compactMap { $0 + 2 }
        print(result)  // [3,4,5,6]
        
        print(flatMapresult)  // [3,4,5,6]
        
        
        
        let numbersCompound = [[1,2,3],[4,5,6]];
        var res = numbersCompound.map { $0.map{ $0 + 2 } }
        print(res)
        var flatRes = numbersCompound.flatMap { $0.map{ $0 + 2 } }
        print(flatRes)
        // [[3, 4, 5], [6, 7, 8]]
        // [3, 4, 5, 6, 7, 8]
        
        let optionalArray: [String?] = ["AA", nil, "BB", "CC"]
        let optionalResult = optionalArray.compactMap{ $0 }
        print(optionalResult)
        var mapResult = optionalArray.map{ $0 }
        print(mapResult)

        // ["AA", "BB", "CC"]
        
        
        let array1 = ["1", "2", "3", "4", "5"]//continue  break 都可以

//        for element in array1 {
//            if element == "3" {
//                return
//            }
//            print(element)
//        }
//        print("Hello World")
        
        
        
        let array2 = ["1", "2", "3", "4", "5"]//continue  break 不可以执行
        array2.forEach { (element) in
            if element == "3" {
                return
            }
            print(element)
        }
        print("Hello World")
        
        
        let array3 = ["welcome", "hello"]
        for i in array3.enumerated().reversed() {
            print(i)
            //  (1, "welcome")
            //  (0, "hello")
        }
        
        for i in array3.reversed().enumerated() {
            print(i)
            //  (0, "welcome")
            //  (1, "hello")
        }


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
