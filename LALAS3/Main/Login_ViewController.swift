//
//  Login_ViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/14.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

import SVProgressHUD

class Login_ViewController: UIViewController {
    
    var RegisterBool :Bool = false
    
    @IBOutlet weak var UITextField_Zhanghao: UITextField!
    @IBOutlet weak var UITextField_Mima: UITextField!
    @IBOutlet weak var UITextField_Yanzhengma: UITextField!
    
    @IBOutlet weak var UIButton_ChangeYanzhengma: UIButton!
    @IBOutlet weak var UIButton_Main: UIButton!
    @IBOutlet weak var UIButton_ZhuCe: UIButton!
    
    @IBAction func ZhanghaoEnd(_ sender: UITextField) {
        print("ZhanghaoEnd")
        UITextField_Mima.becomeFirstResponder()
    }
    @IBAction func PassEnd(_ sender: UITextField) {
        print("PassEnd")
        UITextField_Yanzhengma.becomeFirstResponder()
    }
    @IBAction func YanzhengmaEnd(_ sender: UITextField) {
        print("YanzhengmaEnd")
        UITextField_Yanzhengma.resignFirstResponder()
        Main_Click(UIButton_Main)
    }
    /**返回按钮*/
    @IBAction func Fanhui(_ sender: AnyObject) {
        self.dismiss(animated: true, completion:nil)
    }
    
    /**更换验证码*/
    @IBAction func ChangeYanZhengMa_Click(_ sender: AnyObject) {
        
    }
    
    @IBAction func DissmissKyBoard(_ sender: UIControl) {
        UITextField_Zhanghao.resignFirstResponder()
        UITextField_Mima.resignFirstResponder()
        UITextField_Yanzhengma.resignFirstResponder()
    }
    
    private func ReturnAString (UITextField:UITextField) -> String {
        if let a = UITextField.text {
            if a != "" {
                return a
            }else{
                return "0"
            }
        }
        else{
            if let b = UITextField.placeholder {
                return b
            }
            else{
                return "0"
            }
        }
    }
    
    /**登录*/
    @IBAction func Main_Click(_ sender: AnyObject) {
        let userName = ReturnAString(UITextField: UITextField_Zhanghao)
        let password = ReturnAString(UITextField: UITextField_Mima)
        
        let parameters:Parameters = ["1":userName,"2":password,"3":password]
        
        MyAnimates().Start_A_SVHUD()
        Alamofire.request(GotServers().GotServerAliScripts() + "LOGIN.php", method: .post, parameters: parameters)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("成功请求到")
                    let json = JSON(response.result.value)
                    //print(json)
                    
                    let password_got = json[0]["user_password"].string
                    if password_got != nil {
                        if password == password_got{
                            //成功后呢进行页面跳转该干啥个干啥去
                            MyAnimates().Start_A_HUD_With_Time_Words_Image(time: 2, image: nil, words: "登录成功")
                        }
                        else{
                            MyAnimates().Start_A_HUD_With_Time_Words_Image(time: 2, image: nil, words: "密码错误")
                        }
                    } else {
                        MyAnimates().Start_A_HUD_With_Time_Words_Image(time: 2, image: nil, words: "根本就没有这个人啊")
                    }
                    
                case .failure(let error):
                    print("失败，没有请求到啊")
                    print(error)
                    //显示请求失败 HUD
                    MyAnimates().Start_A_HUD_With_Time_Words_Image(time: 2, image: nil, words: "登录请求失败,请检查网络")
                }
        }
        
    }
    
    private func OtherData () -> () {
        //同步其他用户的其他资料过来
        let userid = ""
        let parameters:Parameters = ["userid":userid]
        Alamofire.request(GotServers().GotServerAliScripts() + "LOGIN.php", method: .post, parameters: parameters)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("成功请求到")
                    let json = JSON(response.result.value)
                    //print(json)
                    
                case .failure(let error):
                    print("失败，没有请求到啊")
                    print(error)
                }
        }

        
    }
    
    /**去注册页面*/
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
