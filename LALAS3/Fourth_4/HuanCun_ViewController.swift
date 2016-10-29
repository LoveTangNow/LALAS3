//
//  HuanCun_ViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/18.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class HuanCun_ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myTableView.delegate = self
        myTableView.dataSource = self
        
        ConnectNib()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Defalts_ReadWrite().Settssssss_h(DATA: "HuanCun_ViewController", FORKEY: "whereifrom")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableView
    @IBOutlet weak var myTableView: UITableView!
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch indexPath.row {
        case 0:
            let alertController = UIAlertController(title: "系统提示",
                                                    message: "确定要清楚缓存嘛？",
                                                    preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "好的", style: .default, handler: {
                action in
                self.clearCache()
                _ = self.popoverPresentationController
            })
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        case 2:
            MyCoreData().DeleteAll(entityName: "News")
            _ = MyCoreData().CheckNumber(entityName: "News")
        case 3:
            MyCoreData().DeleteAll(entityName: "News")
            _ = MyCoreData().CheckNumber(entityName: "News")
        default:
           break
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OnlyOneLabel_TableViewCell", for: indexPath) as! OnlyOneLabel_TableViewCell
        switch indexPath.row {
        case 0:
            cell.UILabel_M.text = "清理缓存 缓存大小是：" + String(fileSizeOfCache()) + "MB"
        case 1:
            cell.UILabel_M.text = ""//"测试1"
        case 2:
            cell.UILabel_M.text = ""//"清空 News 数据"
        default:
            cell.UILabel_M.text = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //MARK: - Functions
    func ConnectNib() {
        myTableView.register(UINib(nibName: "OnlyOneLabel_TableViewCell", bundle: nil), forCellReuseIdentifier: "OnlyOneLabel_TableViewCell")
    }
    
    func fileSizeOfCache()-> Int {
        
        // 取出cache文件夹目录 缓存文件都在这个目录下
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        // 取出文件夹下所有文件数组
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        //快速枚举出所有文件名 计算文件大小
        var size = 0
        for file in fileArr! {
            // 把文件名拼接到路径中
            let path = cachePath! + "/\(file)"
            // 取出文件属性
            let floder = try! FileManager.default.attributesOfItem(atPath: path)
            // 用元组取出文件大小属性
            for (abc, bcd) in floder {
                // 累加文件大小
                if abc == FileAttributeKey.size {
                    size += (bcd as AnyObject).integerValue
                }
            }
        }
        let mm = size / 1024 / 1024
        return mm
    }
    
    func clearCache() {
        // 取出cache文件夹目录 缓存文件都在这个目录下
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        // 取出文件夹下所有文件数组
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        // 遍历删除
        for file in fileArr! {
            let path = cachePath! + "/\(file)"
            if FileManager.default.fileExists(atPath: path) {
                do {
                    try FileManager.default.removeItem(atPath: path)
                } catch {
                }
            }
        }
    }
    
}
