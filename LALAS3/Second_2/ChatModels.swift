//
//  ChatModel.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/10/5.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import Foundation

enum InformationTypes {
    case WORDS
    case PHOTO
    case VOICE
    case VIDEO
    case BQ
}

class chatmodel {
    /*
     需要存储的信息有：
        信息的 ID ，
        信息的发送时间，
        信息的 senderID,
        sender 的昵称，
        sender 的头像,
        信息的种类（文字、图片、音频、视频），
        信息的内容
     总计3组信息 ，用三个字典 组成的一个数组 cell 来存储
     */

    /** 信息的 ID*/
    var newsIDs = [String]()
    /** 发送时间*/
    var SendTime = [String]()
    /** 发送者的  id*/
    var SenderIDs = [String]()
    /** 发送者的昵称*/
    var SenderNames = [String]()
    /** 发送者的头像*/
    var SenderIcons = [InformationTypes]()
    /** 信息的种类：文字、图片、声音、视频、表情*/
    var informationTypes = [InformationTypes]()
    /** 信息的具体细节*/
    var newsDetail = [String]()

}
