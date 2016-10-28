//
//  Health_ViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/9/28.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit
import HealthKit
import CoreData

class Health_ViewController: UIViewController {
    
    @IBAction func add(_ sender: UIButton) {
        AddData(id: 1, detail: "11")
        AddData(id: 2, detail: "22")
        AddData(id: 3, detail: "33")
        AddData(id: 4, detail: "44")
        AddData(id: 5, detail: "55")
    }
    
    @IBAction func delete_(_ sender: UIButton) {
        DeleteData(id: 1)
    }

    @IBAction func change(_ sender: UIButton) {
    }
    
    @IBAction func check(_ sender: UIButton) {
        CheckData(id: 1)
        CheckData(id: 4)
        CheckDataall()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    /**增 存储Person*/
    func AddData(id:Int, detail:String){
        let context = getContext()
        // 定义一个entity，这个entity一定要在xcdatamodeld中做好定义
        let entity = NSEntityDescription.entity(forEntityName: "News", in: context)
        let person = NSManagedObject(entity: entity!, insertInto: context)
        person.setValue(id, forKey: "senderId")
        person.setValue(detail, forKey: "detail")
        do {
            try context.save()
            print("saved")
        }catch{
            print(error)
        }
    }
    
    /**查 获取某一entity的所有数据*/
    func CheckData(id:Int){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            for p in (searchResults as! [NSManagedObject]){
                if (p.value(forKey: "senderId") as! Int) == id {
                    print("name:  \(p.value(forKey: "senderId")!) age: \(p.value(forKey: "detail")!)")
                }
            }
        } catch  {
            print(error)
        }
    }
    
    func DeleteData(id:Int){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            for p in (searchResults as! [NSManagedObject]){
                if (p.value(forKey: "senderId") as! Int) == id {
                    p.managedObjectContext?.delete(p)
                    print("name:  \(p.value(forKey: "senderId")!) age: \(p.value(forKey: "detail")!)")
                }
            }
        } catch  {
            print(error)
        }
    }
    
    
    func ChangeData(id:Int){
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

    func CheckDataall(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
        do {
            
            let searchResults = try getContext().fetch(fetchRequest)
            print("--------all--------")
            print("numbers of \(searchResults.count)")
            for p in (searchResults as! [NSManagedObject]){
                print("name:  \(p.value(forKey: "senderId")!) age: \(p.value(forKey: "detail")!)")
            }
        } catch  {
            print(error)
        }
    }
}
