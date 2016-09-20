//
//  SecondViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/14.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit
import CoreData

import RealmSwift

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "消息"
        
        
        //let newItem = NSEntityDescription.entityForName("RR", inManagedObjectContext: self.managedObjectContext!)
        
        /*
        let diaryList:String = Bundle.main.path(forResource: "/Server", ofType:"plist")!
        let data:NSMutableDictionary = NSMutableDictionary(contentsOfFile:diaryList)!
        print(data.object(forKey: "ServerImageT") as! String)
        
        
        let array = NSArray(objects: "hangge.com","baidu.com","google.com","163.com","qq.com")
        let filePath:String = NSHomeDirectory() + "/Documents/webs.plist"
        array.write(toFile: filePath, atomically: true)
        
        
        let webs = NSArray(contentsOfFile: NSHomeDirectory() + "/Documents/webs.plist")
        let url = webs![(webs?.count)! - 1] as! String
        print(url)
         */
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
