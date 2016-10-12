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

        let  a = 1
        
        switch a {
        case 0...9:
            print(9)
            fallthrough
        case 0...8:
            print(9)
            fallthrough
        case 0...7:
            print(9)
            fallthrough
        case 0...6:
            print(9)
            fallthrough
        case 0...5:
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
