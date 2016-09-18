//
//  Login_ViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/14.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class Login_ViewController: UIViewController {
    
    var RegisterBool :Bool = false
    
    @IBOutlet weak var UITextField_Zhanghao: UITextField!
    @IBOutlet weak var UITextField_Mima: UITextField!
    @IBOutlet weak var UITextField_Yanzhengma: UITextField!
    
    @IBOutlet weak var UIButton_ChangeYanzhengma: UIButton!
    @IBOutlet weak var UIButton_Main: UIButton!
    @IBOutlet weak var UIButton_ZhuCe: UIButton!
    
    @IBAction func Fanhui(_ sender: AnyObject) {
        self.dismiss(animated: true, completion:nil)
    }
    
    @IBAction func ChangeYanZhengMa_Click(_ sender: AnyObject) {
        
    }
    
    @IBAction func Main_Click(_ sender: AnyObject) {
    }
    
    @IBAction func Jump_Click(_ sender: AnyObject) {
        
        let sb = UIStoryboard(name: "Main", bundle:nil)
        let vc = sb.instantiateViewController(withIdentifier: "Register_ViewController") as UIViewController
        self.present(vc, animated: true, completion: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        UITextField_Zhanghao.placeholder = "手机号或者邮箱"
        UITextField_Mima.placeholder = "密码"
        UITextField_Yanzhengma.placeholder = "验证码"
        
        UIButton_ChangeYanzhengma.setTitle("", for: UIControlState.normal)
        UIButton_Main.setTitle("登录", for:  UIControlState.normal)
        UIButton_ZhuCe.setTitle("没有账号？点这里", for:  UIControlState.normal)
        
        let RegisterBool :Bool = false
        UserDefaults.standard.set(RegisterBool, forKey: "RegisterBool")
        //设置同步
        UserDefaults.standard.synchronize()
       
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if  UserDefaults.standard.value(forKey: "RegisterBool") != nil {
            
            RegisterBool = UserDefaults.standard.value(forKey: "RegisterBool") as! Bool
            if RegisterBool == true {
                self.dismiss(animated: true, completion:nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
