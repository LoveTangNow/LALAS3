//
//  SendNewMessiageViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/14.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class SendNewMessiageViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    //MARK: - 绑定 变量

    @IBOutlet weak var UITextView_Main: UITextView!
    @IBOutlet weak var UITableView_Main: UITableView!
    
    var TableViewCellHeight:CGFloat = 0
    
    //肌肤默认的图片
    var Imageload_Black:UIImage = UIImage(named: "Black.png")!
    var Imageload_Wight:UIImage = UIImage(named: "White.png")!
    
    //MARK: - FUNCS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITableView_Main.delegate = self
        UITableView_Main.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Xiala(_ sender: AnyObject) {
        UITextView_Main.resignFirstResponder()
    }
    
    @IBAction func Send_Click(_ sender: AnyObject) {
    }
    
    //MARK: - TABLEVIEW
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 1:
            switch indexPath.row {
            case 0://地点
                let cell = tableView.dequeueReusableCell(withIdentifier: "OnlyOneLabel_TableViewCell", for: indexPath) as! OnlyOneLabel_TableViewCell
                
                cell.UILabel_M.text = "选择地点"
                TableViewCellHeight = 45
                
                return cell
            default://分享
                let cell = tableView.dequeueReusableCell(withIdentifier: "ThreePhoto_NTableViewCell", for: indexPath) as! ThreePhoto_NTableViewCell
                
                //cell.UIImageView_Main.image = Imageload_Black
                TableViewCellHeight = 45
                
                return cell
            }
            
        default://图片
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThreePhoto_NTableViewCell", for: indexPath) as! ThreePhoto_NTableViewCell
            
            return cell

        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 15
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableViewCellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

}
