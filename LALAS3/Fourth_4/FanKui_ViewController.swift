//
//  FanKui_ViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/18.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class FanKui_ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let a  = ["9","3","6","4","7"]
        let bb  = [9,3,6,4,7]
        
        let b  = Paixu().Diclike(ID: bb, Date: a)
        for i  in b.0{
            print(i)
        }
        for i  in b.1{
            print(i)
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
