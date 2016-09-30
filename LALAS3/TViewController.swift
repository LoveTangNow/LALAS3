//
//  TViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/9/27.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit
import LocalAuthentication//这里包含指纹识别 API
import HealthKit
import HealthKitUI

class TViewController: UIViewController {
    @IBOutlet weak var UIImageView_b: UIImageView!
    let width_d  = UIScreen.main.bounds.width

    @IBAction func button_c(_ sender: AnyObject) {
        let A = self.UIImageView_b.frame.height / self.UIImageView_b.frame.width
        UIView.animate(
            withDuration: 0.3,
            delay: 0.0,
            usingSpringWithDamping: 0.55,
            initialSpringVelocity: 5.0,
            options: UIViewAnimationOptions.curveEaseIn,
            animations: {
                self.UIImageView_b.frame =  CGRect(x:0,y:0,width:self.width_d,height:self.width_d * A)
            })
        
        let myContext = LAContext()
        let myLocalizedReasonString = "验证已有指纹"
        myContext.touchIDAuthenticationAllowableReuseDuration = 0//验证间隔，短时间内可以免除验证
        
        //myContext.setCredential(, type: LACredentialType.applicationPassword)
        
        //print(myContext.evaluatedPolicyDomainState)
        //myContext.touchIDAuthenticationAllowableReuseDuration = 0
        
        var authError: NSError? = nil
        if #available(iOS 8.0, OSX 10.12, *) {
            if myContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthentication, error: &authError) {
                myContext.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: myLocalizedReasonString) { (success, evaluateError) in
                    if (success) {
                        //成功之后
                        print("成功")
                        // User authenticated successfully, take appropriate action
                    } else {
                        //输入错误之后
                        print("错误")
                        print(evaluateError)
                        // User did not authenticate successfully, look at error and take appropriate action
                    }
                }
            } else {
                //touchid被锁定后
                print("锁定")
                print(authError)
                //myContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: nil)
                
                // Could not evaluate policy; look at authError and present an appropriate message to user
            }
        } else {
            // Fallback on earlier versions
            print("")
            _ = UIAlertView(title: "Can not do authenticatation", message: "", delegate: nil, cancelButtonTitle: "Cancel")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let bffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let bview = UIVisualEffectView(effect:bffect)
        bview.frame = CGRect(x:0,y:50,width:UIScreen.main.bounds.width,height:UIScreen.main.bounds.height)
        UIImageView_b.addSubview(bview)
        // Do any additional setup after loading the view.
        
        if HKHealthStore.isHealthDataAvailable() == true{
            let healthStore = HKHealthStore()
        }
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
