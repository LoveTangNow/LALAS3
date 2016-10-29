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
    
    @IBOutlet var UITableView_m: UITableView!
    //MARK: - FUNCTIONS
    /*
    ["账号管理","账号安全"]
    ["通用设置","通知"]
    ["清理缓存","意见反馈","关于我们"]*/
    let SettingLists = [["账号管理","账号安全"],["通用设置","通知设置"],["清理缓存","意见反馈","关于我们"]]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
        tableView.tableFooterView = UIView(frame:CGRect.zero)
        ConnectNib()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Tableview
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch indexPath.section {
        case 0://1
            let user_id = Defalts_ReadWrite().ReadDefalts_String(KEY: "user_id")
            if  user_id != "" || user_id != nil{
                if indexPath.row == 0 {//账号管理
                    let vc = UIStoryboard(name: "Fourth", bundle: nil).instantiateViewController(withIdentifier: "AccountManagement_ViewController")
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {               //账号安全
                    let vc = UIStoryboard(name: "Fourth", bundle: nil).instantiateViewController(withIdentifier: "AccountSecurity_TableViewController")
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }

        case 1://2
            if indexPath.row == 0 {//通用设置
                let vc = UIStoryboard(name: "Fourth", bundle: nil).instantiateViewController(withIdentifier: "Tongyong_ViewController")
                self.navigationController?.pushViewController(vc, animated: true)
            } else {               //通知设置
                let vc = UIStoryboard(name: "Fourth", bundle: nil).instantiateViewController(withIdentifier: "Tongzhi_ViewController")
                self.navigationController?.pushViewController(vc, animated: true)
            }
        case 2://3
            switch indexPath.row {
            case 0:
                let vc = UIStoryboard(name: "Fourth", bundle: nil).instantiateViewController(withIdentifier: "HuanCun_ViewController")
                self.navigationController?.pushViewController(vc, animated: true)
            case 1:
                let vc = UIStoryboard(name: "Fourth", bundle: nil).instantiateViewController(withIdentifier: "FanKui_ViewController")
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                let vc = UIStoryboard(name: "Fourth", bundle: nil).instantiateViewController(withIdentifier: "AboutUs_ViewController")
                self.navigationController?.pushViewController(vc, animated: true)
            }
        default://退出
            let alertController = UIAlertController(title: "系统提示",
                                                    message: "确定要退出么",
                                                    preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "好的", style: .default, handler: {
                action in
                Defalts_ReadWrite().Settssssss_h(DATA: "", FORKEY: "user_id")
            })
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0,1,2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LeftSamllImageAndLabel_TableViewCell", for: indexPath) as! LeftSamllImageAndLabel_TableViewCell
            
            cell.UIImageView_m.image = #imageLiteral(resourceName: "alipay")
            cell.UILabel_m.text = SettingLists[indexPath.section][indexPath.row]
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Label_Mid_TableViewCell", for: indexPath) as! Label_Mid_TableViewCell
            
            cell.UILabel_m.text = "退出此账号"
            
            return cell
        }
        
    }
    
    /*
     
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let more = UITableViewRowAction(style: .normal, title: "More") { action, index in
            print("more button tapped")
        }
        more.backgroundColor = UIColor.lightGray
        
        let favorite = UITableViewRowAction(style: .normal, title: "Favorite") { action, index in
            print("favorite button tapped")
        }
        favorite.backgroundColor = UIColor.orange
        
        let share = UITableViewRowAction(style: .normal, title: "Share") { action, index in
            print("share button tapped")
        }
        share.backgroundColor = UIColor.blue
        
        return [share, favorite, more]
    }
     
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     tableView.reloadData()
     }
     
    */
    

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return SettingLists.count + 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0,1,2:
            return SettingLists[section].count
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
    
    private func ConnectNib () {
        UITableView_m.register(UINib(nibName: "LeftSamllImageAndLabel_TableViewCell", bundle: nil), forCellReuseIdentifier: "LeftSamllImageAndLabel_TableViewCell")
        UITableView_m.register(UINib(nibName: "Label_Mid_TableViewCell", bundle: nil), forCellReuseIdentifier: "Label_Mid_TableViewCell")
    }


}
