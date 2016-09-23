//
//  T_ViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/9/22.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class T_ViewController: UIViewController {

    var list = [UIImage]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // 取出cache文件夹路径
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        // 打印路径,需要测试的可以往这个路径下放东西
        print(cachePath)
        // 取出文件夹下所有文件数组
        let files = FileManager.default.subpaths(atPath: cachePath!)
        // 用于统计文件夹内所有文件大小
        var big = Int();
                
                
        // 快速枚举取出所有文件名
        for p in files!{
        // 把文件名拼接到路径中
            let path = cachePath!.appendingFormat("/\(p)")
            // 取出文件属性
            let floder = try! FileManager.default.attributesOfItem(atPath: path)
            // 用元组取出文件大小属性
            for (abc,bcd) in floder {
                // 只去出文件大小进行拼接
                if abc == FileAttributeKey.size{
                    big += (bcd as AnyObject).integerValue
                }
            }
        }
                
        // 提示框
        let message = "\(big/(1024*1024))M缓存"
        let alert = UIAlertController(title: "清除缓存", message: message, preferredStyle: UIAlertControllerStyle.alert)
                
        let alertConfirm = UIAlertAction(title: "确定", style: UIAlertActionStyle.default) { (alertConfirm) -> Void in
            // 点击确定时开始删除
            for p in files!{
                // 拼接路径
                let path = cachePath!.appendingFormat("/\(p)")
                // 判断是否可以删除
                if(FileManager.default.fileExists(atPath: path)){
                    // 删除
                    try! FileManager.default.removeItem(atPath: path)
                }
            }
        }
        alert.addAction(alertConfirm)
        let cancle = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { (cancle) -> Void in
                    
        }
        alert.addAction(cancle)
        // 提示框弹出
        present(alert, animated: true) { () -> Void in
            
        }
        
        /*
        let a = #imageLiteral(resourceName: "archive-vector")
        let b = #imageLiteral(resourceName: "back-vector")
        let c = #imageLiteral(resourceName: "charge-battery-vector")
        let d = #imageLiteral(resourceName: "down-vector")
        let e = #imageLiteral(resourceName: "edit-vector")
        let f = #imageLiteral(resourceName: "flag-vector")
        
        //[<UIImage: 0x600000284d80>, {30, 30}, <UIImage: 0x618000282fd0>, {30, 30}, <UIImage: 0x618000282e90>, {30, 30}, <UIImage: 0x600000284dd0>, {30, 30}, <UIImage: 0x600000285000>, {30, 30}, <UIImage: 0x60800009e5a0>, {30, 30}]
        list.insert(a, at: 0)
        
        print(list.count)
        print(list)
        
        list.insert(b, at: 1)
        
        print(list.count)
        print(list)
        
        list.append(c)
        
        print(list.count)
        print(list)
        
        list.append(d)
        
        print(list.count)
        print(list)
        
        list.append(e)
        
        print(list.count)
        print(list)
        
        list.append(f)
        
        print(list.count)
        print(list)
        
        */
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
