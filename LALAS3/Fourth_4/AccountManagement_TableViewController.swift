//
//  AccountManagement_TableViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/18.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class AccountManagement_TableViewController: UITableViewController {
    
    var TableviewHeight:CGFloat = 0
    
    var Imageload_Black:UIImage = UIImage(named: "Black.png")!

    var list1 = ["用户昵称 和 头像","性别","所在地","生日","用户简介"]
    var list2 = ["工作信息"]
    var list3 = ["教育信息","大学","初中","小学等"]
    var list4 = ["邮箱","手机","QQ","微博","微信","支付宝"]
    var list5 = ["等级","积分","注册时间"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0://头像 昵称
                let cell = tableView.dequeueReusableCell(withIdentifier: "AccountManagement_M_TableViewCell", for: indexPath) as! AccountManagement_M_TableViewCell
                cell.UILabel_M.text = "啦啦同学"
                cell.UIImageView_M.image = Imageload_Black
                
                TableviewHeight = 100
                
                return cell
            case 4://简介
                let cell = tableView.dequeueReusableCell(withIdentifier: "AccountManagement_TwoLabel_Big_TableViewCell", for: indexPath) as! AccountManagement_TwoLabel_Big_TableViewCell
                cell.UILabel_m.text = "简介"
                cell.UILabel_MAX.text = "安老师看到房间爱看书的反馈拉黑谁都快放假哈啥地方哈伦裤水电费哈哈涉及到客服哈啥地方还是"
                
                TableviewHeight = 100
                
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "AccountManagement_TwoLabel_TableViewCell", for: indexPath) as! AccountManagement_TwoLabel_TableViewCell
                cell.UILabel_1.text = list1[indexPath.row]
                TableviewHeight = 45
                return cell
            }
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccountManagement_TwoLabel_TableViewCell", for: indexPath) as! AccountManagement_TwoLabel_TableViewCell
            cell.UILabel_1.text = list2[indexPath.row]
            TableviewHeight = 45
            return cell
        case 2:
            if indexPath.row == 0 {
                //AccountManagement_OneLabel_TableViewCell
                let cell = tableView.dequeueReusableCell(withIdentifier: "AccountManagement_OneLabel_TableViewCell", for: indexPath) as! AccountManagement_OneLabel_TableViewCell
                cell.UILabel_m.text = list3[indexPath.row]
                TableviewHeight = 45
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "AccountManagement_TwoLabel_TableViewCell", for: indexPath) as! AccountManagement_TwoLabel_TableViewCell
                cell.UILabel_1.text = list3[indexPath.row]
                TableviewHeight = 45
                return cell
            }
           
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccountManagement_TwoLabel_TableViewCell", for: indexPath) as! AccountManagement_TwoLabel_TableViewCell
            cell.UILabel_1.text = list4[indexPath.row]
            TableviewHeight = 45
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccountManagement_TwoLabel_TableViewCell", for: indexPath) as! AccountManagement_TwoLabel_TableViewCell
            TableviewHeight = 45
            cell.UILabel_1.text = list5[indexPath.row]
            return cell
        }

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableviewHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0,1,2,3:
            return 15
        default:
            return 0
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return list1.count
        case 1:
            return list2.count
        case 2:
            return list3.count
        case 3:
            return list4.count
        default:
            return list5.count
        }
    }
}
