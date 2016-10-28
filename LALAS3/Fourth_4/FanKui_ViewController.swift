//
//  FanKui_ViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/18.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit
import Alamofire

class FanKui_ViewController: UIViewController {

    @IBOutlet weak var imaget: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let a  = ["9","3","6","4","7"]
        let bb  = [9,3,6,4,7]
        
        let b  = Paixu().Diclike(ID: bb, Date: a)
        for i  in b.0{
            print(i)
        }
        for i  in b.1{
            print(i)
        }
        
        
        
        //Home目录
        let homeDirectory = NSHomeDirectory()
        print(homeDirectory)
        //Documents目录 苹果建议将程序中建立的或在程序中浏览到的文件数据保存在该目录下，iTunes备份和恢复的时候会包含此目录
        let documentPaths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentPath = documentPaths[0]
        print(documentPath)
        //let documentPath = homeDirectory + "/Documents"
        
        //Library目录  这个目录下有2个子目录：Caches缓存 , Preferences偏好设置,不应该直接创建偏好设置文件而使用NSUserDefaults类
        let libraryPaths =  NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let libraryPath = libraryPaths[0]
        print(libraryPath)
        //let libraryPath = homeDirectory + "/Library"
        
        //Cache目录 主要存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出时删除
        let cachesPaths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let cachesPath = cachesPaths[0]
        print(cachesPath)
        //let cachesPath = homeDirectory + "/Library/Caches"
        
        //tmp目录  用于存放临时文件，保持应用程序再次启动过程中不需要的信息，重启后清空
        let tmpDir = NSTemporaryDirectory()
        print(tmpDir)
        //let tmpDir = homeDirectory + "/tmp"
        
        
        let mydir1 = NSHomeDirectory() + "/Documents/myfolder/images"
        
        let data1 : NSData = UIImagePNGRepresentation(#imageLiteral(resourceName: "Black"))! as NSData
        data1.write(toFile: cachesPath + "/2.jpg", atomically: true)
        
        let image = UIImage.init(contentsOfFile:  cachesPath + "/2.jpg")
        imaget.image = allll()
        print("in")
        

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func allll () -> UIImage {
        var im = UIImage()
        Alamofire.request(GotServers().GotImageTServer(ai: true) + "10.jpeg")
            .responseData { response in
                if let data = response.result.value {
                    let asd = UIImage(data: data)
                    im = asd!
                    print("al")
                }
        }
        return im
    }
    
}
