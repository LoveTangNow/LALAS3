//
//  Functions.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/15.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD


class FFFFFunctions: AnyObject {
    
    //判断设备的方法
    func getDeviceVersion () -> String {
        let name = UnsafeMutablePointer<utsname>.allocate(capacity: 1)
        uname(name)
        let machine = withUnsafePointer(to: &name.pointee.machine, { (ptr) -> String? in
            
            let int8Ptr = unsafeBitCast(ptr, to: UnsafePointer<CChar>.self)
            return String.init(describing: int8Ptr)
        })
        name.deallocate(capacity: 1)
        if let deviceString = machine {
            switch deviceString {
            //iPhone
            case "iPhone1,1":                return "iPhone 1G"
            case "iPhone1,2":                return "iPhone 3G"
            case "iPhone2,1":                return "iPhone 3GS"
            case "iPhone3,1", "iPhone3,2":   return "iPhone 4"
            case "iPhone4,1":                return "iPhone 4S"
            case "iPhone5,1", "iPhone5,2":   return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":   return "iPhone 5C"
            case "iPhone6,1", "iPhone6,2":   return "iPhone 5S"
            case "iPhone7,1":                return "iPhone 6 Plus"
            case "iPhone7,2":                return "iPhone 6"
            case "iPhone8,1":                return "iPhone 6s"
            case "iPhone8,2":                return "iPhone 6s Plus"
            case "iPhone8,3","iPhone8,4":    return "iPhone SE"
            default:
                return deviceString
            }
        } else {
            return "Unknown"
        }
    }
    
    //计算需要高度的方法
    func Height_Work(Words:String,Width:CGFloat) -> Int {
        /*
         320
         375.5
         414
         */
        switch Width {
        case 320:
            //每行20
            return ((Words.characters.count - Words.characters.count % 20) / 20 + 1) * 19 + 15
        case 375.5:
            //每行24
            return ((Words.characters.count - Words.characters.count % 24) / 24 + 1) * 19 + 15
        case 414:
            //每行27
            return ((Words.characters.count - Words.characters.count % 27) / 27 + 1) * 19 + 15
        default:
            return 24
        }
    }

    
    //解析 json

    func json(A:Data) -> String {
        let username:String = ""
        
        if let statusesArray = try? JSONSerialization.jsonObject(with: A, options: .allowFragments) as? [[String: AnyObject]],
            let user = statusesArray?[0]["user"] as? [String: AnyObject],
            let username = user["name"] as? String {
            // Finally we got the username
            return username
        }
        return username
    }
    
    //MARK: - GotServerAliScripts
    func GotServerAliScripts() -> String {
        let diaryList:String = Bundle.main.path(forResource: "/Server", ofType:"plist")!
        let data:NSMutableDictionary = NSMutableDictionary(contentsOfFile:diaryList)!
        return data.object(forKey: "ServerAliScripts") as! String
    }
   
     //MARK: - GotServer
    func GotServer(ai:Bool) -> String {
        if ai == true {
            let diaryList:String = Bundle.main.path(forResource: "/Server", ofType:"plist")!
            let data:NSMutableDictionary = NSMutableDictionary(contentsOfFile:diaryList)!
            return data.object(forKey: "ServerAli") as! String
            //阿里服务器
        } else {
            let diaryList:String = Bundle.main.path(forResource: "/Server", ofType:"plist")!
            let data:NSMutableDictionary = NSMutableDictionary(contentsOfFile:diaryList)!
            return data.object(forKey: "Server") as! String
            //本地服务器
        }
    }
    
     //MARK: - GotImageIconServer
    func GotImageIconServer(ai:Bool) -> String {
        let diaryList:String = Bundle.main.path(forResource: "/Server", ofType:"plist")!
        let data:NSMutableDictionary = NSMutableDictionary(contentsOfFile:diaryList)!
        let a = data.object(forKey: "ImageIcon") as! String
        return GotServer(ai: ai) + a
    }
    
     //MARK: - GotImageTServer
    func GotImageTServer(ai:Bool) -> String {
        let diaryList:String = Bundle.main.path(forResource: "/Server", ofType:"plist")!
        let data:NSMutableDictionary = NSMutableDictionary(contentsOfFile:diaryList)!
        let a = data.object(forKey: "ImageT") as! String
        return GotServer(ai: ai) + a
    }
     //MARK: - GotImageMainServer
    func GotImageMainServer(ai:Bool) -> String {
        let diaryList:String = Bundle.main.path(forResource: "/Server", ofType:"plist")!
        let data:NSMutableDictionary = NSMutableDictionary(contentsOfFile:diaryList)!
        let a = data.object(forKey: "ImageMain") as! String
        return GotServer(ai: ai) + a

    }
     //MARK: - GotImageADServer
    func GotImageADServer(ai:Bool) -> String {
        let diaryList:String = Bundle.main.path(forResource: "/Server", ofType:"plist")!
        let data:NSMutableDictionary = NSMutableDictionary(contentsOfFile:diaryList)!
        let a = data.object(forKey: "ImageAD") as! String
        return GotServer(ai: ai) + a
    }
     //MARK: - SetUserDefaults
    
    func SetUserDefaults(DATA:String,FORKEY:String) {
        UserDefaults.standard.set(DATA,forKey:FORKEY)
        UserDefaults.standard.synchronize()
    }
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
     //MARK: -
     //MARK: -
     //MARK: - 
     //MARK: - 
     //MARK: -
    
    
}
