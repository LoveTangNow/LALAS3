//
//  FirstViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/14.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

import Alamofire
import SVProgressHUD

//测试版？？！
import SwiftyJSON


class FirstViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    //MARK: - 绑定 和 变量

    @IBOutlet weak var UITableView_Main: UITableView!
    
    var TableViewCellHeight:CGFloat = 200
    var DeviceWidth =  UIScreen.main.bounds.width
    
    //肌肤默认的图片
    var Imageload_Black:UIImage = UIImage(named: "Black.png")!
    var Imageload_Wight:UIImage = UIImage(named: "White.png")!
    var ImageloadBackGroud:UIImage = UIImage(named: "FirstBackGround.png")!
    var ImageloadBackGroudn:UIImage = UIImage(named: "BackGround.png")!
    //数据存储
    var DataWords = Dictionary<Int,[String]>()//每一个 ID 对应着一个字符串数组 包括各种信息：NewsID,SenderID,SenderName,SendTime,SendDevice,Detail
    var DataPhotoNames = Dictionary<Int,[String]>()//每一个 ID 对应着一个字符串数组 图片名称们
    var DataPhotos = Dictionary<Int,[Dictionary<String,UIImage>]>()//每一个 ID 对应着一个UIImage数组 图片们
    
    var row = 0
    
    var ali = true
    
    
    
    
    //MARK: - 函数
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "动态"
        
        UITableView_Main.dataSource = self
        UITableView_Main.delegate = self
        
        let parameters: Parameters = ["userid": "1"]
        
        /*
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)//前后颜色
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.native)//菊花
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.show()
        */
        
        // Both calls are equivalent
        print(FFFFFunctions().GotServerAliScripts() + "GIVE_BACK_INFORMATION.php")
        Alamofire.request(FFFFFunctions().GotServerAliScripts() + "GIVE_BACK_INFORMATION.php", method: .post, parameters: parameters)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    //成功
                    //print(response.result.value)
                    let json = JSON(response.result.value)
                    
                    for i in 0..<json.count
                    {
                        // detail device newsid newstime photohumber senderid sendername
                        self.DataWords[i] = [json[i]["detail"].string!,json[i]["device"].string!,json[i]["newsid"].string!,json[i]["newstime"].string!,json[i]["photonumer"].string!,json[i]["senderid"].string!,json[i]["sendername"].string!]
                        let NumberOfPhotos = Int(json[i]["photonumer"].string!)!
                        var ArryOfNameOfPhotos = [String]()
                        for j in 0..<NumberOfPhotos
                        {
                            ArryOfNameOfPhotos.append(json[i]["photo"][j].string!)
                        }
                        self.DataPhotoNames[i] = ArryOfNameOfPhotos
                    }
                    
                    //print(self.DataWords)
                    //print(self.DataPhotoNames)
                    //print("Validation Successful")
                    
                    self.UITableView_Main.reloadData()
                    
                case .failure(let error):
                    //失败
                    print(error)
                }
        }
        // Do any additional setup after loading the view.
        print("loa")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("willa")
        //这里给 Tableview 写数据
        //159,42.4
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.navigationBar.tintColor = UIColor.white
        
        tabBarController?.tabBar.barTintColor = UIColor.black
        tabBarController?.tabBar.tintColor = UIColor.white
    }

    override func viewDidAppear(_ animated: Bool) {
        //print(DataPhotos)
        //self.UITableView_Main.center.y = -self.view.bounds.height / 2
        
        /*
         UIView.animate(withDuration: 1, delay: 0.3, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: UIViewAnimationOptions.curveEaseIn, animations: {
         self.UITableView_Main.center.y += self.view.bounds.height
         })
         */
        
        //self.UITableView_Main.center.x -= self.view.bounds.width
        /*
        UIView.animate(withDuration: 1, usingSpringWithDamping:0.3,animations: {
            self.UITableView_Main.center.y += self.view.bounds.height
            self.UITableView_Main.center.y -= 50
            self.UITableView_Main.center.y += 50
        })
        */
        //UIViewAnimationOptionCurveEaseInOut
        

        
        //UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, animations: self.UITableView_Main.center.y += self.view.bounds.height, completion: {print("")})
    }
    @IBAction func Right_Click(_ sender: AnyObject) {
        //ViewPhotoViewController
        let vc = UIStoryboard(name: "T", bundle: nil).instantiateViewController(withIdentifier: "TViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func Send_Click(_ sender: AnyObject) {
        //SendNewMessiageViewController
        let vc = UIStoryboard(name: "First", bundle: nil).instantiateViewController(withIdentifier: "SendNewMessiageViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: - TableView
    /*
     tableview 的工作是在viewDidLoad 和 viewWillAppear 之后做的
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //tableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        
        print(indexPath.row)
        switch indexPath.row {
        case 0://文字 携带文字 转移 并且还要携带图片 
            let vc = UIStoryboard(name: "First", bundle: nil).instantiateViewController(withIdentifier: "MessiageDetail_TableViewController") as!  MessiageDetail_TableViewController
            
            // detail device newsid newstime photohumber senderid sendername
            UserDefaults.standard.set(DataWords[indexPath.section]![0], forKey: "detail")
            UserDefaults.standard.set(DataWords[indexPath.section]![1], forKey: "device")
            UserDefaults.standard.set(DataWords[indexPath.section]![2], forKey: "newsid")
            UserDefaults.standard.set(DataWords[indexPath.section]![3], forKey: "newstime")
            UserDefaults.standard.set(DataWords[indexPath.section]![5], forKey: "senderid")
            UserDefaults.standard.set(DataWords[indexPath.section]![6], forKey: "sendername")
            //设置同步
            UserDefaults.standard.synchronize()
            
            self.navigationController?.pushViewController(vc, animated: true)
        case 1://图片 携带文字转 view view用scrollview展示
            let vc = UIStoryboard(name: "First", bundle: nil).instantiateViewController(withIdentifier: "ViewPhotoWithScroll_ViewController") as!  ViewPhotoWithScroll_ViewController
            print(DataPhotos)
            
             //Int(DataWords[indexPath.section]![4])!
            
            switch DataWords[indexPath.section]![4] {
            case "1" :
                let a = UITableView_Main.cellForRow(at: indexPath)! as! OnePhoto_H_TableViewCell
                vc.imagelist.append(a.UIImageView_Main.image!)
                vc.imgaeNumber = 1
                break
            case "2":
                let a = UITableView_Main.cellForRow(at: indexPath)! as! TwoThreePhoto_TableViewCell
                vc.imagelist.append(a.UIImageView_1.image)
                vc.imagelist.append(a.UIImageView_2.image)
                
                vc.imgaeNumber = 2
                //vc.image1 = a.UIImageView_1.image!
            case "3":
                let a = UITableView_Main.cellForRow(at: indexPath)! as! TwoThreePhoto_TableViewCell
                vc.imagelist.append(a.UIImageView_1.image)
                vc.imagelist.append(a.UIImageView_2.image)
                vc.imagelist.append(a.UIImageView_3.image)
                
                vc.imgaeNumber = 3
                //vc.image1 = a.UIImageView_2.image!
            case "4" :
                let a = UITableView_Main.cellForRow(at: indexPath)! as! FourFiveSix_TableViewCell
                vc.imagelist.append(a.UIImageView_1.image)
                vc.imagelist.append(a.UIImageView_2.image)
                vc.imagelist.append(a.UIImageView_3.image)
                vc.imagelist.append(a.UIImageView_4.image)
                
                vc.imgaeNumber = 4
            case "5" :
                let a = UITableView_Main.cellForRow(at: indexPath)! as! FourFiveSix_TableViewCell
                vc.imagelist.append(a.UIImageView_1.image)
                vc.imagelist.append(a.UIImageView_2.image)
                vc.imagelist.append(a.UIImageView_3.image)
                vc.imagelist.append(a.UIImageView_4.image)
                vc.imagelist.append(a.UIImageView_5.image)
                
                vc.imgaeNumber = 5
            case "6" :
                let a = UITableView_Main.cellForRow(at: indexPath)! as! FourFiveSix_TableViewCell
                vc.imagelist.append(a.UIImageView_1.image)
                vc.imagelist.append(a.UIImageView_2.image)
                vc.imagelist.append(a.UIImageView_3.image)
                vc.imagelist.append(a.UIImageView_4.image)
                vc.imagelist.append(a.UIImageView_5.image)
                vc.imagelist.append(a.UIImageView_6.image)
                
                vc.imgaeNumber = 6
            case "7" :
                let a = UITableView_Main.cellForRow(at: indexPath)! as! SevenEightNinePhoto_TableViewCell
                vc.imagelist.append(a.UIImageView_1.image)
                vc.imagelist.append(a.UIImageView_2.image)
                vc.imagelist.append(a.UIImageView_3.image)
                vc.imagelist.append(a.UIImageView_4.image)
                vc.imagelist.append(a.UIImageView_5.image)
                vc.imagelist.append(a.UIImageView_6.image)
                vc.imagelist.append(a.UIImageView_7.image)
                
                vc.imgaeNumber = 7
            case "8" :
                let a = UITableView_Main.cellForRow(at: indexPath)! as! SevenEightNinePhoto_TableViewCell
                vc.imagelist.append(a.UIImageView_1.image)
                vc.imagelist.append(a.UIImageView_2.image)
                vc.imagelist.append(a.UIImageView_3.image)
                vc.imagelist.append(a.UIImageView_4.image)
                vc.imagelist.append(a.UIImageView_5.image)
                vc.imagelist.append(a.UIImageView_6.image)
                vc.imagelist.append(a.UIImageView_7.image)
                vc.imagelist.append(a.UIImageView_8.image)
                
                vc.imgaeNumber = 8
            case "9" :
                let a = UITableView_Main.cellForRow(at: indexPath)! as! SevenEightNinePhoto_TableViewCell
                vc.imagelist.append(a.UIImageView_1.image)
                vc.imagelist.append(a.UIImageView_2.image)
                vc.imagelist.append(a.UIImageView_3.image)
                vc.imagelist.append(a.UIImageView_4.image)
                vc.imagelist.append(a.UIImageView_5.image)
                vc.imagelist.append(a.UIImageView_6.image)
                vc.imagelist.append(a.UIImageView_7.image)
                vc.imagelist.append(a.UIImageView_8.image)
                vc.imagelist.append(a.UIImageView_9.image)
                
                vc.imgaeNumber = 9
            default:
                break
            }
            
            
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            break
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /**
        if indexPath.section > row {
            //print("xia")
            if indexPath.section > 3 {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
            }
            row = indexPath.section
        }
        if indexPath.section < row
        {
            //print("shang")
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            row = indexPath.section
        }   
        */

        
        
        if DataWords.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AD_TableViewCell", for: indexPath) as! AD_TableViewCell
            return cell
        } else {
            switch indexPath.row {
            case 0://文字区
                let cell = tableView.dequeueReusableCell(withIdentifier: "Words_TableViewCell", for: indexPath) as! Words_TableViewCell
                cell.UIImageView_UserIcon.image = Imageload_Black
                cell.UIImageView_Setting.image = Imageload_Black
                cell.UIImageView_V.image = #imageLiteral(resourceName: "v")
                cell.UIImageView_VIP.image = Imageload_Black
                
                //  0       1      2       3        4           5         6
                // detail device newsid newstime photohumber senderid sendername
                cell.UILabel_Detail.text = DataWords[indexPath.section]![0] + DataWords[indexPath.section]![4]
                cell.UILabel_UserName.text = DataWords[indexPath.section]![6]
                cell.UILabel_TimeAndDevice.text  = DataWords[indexPath.section]![3] + DataWords[indexPath.section]![1]
                
                let TextCount = cell.UILabel_Detail.text!.characters.count
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
                    TableViewCellHeight = 80 + CGFloat(TotalHeightOfWords) //10 + 47 + 5 + 0+ ?
                    
                case 375://6  啊发发还是 地方哈迪斯 阿卡哈尔法 和发达阿什顿 发卡机是
                    if TextCount % 24 == 0 {
                        TextLineNumber = TextCount / 24
                    } else {
                        TextLineNumber = ( TextCount - TextCount % 24 ) / 24 + 1
                    }
                    TotalHeightOfWords = TextLineNumber * 15
                    TableViewCellHeight = 80 + CGFloat(TotalHeightOfWords) //10 + 47 + 5 + 0+ ?
                case 414://6p 啊发发还是 地方哈迪斯 阿卡哈尔法 和发达阿什顿 发卡机是打发收
                    if TextCount % 27 == 0 {
                        TextLineNumber = TextCount / 27
                    } else {
                        TextLineNumber = ( TextCount - TextCount % 27 ) / 27 + 1
                    }
                    TotalHeightOfWords = TextLineNumber * 15
                    TableViewCellHeight = 80 + CGFloat(TotalHeightOfWords) //10 + 47 + 5 + 0+ ?
                default: //se 啊发发还是 地方哈迪斯 阿卡哈尔法 和发达阿什顿
                    if TextCount % 20 == 0 {
                        TextLineNumber = TextCount / 20
                    } else {
                        TextLineNumber = ( TextCount - TextCount % 20 ) / 20 + 1
                    }
                    TotalHeightOfWords = TextLineNumber * 15
                    TableViewCellHeight = 80 + CGFloat(TotalHeightOfWords) //10 + 47 + 5 + 0+ ?
                }
                
                return cell
            case 1://图片区
                /*
                 iphone 5 = 320.0
                 iphone 5s = 320.0
                 
                 iphone 6 = 375.0
                 iphone 6p = 414.0
                 
                 iphone 6s = 375.0
                 iphone 6sp = 414.0
                 
                 iphone 7 = 375.0
                 iphone 7p = 414.0
                 */
                switch DataWords[indexPath.section]![4] {
                case "1":
                    let cell = tableView.dequeueReusableCell(withIdentifier: "OnePhoto_H_TableViewCell", for: indexPath) as! OnePhoto_H_TableViewCell
                    
                    /*
                        第一次 无数据 ：查询获取后 写入数组 填入视图
                        之后 有数据： 数组中取得数据 填入视图
                     */
                    if cell.GotPhoto == false {
                        //print("nnnnnnnn")
                        Alamofire.request(FFFFFunctions().GotImageMainServer(ai: ali) + "Zhu00001.jpg")
                            .responseData { response in
                                if let data = response.result.value {
                                    cell.UIImageView_Main.image = UIImage(data: data)
                                    let a:Dictionary<String, UIImage> = ["image0":UIImage(data: data)!]
                                    self.DataPhotos[indexPath.section] = [a]
                                    cell.GotPhoto = true
                                }
                        }
                    } else {
                        //print("ooooooo")
                        //cell.UIImageView_Main.image = DataPhotos[indexPath.section]?[0]["image0"]
                    }
                    
                    TableViewCellHeight = CGFloat(Int(DeviceWidth * 0.618 ))
                    return cell
                case "2","3":
                    let aa = Int(DataWords[indexPath.section]![4])!
                    let cell = tableView.dequeueReusableCell(withIdentifier: "TwoThreePhoto_TableViewCell", for: indexPath) as! TwoThreePhoto_TableViewCell
                    
                    if cell.GotPhoto == false {
                        //print("nnn")
                        for i in 0..<aa
                        {
                            var aaaaaa = [Dictionary<String, UIImage>]()
                            Alamofire.request(FFFFFunctions().GotImageMainServer(ai: ali) + "Zhu000" + String(i + 20) + ".jpg")
                                .responseData { response in
                                if let data = response.result.value {
                                    //print("do23")
                                    switch i {
                                    case 0 :
                                        cell.UIImageView_1.image = UIImage(data: data)
                                        aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                    case 1 :
                                        cell.UIImageView_2.image = UIImage(data: data)
                                        aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                        if aa == 2{
                                            self.DataPhotos[indexPath.section] = aaaaaa
                                            cell.GotPhoto = true
                                        }
                                    case 2 :
                                        cell.UIImageView_3.image = UIImage(data: data)
                                        aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                        if aa == 3{
                                            self.DataPhotos[indexPath.section] = aaaaaa
                                            cell.GotPhoto = true
                                            print(aaaaaa)
                                        }
                                    default:break
                                    }
                                }
                                
                            }
                        }
                    } else {
                        print("000003")
                        /**
                        switch DataPhotos[indexPath.section]!.count {
                        case 2:
                            cell.UIImageView_1.image = DataPhotos[indexPath.section]?[0]["image0"]
                            cell.UIImageView_2.image = DataPhotos[indexPath.section]?[1]["image1"]
                        case 3:
                            cell.UIImageView_1.image = DataPhotos[indexPath.section]?[0]["image0"]
                            cell.UIImageView_2.image = DataPhotos[indexPath.section]?[1]["image1"]
                            cell.UIImageView_3.image = DataPhotos[indexPath.section]?[2]["image2"]
                        default:
                            break
                        }
                        */
                    }
                    
                    TableViewCellHeight = CGFloat(Int(DeviceWidth * 0.333 ))
                    return cell

                case "4","5","6":
                    let aa = Int(DataWords[indexPath.section]![4])!
                    let cell = tableView.dequeueReusableCell(withIdentifier: "FourFiveSix_TableViewCell", for: indexPath) as! FourFiveSix_TableViewCell
                    if cell.GotPhoto == false {
                        for i in 0..<aa
                        {
                            var aaaaaa = [Dictionary<String, UIImage>]()
                            Alamofire.request(FFFFFunctions().GotImageMainServer(ai: ali) + "Zhu000" + String(i + 20) + ".jpg")
                                .responseData { response in
                                    if let data = response.result.value {
                                        //print("do456")
                                        switch i {
                                        case 0 :
                                            cell.UIImageView_1.image = UIImage(data: data)
                                            aaaaaa.append(["image" + String(i):cell.UIImageView_1.image!])
                                        case 1 :
                                            cell.UIImageView_2.image = UIImage(data: data)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                        case 2 :
                                            cell.UIImageView_3.image = UIImage(data: data)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                        case 3 :
                                            cell.UIImageView_4.image = UIImage(data: data)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                            if aa == 4{
                                                self.DataPhotos[indexPath.section] = aaaaaa
                                                print(aaaaaa)
                                                print(4)
                                                print(self.DataPhotos[indexPath.section])
                                                cell.GotPhoto = true
                                            }
                                        case 4 :
                                            cell.UIImageView_5.image = UIImage(data: data)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                            if aa == 5{
                                                self.DataPhotos[indexPath.section] = aaaaaa
                                                print(aaaaaa)
                                                print(5)
                                                print(self.DataPhotos[indexPath.section])
                                                cell.GotPhoto = true
                                            }
                                        case 5 :
                                            cell.UIImageView_6.image = UIImage(data: data)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                            if aa == 6{
                                                self.DataPhotos[indexPath.section] = aaaaaa
                                                print(aaaaaa)
                                                print(6)
                                                print(self.DataPhotos[indexPath.section])
                                                cell.GotPhoto = true
                                                print(aaaaaa)
                                            }
                                        default:break
                                        }
                                    }
                                    else
                                    {
                                        print("fall")
                                    }
                            }
                        }

                    } else {
                        print("oooo6")
                        
                        /**
                        print(DataPhotos[indexPath.section]!.count)
                        switch DataPhotos[indexPath.section]!.count {
                        case 4:
                            print(4)
                            cell.UIImageView_1.image = DataPhotos[indexPath.section]?[0]["image0"]
                            cell.UIImageView_2.image = DataPhotos[indexPath.section]?[1]["image0"]
                            cell.UIImageView_3.image = DataPhotos[indexPath.section]?[2]["image0"]
                            cell.UIImageView_1.image = DataPhotos[indexPath.section]?[3]["image0"]
                        case 5:
                            print(5)
                            cell.UIImageView_1.image = DataPhotos[indexPath.section]?[0]["image0"]
                            cell.UIImageView_2.image = DataPhotos[indexPath.section]?[1]["image0"]
                            cell.UIImageView_3.image = DataPhotos[indexPath.section]?[2]["image0"]
                            cell.UIImageView_1.image = DataPhotos[indexPath.section]?[3]["image0"]
                            cell.UIImageView_2.image = DataPhotos[indexPath.section]?[4]["image0"]
                        case 6:
                            print(6)
                            cell.UIImageView_1.image = DataPhotos[indexPath.section]?[0]["image0"]
                            cell.UIImageView_2.image = DataPhotos[indexPath.section]?[1]["image0"]
                            cell.UIImageView_3.image = DataPhotos[indexPath.section]?[2]["image0"]
                            cell.UIImageView_1.image = DataPhotos[indexPath.section]?[3]["image0"]
                            cell.UIImageView_2.image = DataPhotos[indexPath.section]?[4]["image0"]
                            cell.UIImageView_3.image = DataPhotos[indexPath.section]?[5]["image0"]
                        default:
                            break
                        }
                        */
                    }
                    
                    TableViewCellHeight = CGFloat(Int(DeviceWidth * 0.666 ))
                    return cell
                case "7","8","9":
                    let aa = Int(DataWords[indexPath.section]![4])!
                    let cell = tableView.dequeueReusableCell(withIdentifier: "SevenEightNinePhoto_TableViewCell", for: indexPath) as! SevenEightNinePhoto_TableViewCell
                    
                    
                    for i in 0..<aa
                    {
                        //print("alaout")
                        var aaaaaa = [Dictionary<String, UIImage>]()
                        //print(FFFFFunctions().GotImageMainServer(ai: ali))
                        Alamofire.request(FFFFFunctions().GotImageMainServer(ai: ali) + "Zhu000" + String(i + 30) + ".jpg")
                                .responseData { response in
                                   // print("alain")
                                    if let data = response.result.value {
                                        //print("do789")
                                        switch i {
                                        case 0 :
                                            cell.UIImageView_1.image = UIImage(data: data)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                        case 1 :
                                            cell.UIImageView_2.image = UIImage(data: data)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                        case 2 :
                                            cell.UIImageView_3.image = UIImage(data: data)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                        case 3 :
                                            cell.UIImageView_4.image = UIImage(data: data)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                        case 4 :
                                            cell.UIImageView_5.image = UIImage(data: data)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                        case 5 :
                                            cell.UIImageView_6.image = UIImage(data: data)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                        case 6 :
                                            cell.UIImageView_7.image = UIImage(data: data)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                            if aa == 7{
                                                self.DataPhotos[indexPath.section] = aaaaaa
                                                cell.GotPhoto = true
                                            }
                                        case 7 :
                                            cell.UIImageView_8.image = UIImage(data: data)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                            if aa == 8{
                                                self.DataPhotos[indexPath.section] = aaaaaa
                                                cell.GotPhoto = true
                                            }
                                        case 8 :
                                            cell.UIImageView_9.image = UIImage(data: data)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                            if aa == 9{
                                                self.DataPhotos[indexPath.section] = aaaaaa
                                                cell.GotPhoto = true
                                                print(aaaaaa)
                                            }
                                        default:break
                                        }
                                    }
                                    else
                                    {
                                        print("fall")
                                    }
                            }
                        }
                    
                    TableViewCellHeight = DeviceWidth
                    return cell
                default:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "OnePhoto_Z_TableViewCell", for: indexPath) as! OnePhoto_Z_TableViewCell
                    return cell
                }
            default://三按钮区
                let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsPraiseDemote_TableViewCell", for: indexPath) as! CommentsPraiseDemote_TableViewCell
                TableViewCellHeight = 40
                return cell
            }
        }
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return DataWords.count 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == DataWords.count {
            return 1
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableViewCellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == DataWords.count - 1 {
            return 0
        } else {
            return 15
        }
    }

}
