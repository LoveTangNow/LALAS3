//
//  AccountSecurity_TableViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/18.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class AccountSecurity_TableViewController: UITableViewController {
    
    var list1 = ["用户名","用户ID"]
    var list2 = ["更改密码"]
    var list3 = ["绑定手机","绑定邮箱"]
    var list4 = ["证件信息","登录保护"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccountSecurityCell_TwoLabel_TableViewCell", for: indexPath) as! AccountSecurityCell_TwoLabel_TableViewCell
            cell.UILabel_M.text = list1[indexPath.row]
            if indexPath.row == 0 {
                //用户名
                cell.UILabel_Mini.text = "一碗凉白开"
            } else {
                cell.UILabel_Mini.text = "12*****89"
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccountSecurityCell_OneLabel_TableViewCell", for: indexPath) as! AccountSecurityCell_OneLabel_TableViewCell
            cell.UILabel_M.text = list2[indexPath.row]
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccountSecurityCell_TwoLabel_TableViewCell", for: indexPath) as! AccountSecurityCell_TwoLabel_TableViewCell
            cell.UILabel_M.text = list3[indexPath.row]
            return cell
        default:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "AccountSecurityCell_TwoLabel_TableViewCell", for: indexPath) as! AccountSecurityCell_TwoLabel_TableViewCell
                cell.UILabel_M.text = list4[indexPath.row]
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "AccountSecurityCell_LableSwitch_TableViewCell", for: indexPath) as! AccountSecurityCell_LableSwitch_TableViewCell
                cell.UILabel_M.text = list4[indexPath.row]
                return cell
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0,1,2:
            return 15
        default:
            return 0
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
            return list1.count
        case 1:
            return list2.count
        case 2:
            return list3.count
        default:
            return list4.count
        }
    }

}
