//
//  GotServer.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/10/19.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import Foundation

class GotServers: AnyObject {
    //MARK: - GotServerAliScripts
    /**获取阿里服务器脚本路径*/
    func GotServerAliScripts() -> String {
        let diaryList:String = Bundle.main.path(forResource: "/Server", ofType:"plist")!
        let data:NSMutableDictionary = NSMutableDictionary(contentsOfFile:diaryList)!
        return data.object(forKey: "ServerAliScripts") as! String
    }
    
    //MARK: - GotServer
    /**获取根路径 阿里 或者 本地*/
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
    /**获取 Icon 目录*/
    func GotImageIconServer(ai:Bool) -> String {
        let diaryList:String = Bundle.main.path(forResource: "/Server", ofType:"plist")!
        let data:NSMutableDictionary = NSMutableDictionary(contentsOfFile:diaryList)!
        let a = data.object(forKey: "ImageIcon") as! String
        return GotServer(ai: ai) + a
    }
    
    //MARK: - GotImageTServer
    /**获取 测试图片 目录*/
    func GotImageTServer(ai:Bool) -> String {
        let diaryList:String = Bundle.main.path(forResource: "/Server", ofType:"plist")!
        let data:NSMutableDictionary = NSMutableDictionary(contentsOfFile:diaryList)!
        let a = data.object(forKey: "ImageT") as! String
        return GotServer(ai: ai) + a
    }
    //MARK: - GotImageMainServer
    /**获取 主图片目录 目录*/
    func GotImageMainServer(ai:Bool) -> String {
        let diaryList:String = Bundle.main.path(forResource: "/Server", ofType:"plist")!
        let data:NSMutableDictionary = NSMutableDictionary(contentsOfFile:diaryList)!
        let a = data.object(forKey: "ImageMain") as! String
        return GotServer(ai: ai) + a
        
    }
    //MARK: - GotImageADServer
    /**获取 广告图片 目录*/
    func GotImageADServer(ai:Bool) -> String {
        let diaryList:String = Bundle.main.path(forResource: "/Server", ofType:"plist")!
        let data:NSMutableDictionary = NSMutableDictionary(contentsOfFile:diaryList)!
        let a = data.object(forKey: "ImageAD") as! String
        return GotServer(ai: ai) + a
    }

}
