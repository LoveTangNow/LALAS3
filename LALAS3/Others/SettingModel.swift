//
//  SettingModel.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/10/21.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import Foundation


class SettingModel_DefaltsAccount: AnyObject {
    
    let list  =  [["用户昵称 和 头像","性别","所在地","生日","用户简介"],["工作信息"], ["教育信息","小学","初中","高中","大学","硕士","博士","博士后"], ["绑定","邮箱","手机","QQ","微博","微信","支付宝"],["其他","等级","积分","注册时间"]]
    
    /** 是否登录 - 用于程序启动时是否需要调起登录注册页面*/
    var islogin = Defalts_ReadWrite().ReadDefalts_Bool(KEY: "islogin")
    /** 昵称 ------------ 登录完成时设置*/
    /** id ------------- 登录完成时设置*/
    /** 性别 Bool :true表示男;false表示女*/
    var sex = Defalts_ReadWrite().ReadDefalts_Bool(KEY: "sex")
    /** 生日 Int*/
    var birthday_year = Defalts_ReadWrite().ReadDefalts_String(KEY: "birthday_year")
    var birthday_month = Defalts_ReadWrite().ReadDefalts_String(KEY: "birthday_month")
    var birthday_day = Defalts_ReadWrite().ReadDefalts_String(KEY: "birthday_day")
    /** 简介 String*/
    var introduction = Defalts_ReadWrite().ReadDefalts_String(KEY: "introduction")
    /** 工作信息 String*/
    var work = Defalts_ReadWrite().ReadDefalts_String(KEY: "work")
    /** 居住地 String*/
    var province = Defalts_ReadWrite().ReadDefalts_String(KEY: "province")
    var municipality = Defalts_ReadWrite().ReadDefalts_String(KEY: "municipality")
    var county = Defalts_ReadWrite().ReadDefalts_String(KEY: "county")
    /** 家乡 String*/
    var province_home = Defalts_ReadWrite().ReadDefalts_String(KEY: "province_home")
    var municipality_home = Defalts_ReadWrite().ReadDefalts_String(KEY: "municipality_home")
    var county_home = Defalts_ReadWrite().ReadDefalts_String(KEY: "county_home")
    /** 教育 String*/
    var primary = Defalts_ReadWrite().ReadDefalts_String(KEY: "primary")
    var middle = Defalts_ReadWrite().ReadDefalts_String(KEY: "middle")
    var j_middle = Defalts_ReadWrite().ReadDefalts_String(KEY: "j_middle")
    var university = Defalts_ReadWrite().ReadDefalts_String(KEY: "university")
    /** 绑定 String*/
    var phone = Defalts_ReadWrite().ReadDefalts_String(KEY: "phone")
    var email = Defalts_ReadWrite().ReadDefalts_String(KEY: "email")
    var qq    = Defalts_ReadWrite().ReadDefalts_String(KEY: "qq")
    var weibo  = Defalts_ReadWrite().ReadDefalts_String(KEY: "weibo")
    var wechat = Defalts_ReadWrite().ReadDefalts_String(KEY: "wechat")
    var alipay = Defalts_ReadWrite().ReadDefalts_String(KEY: "alipay")
    /** 等级 Int*/
    var level = Defalts_ReadWrite().ReadDefalts_Int(KEY: "level")
    /** 积分 Int*/
    var score = Defalts_ReadWrite().ReadDefalts_Int(KEY: "score")
    /**注册时间 Int*/
    var register_year = Defalts_ReadWrite().ReadDefalts_Int(KEY: "register_year")
    var register_month = Defalts_ReadWrite().ReadDefalts_Int(KEY: "register_month")
    var register_day = Defalts_ReadWrite().ReadDefalts_Int(KEY: "register_day")
    
    /** 证件信息*/
    var zhengjian = Defalts_ReadWrite().ReadDefalts_String(KEY: "zhengjian")
    
    func Set() -> () {
        
    }
    
    func Get () ->() {
        
    }
    
}
class  SettingModel_TongYong: AnyObject {
    /**图片下载质量 Int：1、2、3、4（低画质、中画质、高画质、原画）*/
    var imagelevel_d = Defalts_ReadWrite().ReadDefalts_Int(KEY: "imagelevel_d")
    /**图片上传画质 Int：1、2、3、4（低画质、中画质、高画质、原画）*/
    var imagelevel_u = Defalts_ReadWrite().ReadDefalts_Int(KEY: "imagelevel_u")
    /**视频播放模式 Int：1、2、3（wifi 自动播放，任何情况自动播放，关闭自动播放））*/
    var videomode = Defalts_ReadWrite().ReadDefalts_Int(KEY: "videomode")
    /**声音 Bool*/
    var voice = Defalts_ReadWrite().ReadDefalts_Bool(KEY: "voice")
    /**语言*/
    var language = Defalts_ReadWrite().ReadDefalts_String(KEY: "language")
    
    func Set() -> () {
        
    }
}

class SettingModel_TongZhi: AnyObject {
    /**是否开启通知 bool*/
    var tongzhiok =  Defalts_ReadWrite().ReadDefalts_Bool(KEY: "tongzhiok")
    /**多久获取一次新消息 Int：分钟*/
    var time = Defalts_ReadWrite().ReadDefalts_Int(KEY: "time")
    
    func Set() -> () {
        
    }
}
