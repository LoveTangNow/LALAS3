//
//  MessiageDetail_TableViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/9/21.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import MapKit//用于显示位置

class MessiageDetail_TableViewController: UITableViewController {
    
    var TableViewHeight:CGFloat = 100
    let DeviceWidth =  UIScreen.main.bounds.width
    var imagelist = [UIImage?]()
    var imgaeNumber = Int()
    //评论数据包括：评论序号，评论者 id，评论时间，评论内容
    var pinglunData = [[String]]()
    
    var user_id = String()
    var label1 = String()
    var label2 = String()
    var label3 = String()
    
    var imageicon = UIImage()
    
    @IBOutlet var UITableView_m: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "动态详情"
        //self.tableView.register(MD_Words_TableViewCell.self, forCellReuseIdentifier: "MD_Words_TableViewCell"
        //print(imgaeNumber)
        //print(imagelist.count)
        ConnectNib()
        
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)//前后颜色
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.native)//菊花
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.clear)
        SVProgressHUD.show()
        //请求评论们:参数是一个 news id
        let newsid: Parameters = ["newsid": "1"]
        Alamofire.request(GotServers().GotServerAliScripts() + "GIVE_BACK_PINGLUN.php", method: .post, parameters: newsid)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    //成功
                    //print(response.result.value)
                    let json = JSON(response.result.value)
                    //数据包括：评论序号，评论者 id，评论时间，评论内容
                    //print(json)
                    for i  in 0..<json.count {
                        //"userid":"2","sendtime":"201610132148","detail":"??1","zannumber":"0"
                        self.pinglunData.append([json[i]["userid"].string!,json[i]["sendtime"].string!,json[i]["detail"].string!,json[i]["zannumber"].string!])
                    }
                    
                    //print(self.pinglunData)
                    
                    self.UITableView_m.reloadData()
                    SVProgressHUD.dismiss()
                    
                case .failure(let error):
                    //失败
                    print(error)
                    SVProgressHUD.dismiss()
                }
        }
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Defalts_ReadWrite().Settssssss_h(DATA: "MessiageDetail_TableViewController", FORKEY: "whereifrom")
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
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {//Words
                let cell = tableView.dequeueReusableCell(withIdentifier: "News_Information_TableViewCell", for: indexPath) as! News_Information_TableViewCell
                
                cell.userIcon.setBackgroundImage(imageicon, for: .normal)
                cell.setting.setBackgroundImage(#imageLiteral(resourceName: "setting"), for: .normal)
                cell.UIImageViewVip_.image = #imageLiteral(resourceName: "warning")
                cell.UIImageViewV_.image = #imageLiteral(resourceName: "v")
                
                cell.UILabelUserName.text = label1
                cell.UILabelInformation.text = label2
                cell.UILabelDetail.text = label3

                TableViewHeight = WorksHieghts().WorkWordsHeightForInformation(Words: cell.UILabelDetail.text!)
                return cell
            } else {//Photos
                switch imgaeNumber {
                case 1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "OnePhoto_H_NTableViewCell", for: indexPath) as! OnePhoto_H_NTableViewCell
                    
                    cell.image_1.setImage(imagelist[0], for: .normal)
                    cell.image_1.addTarget(self, action: #selector(GoImageDetail), for: UIControlEvents.touchUpInside)
                    
                    TableViewHeight = WorksHieghts().WorkWordsHeightForPhotots(photoNumber: 1)
                    return cell
                    
                case 2,3:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ThreePhoto_NTableViewCell", for: indexPath) as! ThreePhoto_NTableViewCell
                    cell.image_1.setImage(imagelist[0], for: .normal)
                    cell.image_1.addTarget(self, action: #selector(GoImageDetail), for: UIControlEvents.touchUpInside)

                    switch imgaeNumber {
                    case 2:
                        cell.image_2.setImage(imagelist[1], for: .normal)
                        cell.image_2.addTarget(self, action: #selector(GoImageDetail), for: UIControlEvents.touchUpInside)
                    case 3:
                        cell.image_2.setImage(imagelist[1], for: .normal)
                        cell.image_3.setImage(imagelist[2], for: .normal)
                        cell.image_2.addTarget(self, action: #selector(GoImageDetail), for: UIControlEvents.touchUpInside)
                        cell.image_3.addTarget(self, action: #selector(GoImageDetail), for: UIControlEvents.touchUpInside)
                    default:
                        break
                    }

                    TableViewHeight = WorksHieghts().WorkWordsHeightForPhotots(photoNumber: 3)
                    return cell
                    
                case 4,5,6:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "SixPhoto_TableViewCell", for: indexPath) as! SixPhoto_TableViewCell
                    cell.image_1.setImage(imagelist[0], for: .normal)
                    cell.image_2.setImage(imagelist[1], for: .normal)
                    cell.image_3.setImage(imagelist[2], for: .normal)
                    cell.image_4.setImage(imagelist[3], for: .normal)
                    
                    cell.image_1.addTarget(self, action: #selector(GoImageDetail), for: UIControlEvents.touchUpInside)
                    cell.image_2.addTarget(self, action: #selector(GoImageDetail), for: UIControlEvents.touchUpInside)
                    cell.image_3.addTarget(self, action: #selector(GoImageDetail), for: UIControlEvents.touchUpInside)
                    cell.image_4.addTarget(self, action: #selector(GoImageDetail), for: UIControlEvents.touchUpInside)
                    
                    switch imgaeNumber {
                    case 5:
                        cell.image_5.setImage(imagelist[4], for: .normal)
                        cell.image_5.addTarget(self, action: #selector(GoImageDetail), for: UIControlEvents.touchUpInside)
                    case 6:
                        cell.image_5.setImage(imagelist[4], for: .normal)
                        cell.image_6.setImage(imagelist[5], for: .normal)
                        cell.image_5.addTarget(self, action: #selector(GoImageDetail), for: UIControlEvents.touchUpInside)
                        cell.image_6.addTarget(self, action: #selector(GoImageDetail), for: UIControlEvents.touchUpInside)
                    default:
                        break
                    }
     
                    TableViewHeight = WorksHieghts().WorkWordsHeightForPhotots(photoNumber: 4)
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
                    
                    cell.image_1.addTarget(self, action: #selector(GoImageDetail), for: UIControlEvents.touchUpInside)
                    cell.image_2.addTarget(self, action: #selector(GoImageDetail), for: UIControlEvents.touchUpInside)
                    cell.image_3.addTarget(self, action: #selector(GoImageDetail), for: UIControlEvents.touchUpInside)
                    cell.image_4.addTarget(self, action: #selector(GoImageDetail), for: UIControlEvents.touchUpInside)
                    cell.image_5.addTarget(self, action: #selector(GoImageDetail), for: UIControlEvents.touchUpInside)
                    cell.image_6.addTarget(self, action: #selector(GoImageDetail), for: UIControlEvents.touchUpInside)
                    cell.image_7.addTarget(self, action: #selector(GoImageDetail), for: UIControlEvents.touchUpInside)
                    
                    switch imgaeNumber {
                    case 8:
                        cell.image_8.setImage(imagelist[7], for: .normal)
                        cell.image_8.addTarget(self, action: #selector(GoImageDetail), for: UIControlEvents.touchUpInside)
                    case 9:
                        cell.image_8.setImage(imagelist[7], for: .normal)
                        cell.image_9.setImage(imagelist[8], for: .normal)
                        cell.image_8.addTarget(self, action: #selector(GoImageDetail), for: UIControlEvents.touchUpInside)
                        cell.image_9.addTarget(self, action: #selector(GoImageDetail), for: UIControlEvents.touchUpInside)
                    default:
                        break
                    }
                    
                    TableViewHeight = WorksHieghts().WorkWordsHeightForPhotots(photoNumber: 8)
                    return cell
                    
                default:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "OnePhoto_H_NTableViewCell", for: indexPath) as! OnePhoto_H_NTableViewCell
                    return cell
                }
            }
        }
        else{//Pinglun
            let cell = tableView.dequeueReusableCell(withIdentifier: "Pinglun_NTableViewCell", for: indexPath) as! Pinglun_NTableViewCell
            Alamofire.request(GotServers().GotImageIconServer(ai: true) + String(pinglunData[indexPath.row][0]) + ".png")
                .responseData { response in
                    if let data = response.result.value {
                        let asd = UIImage(data: data)
                        cell.image_icon.setImage(asd, for: UIControlState.normal)
                    }
            }
            
            //userid —— username—— 时间 内容 赞数目
            cell.UILabelWords.text = pinglunData[indexPath.row][2]
            cell.UILabelTime.text = pinglunData[indexPath.row][1]
            
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
            return pinglunData.count
        }
    }
    
    func GoImageDetail(_ sender:UIButton)
    {
        let indexpath = self.tableView.indexPath(for: sender.superview?.superview as! UITableViewCell)!
        let vc = UIStoryboard(name: "First", bundle: nil).instantiateViewController(withIdentifier: "ViewPhotoWithScroll_ViewController") as!  ViewPhotoWithScroll_ViewController
        
        vc.imagelist = GotPhoto(indexpath: indexpath)
        vc .imgaeNumber = imgaeNumber
        
        self.navigationController?.pushViewController(vc, animated: false)
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


    func GotPhoto(indexpath:IndexPath) -> ([UIImage?]) {
        var imagelist = [UIImage?]()
        
        switch imgaeNumber {
        case 1 :
            let a = tableView.cellForRow(at: indexpath)! as! OnePhoto_H_NTableViewCell
            imagelist.append(a.image_1.currentImage)
            break
        case 2,3:
            let a = tableView.cellForRow(at: indexpath)! as! ThreePhoto_NTableViewCell
            imagelist.append(a.image_1.currentImage)
            imagelist.append(a.image_2.currentImage)
            if imgaeNumber == 3 {
                imagelist.append(a.image_3.currentImage)
            }
            
        case 4,5,6 :
            let a = tableView.cellForRow(at: indexpath)! as! SixPhoto_TableViewCell
            imagelist.append(a.image_1.currentImage)
            imagelist.append(a.image_2.currentImage)
            imagelist.append(a.image_3.currentImage)
            imagelist.append(a.image_4.currentImage)
            if imgaeNumber == 5 {
                imagelist.append(a.image_5.currentImage)
            }
            if imgaeNumber == 6 {
                imagelist.append(a.image_5.currentImage)
                imagelist.append(a.image_6.currentImage)
            }
            
        case 7,8,9:
            let a = tableView.cellForRow(at: indexpath)! as! NinePhoto_TableViewCell
            imagelist.append(a.image_1.currentImage)
            imagelist.append(a.image_2.currentImage)
            imagelist.append(a.image_3.currentImage)
            imagelist.append(a.image_4.currentImage)
            imagelist.append(a.image_5.currentImage)
            imagelist.append(a.image_6.currentImage)
            imagelist.append(a.image_7.currentImage)
            if imgaeNumber == 8 {
                imagelist.append(a.image_8.currentImage)
            }
            if imgaeNumber == 9 {
                imagelist.append(a.image_8.currentImage)
                imagelist.append(a.image_9.currentImage)
            }
            
        default:
            break
        }
        return (imagelist)
    }
    
}
