//
//  MyCoreData.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/10/28.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit
import Foundation
import CoreData


class MyCoreData: AnyObject {
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    //拿到一条数据 我们首先用这个 newsid 来查询（check） coredata 如果有的话！！！升级（update：delete & rewrite）！！如果没有写入（write），只有这两个选择。。
    func AddData_News_Reall(senderId:Int,height:Float,detail:String,device:String,
                image1:String?,image2:String?,image3:String?,image4:String?,image5:String?,image6:String?,image7:String?,image8:String?,image9:String?,
                senderName:String,sendTime:String,saved:Bool) {
        if  CheckExit_(senderId: senderId) {//存在了 升级（update：delete & rewrite）！！
            UpDate_News(senderId: senderId, height: height, detail: detail, device: device, image1: image1, image2: image2, image3: image3, image4: image4, image5: image5, image6: image6, image7: image7, image8: image8, image9: image9, senderName: senderName, sendTime: sendTime, saved: saved)
        }
        else{//没有 写入（write），
            AddData_News(senderId: senderId, height: height, detail: detail, device: device, image1: image1, image2: image2, image3: image3, image4: image4, image5: image5, image6: image6, image7: image7, image8: image8, image9: image9, senderName: senderName, sendTime: sendTime, saved: saved)
        }
        
    }
    /*
     senderId int32
     height float
     detail string
     device string
     image1~9 string
     senderName string
     sendTime string
     saved bool
     */
    /** 增 */
    
    private func CheckExit_(senderId:Int) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            //print("numbers of \(searchResults.count)")
            for p in (searchResults as! [NSManagedObject]){
                if ( p.value(forKey: "senderId") as! Int) == senderId {
                    print(1)
                    return true
                }
                //print("name:  \(p.value(forKey: "id")!) age: \(p.value(forKey: "detail")!)")
            }
            print(2)
            return false
        } catch  {
            print(3)
            return false
        }
    }
    private func AddData_News(senderId:Int,height:Float,detail:String,device:String,
            image1:String?,image2:String?,image3:String?,image4:String?,image5:String?,image6:String?,image7:String?,image8:String?,image9:String?,
            senderName:String,sendTime:String,saved:Bool){
        let context = getContext()
        // 定义一个entity，这个entity一定要在xcdatamodeld中做好定义
        let entity = NSEntityDescription.entity(forEntityName: "News", in: context)
        let person = NSManagedObject(entity: entity!, insertInto: context)
        person.setValue(senderId, forKey: "senderId")
        person.setValue(height, forKey: "height")
        person.setValue(detail, forKey: "detail")
        person.setValue(device, forKey: "device")
        
        person.setValue(image1, forKey: "image1")
        person.setValue(image2, forKey: "image2")
        person.setValue(image3, forKey: "image3")
        person.setValue(image4, forKey: "image4")
        person.setValue(image5, forKey: "image5")
        person.setValue(image6, forKey: "image6")
        person.setValue(image7, forKey: "image7")
        person.setValue(image8, forKey: "image8")
        person.setValue(image9, forKey: "image9")
        
        person.setValue(senderName, forKey: "senderName")
        person.setValue(sendTime, forKey: "sendTime")
        person.setValue(saved, forKey: "saved")
        
        do {
            try context.save()
            print("saved")
        }catch{
            print(error)
        }
    }
    
    private func UpDate_News(senderId:Int,height:Float,detail:String,device:String,
            image1:String?,image2:String?,image3:String?,image4:String?,image5:String?,image6:String?,image7:String?,image8:String?,image9:String?,
            senderName:String,sendTime:String,saved:Bool) {
        //delete
        Delete_News(senderId: senderId)
        //write
        AddData_News(senderId: senderId, height: height, detail: detail, device: device, image1: image1, image2: image2, image3: image3, image4: image4, image5: image5, image6: image6, image7: image7, image8: image8, image9: image9, senderName: senderName, sendTime: sendTime, saved: saved)
    }
    
    private func Delete_News(senderId:Int)  {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            for p in (searchResults as! [NSManagedObject]){
                if (p.value(forKey: "senderId") as! Int) == senderId {
                    p.managedObjectContext?.delete(p)
                }
            }
        } catch  {
            print(error)
        }
    }
    
    func ReadAData_News(senderId:Int) ->() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            //print("numbers of \(searchResults.count)")
            for p in (searchResults as! [NSManagedObject]){
                if (p.value(forKey: "senderId") as! Int) == senderId {
                    //senderId: senderId, height: height, detail: detail, device: device, image1: image1, image2: image2, image3: image3, image4: image4, image5: image5, image6: image6, image7: image7, image8: image8, image9: image9, senderName: senderName, sendTime: sendTime, saved: saved)
                    //对于 bool 值     false->0     true->1
                    print("senderId:  \(p.value(forKey: "senderId")!) ,device: \(p.value(forKey: "device")!),saved: \(p.value(forKey: "saved")!)")
                }
            }
        } catch  {
            print(error)
        }
    }
    //--------------------------------------------------------------------------------------
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /** 查 */
    func CheckData_News(senderId:Int) -> Bool{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            //print("numbers of \(searchResults.count)")
            for p in (searchResults as! [NSManagedObject]){
                if (p.value(forKey: "senderId") as! Int) == senderId {
                    print("name:  \(p.value(forKey: "id")!) age: \(p.value(forKey: "detail")!)")
                }
            }
        } catch  {
            print(error)
        }
        
        return  true
    }
    
    /** 删 */
    func DeleteData_News(id:Int){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            for p in (searchResults as! [NSManagedObject]){
                if (p.value(forKey: "id") as! Int) == id {
                    p.managedObjectContext?.delete(p)
                    print("name:  \(p.value(forKey: "id")!) age: \(p.value(forKey: "detail")!)")
                }
            }
        } catch  {
            print(error)
        }
    }
    
    /** 改 */
    func ChangeData_News(id:Int){
        //转换一下可以先删除 后添加。
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            for p in (searchResults as! [NSManagedObject]){
                if (p.value(forKey: "id") as! Int) == id {
                    print("name:  \(p.value(forKey: "id")!) age: \(p.value(forKey: "detail")!)")
                }
            }
        } catch  {
            print(error)
        }
    }
    
    /** all */
    func CheckDataall_News(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            print("--------all--------")
            print("numbers of \(searchResults.count)")
            for p in (searchResults as! [NSManagedObject]){
                print("name:  \(p.value(forKey: "id")!) age: \(p.value(forKey: "detail")!)")
            }
        } catch  {
            print(error)
        }
    }
    
    func CheckNumber(entityName:String)  {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            print("numbers of \(searchResults.count)")
        } catch  {
            print(error)
        }

    }
    
    func DeleteAll(entityName:String)  {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            for p in (searchResults as! [NSManagedObject]){
                p.managedObjectContext?.delete(p)
            }
        } catch  {
            print(error)
        }
    }

}
