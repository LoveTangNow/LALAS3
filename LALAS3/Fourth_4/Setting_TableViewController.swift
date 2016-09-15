//
//  Setting_TableViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/15.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class Setting_TableViewController: UITableViewController {
    
    //MARK: - 变量 绑定
    
    //肌肤默认的图片
    var Imageload_Black:UIImage = UIImage(named: "Black.png")!
    var Imageload_Wight:UIImage = UIImage(named: "White.png")!
    
    //MARK: - FUNCTIONS
    let SettingLists1 = ["账号管理","账号安全"]
    let SettingLists2 = ["通用设置","通知"]
    let SettingLists3 = ["清理缓存","意见反馈","关于我们"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "设置"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Tableview
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Photo_Lable_TableViewCell", for: indexPath) as! Photo_Lable_TableViewCell
            
            cell.UIImageView_Main.image = Imageload_Black
            cell.UILabel_Main.text = SettingLists1[indexPath.row]
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Photo_Lable_TableViewCell", for: indexPath) as! Photo_Lable_TableViewCell
            
            cell.UIImageView_Main.image = Imageload_Black
            cell.UILabel_Main.text = SettingLists2[indexPath.row]
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Photo_Lable_TableViewCell", for: indexPath) as! Photo_Lable_TableViewCell
            
            cell.UIImageView_Main.image = Imageload_Black
            cell.UILabel_Main.text = SettingLists3[indexPath.row]
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Lable_Center_TableViewCell", for: indexPath) as! Lable_Center_TableViewCell
            
            cell.UILabel_Main.text = "退出此账号"
            
            return cell
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return SettingLists1.count
        case 1:
            return SettingLists2.count
        case 2:
            return SettingLists3.count
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0,1,2:
            return 15
        default:
            return 0
        }
    }


}
