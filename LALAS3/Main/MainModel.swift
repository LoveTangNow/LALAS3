//
//  MainModel.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/10/1.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import Foundation
import UIKit


/**动态ViewModel*/
class FirstPageModel {
    //MARK: - Data
    /**用户编号*/
    var newsID = [Dictionary<String,Int>]()
    /**发送者编号*/
    var senderID = [Dictionary<String,Int>]()
    /**发送者头像*/
    var senderIcon = [Dictionary<String,String>]()
    /**发送者昵称*/
    var senderName = [Dictionary<String,String>]()
    /**发送时间*/
    var sendTime = [Dictionary<String,String>]()
    /**发送设备*/
    var sendDevice = [Dictionary<String,String>]()
    /**细节文字*/
    var detailWords = [Dictionary<String,String>]()
    /**图片数目*/
    var photoNumber = [Dictionary<String,Int>]()
    /**图片组*/
    var photoList = [Dictionary<String,[String]>]()
    
    /**转发数目*/
    var numberZhuan = [Dictionary<String,Int>]()
    /**评论数目*/
    var numberPinglun = [Dictionary<String,Int>]()
    /**赞数目*/
    var numberZan = [Dictionary<String,Int>]()
    //////////////////////////////////////////////////////纯粹的一组 News 信息///////////////////////////////////////////////////////////////////
    
    var gotDataFromServer = false
    
    /**模型中添加数据，所有的数据。每次添加一组数据*/
    func AppendInformation(newsID_:Int,senderID_:Int,senderIcon_:String,senderName_:String,sendTime_:String,sendDevice_:String,detailWords_:String,photoNumber_:Int,photoList_:[String],numberZhuan_:Int,numberPinglun_:Int,numberZan_:Int) {
        newsID[newsID.count] = ["newsID":newsID_]
        senderID[senderID.count] = ["senderID":senderID_]
        senderIcon[senderIcon.count] = ["senderIcon":senderIcon_]
        senderName[senderName.count] = ["senderName":senderName_]
        sendTime[sendTime.count] = ["sendTime":sendTime_]
        sendDevice[sendDevice.count] = ["sendDevice":sendDevice_]
        detailWords[detailWords.count] = ["detailWords":detailWords_]
        photoNumber[photoNumber.count] = ["photoNumber":photoNumber_]
        photoList[photoList.count] = ["photoList":photoList_]
        
        numberZhuan[numberZhuan.count] = ["numberZhuan":numberZhuan_]
        numberPinglun[numberPinglun.count] = ["numberPinglun":numberPinglun_]
        numberZan[numberZan.count] = ["numberZan":numberZan_]
    }
    
    //MARK: - API?
}

/**消息ViewModel*/
class SecondPageModel {
    //MARK: - Data
    
    //MARK: - API?
    
}

/**推荐ViewModel*/
class ThridPageModel {
    //MARK: - Data
    
    
    //MARK: - API?
    
}

/**我的ViewModel*/
class FourthPageModel {
    //MARK: - Data
    
    //MARK: - API?
    
}
