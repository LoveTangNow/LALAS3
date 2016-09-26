//
//  MessiageDetail_TableViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/9/21.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class MessiageDetail_TableViewController: UITableViewController {
    
    var imagelist = [UIImage]()
    var imgaeNumber = 0
    
    var Imageload_Black:UIImage = UIImage(named: "Black.png")!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "动态详情"
        //self.tableView.register(MD_Words_TableViewCell.self, forCellReuseIdentifier: "MD_Words_TableViewCell"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 1 {
            let a  = self.view.viewWithTag(1) as! UIImageView
            print(a.frame.height)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let image1 = #imageLiteral(resourceName: "Black")
        let image2 = #imageLiteral(resourceName: "White")
        
        
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "News_Information_TableViewCell", for: indexPath) as! News_Information_TableViewCell
                
                cell.UIImageViewUserIcon.image = image1
                cell.UIImageViewSetting.image = image1
                cell.UIImageViewVip_.image = image1
                cell.UIImageViewV_.image = image2
                
                cell.UILabelDetail.text = "hehe"

                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OnePhoto_H_NTableViewCell", for: indexPath) as! OnePhoto_H_NTableViewCell
                
                cell.UIImageView_M.image = image1
                
                return cell
            }
            
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Pinglun_NTableViewCell", for: indexPath) as! Pinglun_NTableViewCell
 
            cell.UIImageView_Icon.image = image1
            
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 15
        } else {
            return 0
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 2
        } else {
            return 10
        }
    }

    
}
