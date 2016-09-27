//
//  MessiageDetail_TableViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/9/21.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class MessiageDetail_TableViewController: UITableViewController {
    
    var TableViewHeight:CGFloat = 100
    let DeviceWidth =  UIScreen.main.bounds.width
    var imagelist = [UIImage?]()
    var imgaeNumber = Int()
    
    var Imageload_Black:UIImage = UIImage(named: "Black.png")!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "动态详情"
        //self.tableView.register(MD_Words_TableViewCell.self, forCellReuseIdentifier: "MD_Words_TableViewCell"
        print(imgaeNumber)
        print(imagelist.count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 1{
            let vc = UIStoryboard(name: "First", bundle: nil).instantiateViewController(withIdentifier: "ViewPhotoWithScroll_ViewController") as!  ViewPhotoWithScroll_ViewController
            vc.imagelist = imagelist
            vc.imgaeNumber = imgaeNumber
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        /**
        if indexPath.section == 0 && indexPath.row == 1 {
            let a  = self.view.viewWithTag(1) as! UIImageView
            print(a.frame.height)
        }*/
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let image1 = #imageLiteral(resourceName: "Black")
        let image2 = #imageLiteral(resourceName: "White")
    
        if indexPath.section == 0 {
            if indexPath.row == 0 {//Words
                let cell = tableView.dequeueReusableCell(withIdentifier: "News_Information_TableViewCell", for: indexPath) as! News_Information_TableViewCell
                
                cell.UIImageViewUserIcon.image = image1
                cell.UIImageViewSetting.image = image1
                cell.UIImageViewVip_.image = image1
                cell.UIImageViewV_.image = image2
                
                cell.UILabelDetail.text = "hehe"
                
                let TextCount = cell.UILabelDetail.text!.characters.count
                var TextLineNumber = 0
                var TotalHeightOfWords = 0
                
                switch DeviceWidth {
                case 320://se 啊发发还是 地方哈迪斯 阿卡哈尔法 和发达阿什顿
                    if TextCount % 20 == 0 {
                        TextLineNumber = TextCount / 20
                    } else {
                        TextLineNumber = ( TextCount - TextCount % 20 ) / 20 + 1
                    }
                    TotalHeightOfWords = TextLineNumber * 15
                    TableViewHeight = 80 + CGFloat(TotalHeightOfWords) //10 + 47 + 5 + 0+ ?
                    
                case 375://6  啊发发还是 地方哈迪斯 阿卡哈尔法 和发达阿什顿 发卡机是
                    if TextCount % 24 == 0 {
                        TextLineNumber = TextCount / 24
                    } else {
                        TextLineNumber = ( TextCount - TextCount % 24 ) / 24 + 1
                    }
                    TotalHeightOfWords = TextLineNumber * 15
                    TableViewHeight = 80 + CGFloat(TotalHeightOfWords) //10 + 47 + 5 + 0+ ?
                case 414://6p 啊发发还是 地方哈迪斯 阿卡哈尔法 和发达阿什顿 发卡机是打发收
                    if TextCount % 27 == 0 {
                        TextLineNumber = TextCount / 27
                    } else {
                        TextLineNumber = ( TextCount - TextCount % 27 ) / 27 + 1
                    }
                    TotalHeightOfWords = TextLineNumber * 15
                    TableViewHeight = 80 + CGFloat(TotalHeightOfWords) //10 + 47 + 5 + 0+ ?
                default: //se 啊发发还是 地方哈迪斯 阿卡哈尔法 和发达阿什顿
                    if TextCount % 20 == 0 {
                        TextLineNumber = TextCount / 20
                    } else {
                        TextLineNumber = ( TextCount - TextCount % 20 ) / 20 + 1
                    }
                    TotalHeightOfWords = TextLineNumber * 15
                    TableViewHeight = 80 + CGFloat(TotalHeightOfWords) //10 + 47 + 5 + 0+ ?
                }
                return cell
            } else {//Photos
                switch imgaeNumber {
                case 1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "OnePhoto_H_NTableViewCell", for: indexPath) as! OnePhoto_H_NTableViewCell
                    
                    cell.UIImageView_M.image = imagelist[0]
                    
                    TableViewHeight = CGFloat(Int(DeviceWidth * 0.618 ))
                    
                    return cell
                case 2,3:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ThreePhoto_NTableViewCell", for: indexPath) as! ThreePhoto_NTableViewCell
                    cell.UIImageView1.image = imagelist[0]

                    switch imgaeNumber {
                    case 2:
                        cell.UIImageView2.image = imagelist[1]
                    case 3:
                        cell.UIImageView2.image = imagelist[1]
                        cell.UIImageView3.image = imagelist[2]
                    default:
                        break
                    }
                    TableViewHeight = CGFloat(Int(DeviceWidth * 0.333 ))
                    return cell
                case 4,5,6:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "SixPhoto_TableViewCell", for: indexPath) as! SixPhoto_TableViewCell
                    cell.UIImageView1.image = imagelist[0]
                    cell.UIImageView2.image = imagelist[1]
                    cell.UIImageView3.image = imagelist[2]
                    cell.UIImageView4.image = imagelist[3]
                    switch imgaeNumber {
                    case 5:
                        cell.UIImageView5.image = imagelist[4]
                    case 6:
                        cell.UIImageView5.image = imagelist[4]
                        cell.UIImageView6.image = imagelist[5]
                    default:
                        break
                    }
                    TableViewHeight = CGFloat(Int(DeviceWidth * 0.666 ))
                    return cell
                case 7,8,9:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "NinePhoto_TableViewCell", for: indexPath) as! NinePhoto_TableViewCell
                    cell.UIImageView1.image = imagelist[0]
                    cell.UIImageView2.image = imagelist[1]
                    cell.UIImageView3.image = imagelist[2]
                    cell.UIImageView4.image = imagelist[3]
                    cell.UIImageView5.image = imagelist[4]
                    cell.UIImageView6.image = imagelist[5]
                    cell.UIImageView7.image = imagelist[6]
                    switch imgaeNumber {
                    case 8:
                        cell.UIImageView7.image = imagelist[7]
                    case 9:
                        cell.UIImageView8.image = imagelist[7]
                        cell.UIImageView9.image = imagelist[8]
                    default:
                        break
                    }
                    TableViewHeight = CGFloat(Int(DeviceWidth ))
                    return cell
                default:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "OnePhoto_H_NTableViewCell", for: indexPath) as! OnePhoto_H_NTableViewCell
                    return cell
                }
            }
        }
        else{//Pinglun
            let cell = tableView.dequeueReusableCell(withIdentifier: "Pinglun_NTableViewCell", for: indexPath) as! Pinglun_NTableViewCell
 
            cell.UIImageView_Icon.image = image1
            TableViewHeight = CGFloat(Int(DeviceWidth * 0.3 ))
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableViewHeight
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
