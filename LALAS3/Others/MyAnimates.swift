//
//  MyAnimates.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/10/19.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD


/**我的 HUD 动画类*/
class MyAnimates: AnyObject {
    //MARK: - 开始菊花转动 HUD
    func Start_A_SVHUD() {
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)//前后颜色
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.native)//菊花
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.show()
    }
    //MARK: - 一个有 Time的 Image 的 HUD
    /**一个有 Time的 Image 的 HUD*/
    func Start_A_HUD_With_Time_Words_Image(time:TimeInterval?,image:UIImage?,words:String)  {
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)//前后颜色
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.native)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)//遮罩种类
        if time == nil {//持续时间
            SVProgressHUD.setMinimumDismissTimeInterval(1)
        } else {
            SVProgressHUD.setMinimumDismissTimeInterval(time!)
        }
        
        if image != nil {
            SVProgressHUD.setErrorImage(image)
        }
        SVProgressHUD.showError(withStatus: words)
    }

}
