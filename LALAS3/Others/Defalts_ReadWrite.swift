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
    /**设置账户信息默认项*/
    func SetDefaltsAccount() ->() {
        /** 是否登录 - 用于程序启动时是否需要调起登录注册页面*/
        //Settssssss(DATA:false, FORKEY: "islogin")
        /**昵称 ------------ user_name 登录完成时设置*/
        /**id ------------- user_id登录完成时设置*/
        /**性别 Bool :true表示男;false表示女*/
        Settssssss(DATA: true, FORKEY: "sex")
        /**生日 Int*/
        Settssssss(DATA: 1994, FORKEY: "birthday_year")
        Settssssss(DATA: 9, FORKEY: "birthday_month")
        Settssssss(DATA: 6, FORKEY: "birthday_day")
        /**简介 String*/
        Settssssss(DATA: "", FORKEY: "introduction")
        /**工作信息 String*/
        Settssssss(DATA: "", FORKEY: "work")
        /**居住地 String*/
        Settssssss(DATA: "北京", FORKEY: "province")
        Settssssss(DATA: "北京", FORKEY: "municipality")
        Settssssss(DATA: "北京", FORKEY: "county")
        /**家乡 String*/
        Settssssss(DATA: "北京", FORKEY: "province_home")
        Settssssss(DATA: "北京", FORKEY: "municipality_home")
        Settssssss(DATA: "北京", FORKEY: "county_home")
        /** 教育 String*/
        Settssssss(DATA: "", FORKEY: "primary")
        Settssssss(DATA: "", FORKEY: "middle")
        Settssssss(DATA: "", FORKEY: "j_middle")
        Settssssss(DATA: "", FORKEY: "university")
        /** 绑定 String*/
        Settssssss(DATA: "", FORKEY: "phone")
        Settssssss(DATA: "", FORKEY: "email")
        Settssssss(DATA: "", FORKEY: "qq")
        Settssssss(DATA: "", FORKEY: "weibo")
        Settssssss(DATA: "", FORKEY: "wechat")
        Settssssss(DATA: "", FORKEY: "alipay")
        /**等级 Int*/
        Settssssss(DATA: 0, FORKEY: "level")
        /**积分 Int*/
        Settssssss(DATA: 0, FORKEY: "score")
        /**注册时间 Int*/
        Settssssss(DATA: 2000, FORKEY: "register_year")
        Settssssss(DATA: 1, FORKEY: "register_month")
        Settssssss(DATA: 1, FORKEY: "register_day")
        
        /**证件信息*/
        Settssssss(DATA: "", FORKEY: "zhengjian")
        
    }
    //通用设置：
    func SetDefalts_TongYong() -> () {
        /**图片下载质量 Int：1、2、3、4（低画质、中画质、高画质、原画）*/
        Settssssss(DATA: 2, FORKEY: "imagelevel_d")
        /**图片上传画质 Int：1、2、3、4（低画质、中画质、高画质、原画）*/
        Settssssss(DATA: 2, FORKEY: "imagelevel_u")
        /**视频播放模式 Int：1、2、3（wifi 自动播放，任何情况自动播放，关闭自动播放））*/
        Settssssss(DATA: 1, FORKEY: "videomode")
        /**声音 Bool*/
        Settssssss(DATA: false, FORKEY: "voice")
        /**语言*/
        Settssssss(DATA: "ZN_CH", FORKEY: "language")
    }
    //通知设置：
    func SetDefalts_TongZhi() -> () {
        /**是否开启通知 bool*/
        Settssssss(DATA: true, FORKEY: "tongzhiok")
        /**多久获取一次新消息 Int：分钟*/
        Settssssss(DATA: 2, FORKEY: "time")
    }
    
    //MARK: - 读取设置
    func ReadDefaltsAccount() -> (Dictionary<String,AnyObject>){
        let willReturn  = Dictionary<String,AnyObject>()
        
        return willReturn
    }
    
    //MARK: - 更改设置
    /** 写数据到 UserDefaults */
    func Settssssss(DATA:String,FORKEY:String) {
        if let a  = UserDefaults.standard.value(forKey: FORKEY) as? String {
            UserDefaults.standard.set(a,forKey:FORKEY)
            UserDefaults.standard.synchronize()
        }
    }
    func Settssssss(DATA:Bool,FORKEY:String) {
        if let a  = UserDefaults.standard.value(forKey: FORKEY) as? Bool {
            UserDefaults.standard.set(a,forKey:FORKEY)
            UserDefaults.standard.synchronize()
        }
    }
    func Settssssss(DATA:Int,FORKEY:String) {
        if let a  = UserDefaults.standard.value(forKey: FORKEY) as? Bool {
            UserDefaults.standard.set(a,forKey:FORKEY)
            UserDefaults.standard.synchronize()
        }
    }
    func Settssssss(DATA:Double,FORKEY:String) {
        if let a  = UserDefaults.standard.value(forKey: FORKEY) as? Bool {
            UserDefaults.standard.set(a,forKey:FORKEY)
            UserDefaults.standard.synchronize()
        }
    }
    func Settssssss(DATA:Float,FORKEY:String) {
        if let a  = UserDefaults.standard.value(forKey: FORKEY) as? Bool {
            UserDefaults.standard.set(a,forKey:FORKEY)
            UserDefaults.standard.synchronize()
        }
    }
    
    func Settssssss_h(DATA:String,FORKEY:String) {
            UserDefaults.standard.set(DATA,forKey:FORKEY)
            UserDefaults.standard.synchronize()
    }
    func Settssssss_h(DATA:Bool,FORKEY:String) {
            UserDefaults.standard.set(DATA,forKey:FORKEY)
            UserDefaults.standard.synchronize()
    }
    func Settssssss_h(DATA:Int,FORKEY:String) {
            UserDefaults.standard.set(DATA,forKey:FORKEY)
            UserDefaults.standard.synchronize()
    }
    func Settssssss_h(DATA:Double,FORKEY:String) {
            UserDefaults.standard.set(DATA,forKey:FORKEY)
            UserDefaults.standard.synchronize()
    }
    func Settssssss_h(DATA:Float,FORKEY:String) {
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
    
    func CleanWhereIFrom() -> () {
        Settssssss_h(DATA: "", FORKEY: "whereifrom")
    }
}
