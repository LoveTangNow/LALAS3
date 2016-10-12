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
    
    @IBOutlet var UITableView_m: UITableView!
    var Imageload_Black:UIImage = UIImage(named: "Black.png")!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "动态详情"
        //self.tableView.register(MD_Words_TableViewCell.self, forCellReuseIdentifier: "MD_Words_TableViewCell"
        print(imgaeNumber)
        print(imagelist.count)
        
        ConnectNib()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
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
                
                cell.userIcon.setBackgroundImage(image1, for: .normal)
                cell.setting.setBackgroundImage(image1, for: .normal)
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
                    
                    cell.image_1.setImage(imagelist[0], for: .normal)
                    
                    TableViewHeight = CGFloat(Int(DeviceWidth * 0.618 ))
                    
                    return cell
                case 2,3:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ThreePhoto_NTableViewCell", for: indexPath) as! ThreePhoto_NTableViewCell
                    cell.image_1.setImage(imagelist[0], for: .normal)

                    switch imgaeNumber {
                    case 2:
                        cell.image_2.setImage(imagelist[1], for: .normal)
                    case 3:
                        cell.image_2.setImage(imagelist[1], for: .normal)
                        cell.image_3.setImage(imagelist[2], for: .normal)
                    default:
                        break
                    }
                    TableViewHeight = CGFloat(Int(DeviceWidth * 0.333 ))
                    return cell
                case 4,5,6:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "SixPhoto_TableViewCell", for: indexPath) as! SixPhoto_TableViewCell
                    cell.image_1.setImage(imagelist[0], for: .normal)
                    cell.image_2.setImage(imagelist[1], for: .normal)
                    cell.image_3.setImage(imagelist[2], for: .normal)
                    cell.image_4.setImage(imagelist[3], for: .normal)
                    switch imgaeNumber {
                    case 5:
                        cell.image_5.setImage(imagelist[4], for: .normal)
                    case 6:
                        cell.image_5.setImage(imagelist[4], for: .normal)
                        cell.image_6.setImage(imagelist[5], for: .normal)
                    default:
                        break
                    }
                    TableViewHeight = CGFloat(Int(DeviceWidth * 0.666 ))
                    return cell
                case 7,8,9:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "NinePhoto_TableViewCell", for: indexPath) as! NinePhoto_TableViewCell
                    cell.image_1.setImage(imagelist[0], for: .normal)
                    cell.image_2.setImage(imagelist[1], for: .normal)
                    cell.image_3.setImage(imagelist[2], for: .normal)
                    cell.image_4.setImage(imagelist[3], for: .normal)
                    cell.image_5.setImage(imagelist[4], for: .normal)
                    cell.image_6.setImage(imagelist[5], for: .normal)
                    cell.image_7.setImage(imagelist[6], for: .normal)
                    switch imgaeNumber {
                    case 8:
                        cell.image_8.setImage(imagelist[7], for: .normal)
                    case 9:
                        cell.image_8.setImage(imagelist[7], for: .normal)
                        cell.image_9.setImage(imagelist[8], for: .normal)
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
            cell.image_icon.setImage(#imageLiteral(resourceName: "Black"), for: .normal)
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
    
    func ConnectNib() {
        UITableView_m.register(UINib(nibName: "OnePhoto_H_NTableViewCell", bundle: nil), forCellReuseIdentifier: "OnePhoto_H_NTableViewCell")
        UITableView_m.register(UINib(nibName: "ThreePhoto_NTableViewCell", bundle: nil), forCellReuseIdentifier: "ThreePhoto_NTableViewCell")
        UITableView_m.register(UINib(nibName: "SixPhoto_TableViewCell", bundle: nil), forCellReuseIdentifier: "SixPhoto_TableViewCell")
        UITableView_m.register(UINib(nibName: "NinePhoto_TableViewCell", bundle: nil), forCellReuseIdentifier: "NinePhoto_TableViewCell")
        UITableView_m.register(UINib(nibName: "OnePhoto_Z_NTableViewCell", bundle: nil), forCellReuseIdentifier: "OnePhoto_Z_NTableViewCell")
        
        UITableView_m.register(UINib(nibName: "News_Information_TableViewCell", bundle: nil), forCellReuseIdentifier: "News_Information_TableViewCell")
        UITableView_m.register(UINib(nibName: "Pinglun_NTableViewCell", bundle: nil), forCellReuseIdentifier: "Pinglun_NTableViewCell")
    }


    
}
