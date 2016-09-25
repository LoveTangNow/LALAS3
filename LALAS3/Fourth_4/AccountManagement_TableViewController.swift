//
//  AccountManagement_TableViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/18.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

enum AccountManagement_modoolllll {
    case normal
    case pikerbrithday
}

class AccountManagement_TableViewController: UITableViewController ,UIPickerViewDelegate,UIPickerViewDataSource{
    
    @IBOutlet var UIPickerView_MMM: UIPickerView!
    var modoooool = AccountManagement_modoolllll.normal
    
    var TableviewHeight:CGFloat = 0
    
    var Imageload_Black:UIImage = UIImage(named: "Black.png")!

    var list1 = ["用户昵称 和 头像","性别","所在地","生日","用户简介"]
    var list2 = ["工作信息"]
    var list3 = ["教育信息","大学","初中","小学等"]
    var list4 = ["邮箱","手机","QQ","微博","微信","支付宝"]
    var list5 = ["等级","积分","注册时间"]
    
    //账号管理：昵称0、性别1、所在地（省2、市3、区4）、生日5、简介6、工作信息7、教育信息（小学8、初中9、\\高中0、大学1、硕士2、博士3、博士后4）、(qq5、手机6、邮箱7、微博8、微信9、支付宝0、)、等级1、积分2、注册时间3
    var listall = ["","","","","","","","","","","","","","","","","","","","","","","",""]
    
    
    //UserDefaults.standard.value(forKey: FORKEY)

    override func viewDidLoad() {
        super.viewDidLoad()
        listall[2] = UserDefaults.standard.value(forKey: "SuoZaiDi_Sheng") as! String
        listall[3] = UserDefaults.standard.value(forKey: "SuoZaiDi_Sheng") as! String
        listall[4] = UserDefaults.standard.value(forKey: "SuoZaiDi_Sheng") as! String
        
        UIPickerView_MMM.frame = CGRect(x:100,y:100,width:100,height:100)
        UIPickerView_MMM.delegate = self
        UIPickerView_MMM.dataSource = self
        UIPickerView_MMM.backgroundColor = UIColor.red
        
        self.tableView.sectionIndexColor = UIColor.darkGray
        self.view.addSubview(UIPickerView_MMM)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        /*UIView.animate(withDuration: 3, animations: {
            self.UIPickerView_MMM.center.y += 50
            self.UIPickerView_MMM.frame =  CGRect(x:100,y:100,width:150,height:150)
        })*/
        
        UIView.animate(withDuration: 3,
            animations:{
                self.UIPickerView_MMM.center.y += 50
            },
            completion: {_ in
                UIView.animate(withDuration: 3, animations: {
                    self.UIPickerView_MMM.frame =  CGRect(x:100,y:100,width:150,height:150)
                }
                )
            }
        )
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        //print("numberOfComponents")
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //print("numberOfRowsInComponent")
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //print("titleForRow")
        return "lala"
    }
    

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        print(list1)
        //TViewController
        //let vc = UIStoryboard(name: "First", bundle: nil).instantiateViewController(withIdentifier: "SendNewMessiageViewController")
        //self.navigationController?.pushViewController(vc, animated: true)
       
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            switch list1[indexPath.row] {//["用户昵称 和 头像","性别","所在地","生日","用户简介"]
            case "用户昵称 和 头像"://头像 昵称
                let cell = tableView.dequeueReusableCell(withIdentifier: "AccountManagement_M_TableViewCell", for: indexPath) as! AccountManagement_M_TableViewCell
                cell.UILabel_M.text = "啦啦同学"
                cell.UIImageView_M.image = Imageload_Black
                
                TableviewHeight = 100
                
                return cell
            case "用户简介"://简介
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
