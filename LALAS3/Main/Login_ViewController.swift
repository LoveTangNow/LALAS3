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

class Login_ViewController: UIViewController{
    
    var RegisterBool :Bool = false
    
    @IBOutlet weak var UINavigationBar_my: UINavigationBar!
    @IBOutlet weak var UITextField_Zhanghao: UITextField!
    @IBOutlet weak var UITextField_Mima: UITextField!
    
    @IBOutlet weak var UIButton_Main: UIButton!
    @IBOutlet weak var UIButton_ZhuCe: UIButton!
    
    @IBAction func ZhanghaoEnd(_ sender: UITextField) {
        print("ZhanghaoEnd")
        UITextField_Mima.becomeFirstResponder()
    }
    @IBAction func PassEnd(_ sender: UITextField) {
        print("PassEnd")
        Main_Click(UIButton_Main)
    }

    /**返回按钮*/
    @IBAction func Fanhui(_ sender: AnyObject) {
        self.dismiss(animated: true, completion:nil)
    }
    
    @IBAction func DissmissKyBoard(_ sender: UIControl) {
        UITextField_Zhanghao.resignFirstResponder()
        UITextField_Mima.resignFirstResponder()
        YanZhengMa_View.removeFromSuperview()
        Cover.frame = CGRect(x:0,y:0,width:0,height:0)

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
    //**************验证码部分********************//
    @IBOutlet var YanZhengMa_View: UIView!
    @IBOutlet weak var YanZhengMa_Background: UIImageView!
    @IBOutlet weak var YanZhengMa_Position: UIImageView!
    @IBOutlet weak var YanZhengMa_slider: UISlider!
    @IBOutlet weak var Tips: UIButton!
    @IBOutlet weak var Cover: UIImageView!
    
    @IBAction func Slider_ValueChanged(_ sender: UISlider) {
            }
    
    @IBAction func Slider_Touch(_ sender: UISlider) {
        
        let a  = YanZhengMa_slider.value
        if a - possssssss <= 0.05 && a - possssssss >= -0.05 {
            //ok
            print(possssssss)
            print(a)
            YanZhengMa_View.removeFromSuperview()
            Cover.frame = CGRect(x:0,y:0,width:0,height:0)
            MyLogin()
        } else {
            //not ok
            YanZhengMa_slider.value = 0
        }

    }
    
    func YanZhengMa_ChuShiHua() -> Float {
        //下面是使用arc4random函数求一个1~100的随机数（包括1和100）
        Tips.setTitle("将滑块儿滑动到空缺位置", for: .normal)
        Tips.isEnabled = false
        let randomNumber:Int = Int(arc4random_uniform(100))+1
        let width = UIScreen.main.bounds.width
        let space = Float(randomNumber) / 100
        
        YanZhengMa_View.frame = CGRect(x:0,y:0,width:width - 80,height:(width - 80) * 0.618)
        YanZhengMa_View.center = self.view.center
        self.view.addSubview(YanZhengMa_View)
        
        YanZhengMa_Position.frame = CGRect(x:10 + (width - 100 - 32) * CGFloat(space),y:((width - 80) * 0.618) / 2 - (15.5),width:31,height:31)
        YanZhengMa_Position.backgroundColor = UIColor.black
        YanZhengMa_Position.layer.cornerRadius = 15.5
        YanZhengMa_Position.clipsToBounds = true
        
        YanZhengMa_Background.layer.cornerRadius = 5
        YanZhengMa_Background.clipsToBounds = true
        
        Cover.frame = CGRect(x:0,y:0,width:width,height:UIScreen.main.bounds.height)
        Cover.center = self.view.center
        Cover.image = #imageLiteral(resourceName: "Black")
        Cover.alpha = 0.5
        
        return space

    }
    
    //**************验证码部分********************//
    var possssssss = Float()
    
    /**登录*/
    @IBAction func Main_Click(_ sender: AnyObject) {
        possssssss = YanZhengMa_ChuShiHua()
    }
    
    private func MyLogin() -> () {
        let userName = ReturnAString(UITextField: UITextField_Zhanghao)
        let password = ReturnAString(UITextField: UITextField_Mima)
        
        let parameters:Parameters = ["1":userName,"2":password,"3":password]

        if (UITextField_Zhanghao.text?.isEmpty)! || (UITextField_Mima.text?.isEmpty)! {
            MyUIAlertController().alertController_simple(viewcontrollor: self, tips: "账号或密码未填写", UIAlertActions: "")
        }
        else{
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
                                Defalts_ReadWrite().Settssssss_h(DATA: userName, FORKEY: "user_id")
                                print(Defalts_ReadWrite().ReadDefalts_String(KEY: "user_id"))
                                print("*-*-*-*-*-*-*-*-*")
                                print(Defalts_ReadWrite().ReadDefalts_String(KEY: "user_id"))
                                self.dismiss(animated: true, completion: nil)
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
        
        self.UINavigationBar_my.isHidden = true

        UITextField_Zhanghao.placeholder = "手机号或者邮箱"
        UITextField_Mima.placeholder = "密码"
        
        UIButton_Main.setTitle("登录", for:  UIControlState.normal)
        UIButton_ZhuCe.setTitle("没有账号？点这里", for:  UIControlState.normal)
        
        let RegisterBool :Bool = false
        UserDefaults.standard.set(RegisterBool, forKey: "RegisterBool")
        //设置同步
        UserDefaults.standard.synchronize()
       
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if  UserDefaults.standard.value(forKey: "data1") != nil {
            RegisterBool = UserDefaults.standard.value(forKey: "data1") as! Bool
            if RegisterBool == true {
                self.UINavigationBar_my.isHidden = true
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Defalts_ReadWrite().Settssssss_h(DATA: "Login_ViewController", FORKEY: "whereifrom")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
