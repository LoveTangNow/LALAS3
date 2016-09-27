//
//  FourthViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/14.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "我的"
        
        //UserDefaults.standard.set("noSetle", forKey: "isSet")
        
        let a = UserDefaults.standard.value(forKey: "isSet") as? String
        if a == "noSetle" {
            //没有设置过
            UserDefaults.standard.set("Setle", forKey: "isSet")
            UserDefaults.standard.synchronize()
            
            /**
             账号管理：昵称、性别、所在地（省、市、区）、生日、简介、工作信息、教育信息（小学、初中、高中、大学、硕士、博士、博士后）、(qq、手机、邮箱、微博、微信、支付宝、)、等级、积分、注册时间
             账号安全：昵称、id、手机、邮箱、证件信息、
             通用设置：
             通知设置：
             */
            
            //登录注册时已经设置过的有:昵称，id，手机/邮箱
            //我们需要设置其他的一下东西

            //SetUserDefaults(DATA:"",FORKEY:"NiCheng")
            //SetUserDefaults(DATA:"",FORKEY:"ID")
            
            SetUserDefaultsM(DATA:"",FORKEY: "Phone")
            SetUserDefaultsM(DATA:"",FORKEY: "Email")
            SetUserDefaultsM(DATA:"男",FORKEY: "Sex")
            SetUserDefaultsM(DATA:"北京",FORKEY: "Location")
            SetUserDefaultsM(DATA:"",FORKEY: "Brithday")
            SetUserDefaultsM(DATA:"",FORKEY: "Summary")
            SetUserDefaultsM(DATA:"",FORKEY: "Work")
            SetUserDefaultsM(DATA:"",FORKEY: "XX")
            SetUserDefaultsM(DATA:"",FORKEY: "CZ")
            SetUserDefaultsM(DATA:"",FORKEY: "GZ")
            SetUserDefaultsM(DATA:"",FORKEY: "DZ")
            SetUserDefaultsM(DATA:"",FORKEY: "SS")
            SetUserDefaultsM(DATA:"",FORKEY: "BS")
            SetUserDefaultsM(DATA:"",FORKEY: "BSH")
            SetUserDefaultsM(DATA:"",FORKEY: "QQ")
            SetUserDefaultsM(DATA:"",FORKEY: "WB")
            SetUserDefaultsM(DATA:"",FORKEY: "WX")
            SetUserDefaultsM(DATA:"",FORKEY: "ZFB")
            SetUserDefaultsM(DATA:"",FORKEY: "DJ")
            SetUserDefaultsM(DATA:"",FORKEY: "JF")
            SetUserDefaultsM(DATA:"",FORKEY: "ZCSJ")
            SetUserDefaultsM(DATA:"",FORKEY: "ZJ")
            
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Setting_Click(_ sender: AnyObject) {
        let vc = UIStoryboard(name: "Fourth", bundle: nil).instantiateViewController(withIdentifier: "Setting_TableViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func Login_Click(_ sender: AnyObject) {
        let sb = UIStoryboard(name: "Main", bundle:nil)
        let vc = sb.instantiateViewController(withIdentifier: "Login_ViewController") as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    //MARK: - FUNCS
    
    func SetUserDefaults(DATA:String,FORKEY:String) {
        UserDefaults.standard.set(DATA,forKey:FORKEY)
        UserDefaults.standard.synchronize()
    }
    
    func SetUserDefaultsM(DATA:String,FORKEY:String) {
        //先判断这个属性有没有设置过 
        //设置过了 什么也不干 
        //没有设置过 NIL 那就设置默认值

        if  UserDefaults.standard.value(forKey: FORKEY) == nil {
            UserDefaults.standard.set(DATA,forKey:FORKEY)
            UserDefaults.standard.synchronize()
        }
        
    }
    
}
