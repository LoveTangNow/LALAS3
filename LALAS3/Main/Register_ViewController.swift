//
//  Register_ViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/14.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class Register_ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Finish(_ sender: AnyObject) {
        let RegisterBool :Bool = true
        UserDefaults.standard.set(RegisterBool, forKey: "RegisterBool")
        //设置同步
        UserDefaults.standard.synchronize()
        
        self.dismiss(animated: true, completion:nil)
    }

}
