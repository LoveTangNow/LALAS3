//
//  Defalts_ReadWrite.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/10/19.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import Foundation

/**我的读取写入设置类*/
class Defalts_ReadWrite: AnyObject {
    //MARK: - 设置默认
    //账号管理：昵称、性别、所在地（省、市、区）、生日、简介、工作信息、教育信息（小学、初中、高中、大学、硕士、博士、博士后）、(qq、手机、邮箱、微博、微信、支付宝、)、等级、积分、注册时间
    //账号安全：昵称、id、手机、邮箱、证件信息、
    //通用设置：
    //通知设置：
    /**设置默认项*/
    func SetDefalts()  {
        /** 是否登录 - 用于程序启动时是否需要调起登录注册页面*/
        Settssssss(DATA:false, FORKEY: "islogin")
        /** 一下是手机默认设置部分*/
        /** */
        
    }
    
    //MARK: - 更改设置
    /** 写数据到 UserDefaults */
    func Settssssss(DATA:String,FORKEY:String) {
        UserDefaults.standard.set(DATA,forKey:FORKEY)
        UserDefaults.standard.synchronize()
    }
    func Settssssss(DATA:Bool,FORKEY:String) {
        UserDefaults.standard.set(DATA,forKey:FORKEY)
        UserDefaults.standard.synchronize()
    }
    func Settssssss(DATA:Int,FORKEY:String) {
        UserDefaults.standard.set(DATA,forKey:FORKEY)
        UserDefaults.standard.synchronize()
    }
    func Settssssss(DATA:Double,FORKEY:String) {
        UserDefaults.standard.set(DATA,forKey:FORKEY)
        UserDefaults.standard.synchronize()
    }
    func Settssssss(DATA:Float,FORKEY:String) {
        UserDefaults.standard.set(DATA,forKey:FORKEY)
        UserDefaults.standard.synchronize()
    }
    
    //MARK: - ReadDetalts
    /**读取 Defalts*/
    func ReadDefalts_Bool(KEY:String) -> Bool? {
        return UserDefaults.standard.value(forKey: KEY) as? Bool
    }
    func ReadDefalts_String(KEY:String) -> String? {
        return UserDefaults.standard.value(forKey: KEY) as? String
    }
    func ReadDefalts_Int(KEY:String) -> Int? {
        return UserDefaults.standard.value(forKey: KEY) as? Int
    }
    func ReadDefalts_Double(KEY:String) -> Double? {
        return UserDefaults.standard.value(forKey: KEY) as? Double
    }
    func ReadDefalts_Float(KEY:String) -> Float? {
        return UserDefaults.standard.value(forKey: KEY) as? Float
    }
}
