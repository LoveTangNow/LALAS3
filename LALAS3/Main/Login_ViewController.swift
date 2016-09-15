//
//  Login_ViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/14.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class Login_ViewController: UIViewController {
    
    @IBOutlet weak var UITextField_Zhanghao: UITextField!
    @IBOutlet weak var UITextField_Mima: UITextField!
    @IBOutlet weak var UITextField_Yanzhengma: UITextField!
    
    @IBOutlet weak var UIButton_ChangeYanzhengma: UIButton!
    @IBOutlet weak var UIButton_Main: UIButton!
    @IBOutlet weak var UIButton_ZhuCe: UIButton!
    
    @IBAction func ChangeYanZhengMa_Click(_ sender: AnyObject) {
        
    }
    
    @IBAction func Main_Click(_ sender: AnyObject) {
    }
    
    @IBAction func Jump_Click(_ sender: AnyObject) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        UITextField_Zhanghao.placeholder = "手机号或者邮箱"
        UITextField_Mima.placeholder = "密码"
        UITextField_Yanzhengma.placeholder = "验证码"
        
        UIButton_ChangeYanzhengma.setTitle("", for: UIControlState.normal)
        UIButton_Main.setTitle("登录", for:  UIControlState.normal)
        UIButton_ZhuCe.setTitle("没有账号？点这里", for:  UIControlState.normal)
        
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
