//
//  HuanCun_ViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/18.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class HuanCun_ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let  a = 5
        
        switch a {
        case 9...9:
            print(1)
            fallthrough
        case 8...9:
            print(2)
            fallthrough
        case 7...9:
            print(3)
            fallthrough
        case 6...9:
            print(4)
            fallthrough
        case 5...9:
            print(5)
            fallthrough
        case 4...9:
            print(6)
            fallthrough
        case 3...9:
            print(7)
            fallthrough
        case 2...9:
            print(8)
            fallthrough
        case 1...9:
            print(9)
            fallthrough

        default:
            break
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
