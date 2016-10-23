//
//  Register_ViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/14.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

import SVProgressHUD

class Register_ViewController: UIViewController {
    //MARK: - 变量
    
    //MARK: - 变量绑定

    @IBOutlet weak var cancelItem: UIBarButtonItem!
    @IBOutlet weak var finishItem: UIBarButtonItem!
    
    @IBOutlet weak var phoneNumberOrEmail: UITextField!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    @IBOutlet weak var yanZhengMa: UITextField!
    
    @IBOutlet weak var changeYanZhengMa: UIButton!
    @IBOutlet weak var zhuCe: UIButton!
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    
    //MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ChuShiHua_KongJian()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - Functions
    /**注册逻辑处理*/
    func ZhuceLogic(){
        //判断两个密码问题
    }
    
    /**初始化控件*/
    func ChuShiHua_KongJian() {
        
        image1.layer.cornerRadius = 5
        image1.clipsToBounds = true
        image1.backgroundColor = UIColor.red
        
        image2.layer.cornerRadius = 5
        image2.clipsToBounds = true
        image2.backgroundColor = UIColor.red
        
        image3.layer.cornerRadius = 5
        image3.clipsToBounds = true
        image3.backgroundColor = UIColor.red
        
        image4.layer.cornerRadius = 5
        image4.clipsToBounds = true
        image4.backgroundColor = UIColor.red
        
    }
    
    /**返回第四主页面*/
    func GoBackDeeply() {
        /*
        let RegisterBool :Bool = true
        UserDefaults.standard.set(RegisterBool, forKey: "RegisterBool")
        UserDefaults.standard.synchronize()*/
        self.dismiss(animated: true, completion:nil)
    }
    
    //MARK: - 动作绑定
    /**完成注册*/
    @IBAction func Finish(_ sender: UIBarButtonItem) {
        ZhuceLogic()
        //*********************以下为返回主页面**************************/
        GoBackDeeply()
    }
    /**取消注册*/
    @IBAction func CancelRegister(_ sender: UIBarButtonItem) {
        //*********************以下为返回主页面**************************/
        GoBackDeeply()
    }
    
    
    /**检查两次密码是否相同 value changed*/
    @IBAction func CheckSamePasswod(_ sender: UITextField) {
        print("change")
        if passWord.text == repeatPassword.text {
            image3.backgroundColor = UIColor.green
        }
        else{
            image3.backgroundColor = UIColor.red
        }
    }
    

    
    /**空白处点击-》收起键盘 touch up inside*/
    @IBAction func Control_TOKeyboards(_ sender: UIControl) {
        phoneNumberOrEmail.resignFirstResponder()
        passWord.resignFirstResponder()
        repeatPassword.resignFirstResponder()
        yanZhengMa.resignFirstResponder()
    }
    
    /**手机邮箱键盘动作 did end on exit*/
    @IBAction func A_keyboard(_ sender: UITextField) {
        passWord.becomeFirstResponder()
        //检查完个时候
    }

    /**密码键盘动作 did end on exit*/
    @IBAction func B_keyboard(_ sender: UITextField) {
        repeatPassword.becomeFirstResponder()
        image2.backgroundColor = UIColor.green
    }
    
    /**确认密码键盘动作 did end on exit*/
    @IBAction func C(_ sender: UITextField) {
        yanZhengMa.becomeFirstResponder()
        if passWord.text == repeatPassword.text {
            image3.backgroundColor = UIColor.green
        }
    }
    
    /**验证码键盘动作 did end on exit*/
    @IBAction func D__keyboard(_ sender: UITextField) {
        ZhuceLogic()
    }
     /**EDIT DID END*/
    @IBAction func EDE_A(_ sender: UITextField) {
        
    }
    @IBAction func EDE_B(_ sender: UITextField) {
        image2.backgroundColor = UIColor.green
    }
    
    @IBAction func EDE_C(_ sender: UITextField) {
        if passWord.text == repeatPassword.text {
            image3.backgroundColor = UIColor.green
        }
    }
    @IBAction func EDE_D(_ sender: UITextField) {
    }
}
