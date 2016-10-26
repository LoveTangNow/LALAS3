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
         iphone 5 = 320.0
         iphone 5s = 320.0
         
         iphone 6 = 375.0
         iphone 6p = 414.0
         
         iphone 6s = 375.0
         iphone 6sp = 414.0
         
         iphone 7 = 375.0
         iphone 7p = 414.0
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
    
    
    //MARK: -
    /**截取字符串 - 字符串 - 第一个空位 - 第二个空位*/
    func getsubtring(string:String,space_start:Int,space_end:Int) -> String{
        let index_1 = string.index(string.startIndex, offsetBy: space_end)
        let string1 = string.substring(to: index_1)
        let index_2 = string1.index(string1.startIndex, offsetBy: space_start)
        let string2 = string1.substring(from: index_2)
        return string2
    }
    //MARK: -
    
}

