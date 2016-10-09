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
    
    var MODEL = FirstPageModel()
    
    //MARK: - 函数
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "动态"
        
        UITableView_Main.dataSource = self
        UITableView_Main.delegate = self
        
        let parameters: Parameters = ["userid": "1"]
        
        ConnectNib()
        
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)//前后颜色
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.native)//菊花
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.show()
        
        Alamofire.request("http://121.42.36.47/lala/scripts/GIVE_BACK_INFORMATION.php", method: .post, parameters: parameters)
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
                    SVProgressHUD.dismiss()
                    
                case .failure(let error):
                    //失败
                    print(error)
                    SVProgressHUD.dismiss()
                }
        }
        // Do any additional setup after loading the view.
        print("viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        //这里给 Tableview 写数据
        //159,42.4
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.navigationBar.tintColor = UIColor.white
        /*
        tabBarController?.tabBar.barTintColor = UIColor.black
        tabBarController?.tabBar.tintColor = UIColor.white*/
        //title 颜色 据说可以用一个 label 初始化 这样就有颜色了！！！！！！！！
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
        //case 0://文字 携带文字 转移 并且还要携带图片
            
        case 0,1://图片 携带文字转 view view用scrollview展示
            
            //Int(DataWords[indexPath.section]![4])!
            var imagelist = [UIImage?]()
            var imagenumber_in = Int()
            var aa = indexPath
            if indexPath.row == 0 {
                aa.row += 1
            }
            switch DataWords[indexPath.section]![4] {
            case "1" :
                let a = UITableView_Main.cellForRow(at: aa)! as! OnePhoto_H_NTableViewCell
                imagelist.append(a.UIImageView_M.image!)
                imagenumber_in = 1
                break
            case "2":
                let a = UITableView_Main.cellForRow(at: aa)! as! ThreePhoto_NTableViewCell
                imagelist.append(a.UIImageView1.image)
                imagelist.append(a.UIImageView2.image)
                
                imagenumber_in = 2
            //vc.image1 = a.UIImageView_1.image!
            case "3":
                let a = UITableView_Main.cellForRow(at: aa)! as! ThreePhoto_NTableViewCell
                imagelist.append(a.UIImageView1.image)
                imagelist.append(a.UIImageView2.image)
                imagelist.append(a.UIImageView3.image)
                
                imagenumber_in = 3
            //vc.image1 = a.UIImageView_2.image!
            case "4" :
                let a = UITableView_Main.cellForRow(at: aa)! as! SixPhoto_TableViewCell
                imagelist.append(a.UIImageView1.image)
                imagelist.append(a.UIImageView2.image)
                imagelist.append(a.UIImageView3.image)
                imagelist.append(a.UIImageView4.image)
                
                imagenumber_in = 4
            case "5" :
                let a = UITableView_Main.cellForRow(at: aa)! as! SixPhoto_TableViewCell
                imagelist.append(a.UIImageView1.image)
                imagelist.append(a.UIImageView2.image)
                imagelist.append(a.UIImageView3.image)
                imagelist.append(a.UIImageView4.image)
                imagelist.append(a.UIImageView5.image)
                
                imagenumber_in = 5
            case "6" :
                let a = UITableView_Main.cellForRow(at: aa)! as! SixPhoto_TableViewCell
                imagelist.append(a.UIImageView1.image)
                imagelist.append(a.UIImageView2.image)
                imagelist.append(a.UIImageView3.image)
                imagelist.append(a.UIImageView4.image)
                imagelist.append(a.UIImageView5.image)
                imagelist.append(a.UIImageView6.image)
                
                imagenumber_in = 6
            case "7" :
                let a = UITableView_Main.cellForRow(at: aa)! as! NinePhoto_TableViewCell
                imagelist.append(a.UIImageView1.image)
                imagelist.append(a.UIImageView2.image)
                imagelist.append(a.UIImageView3.image)
                imagelist.append(a.UIImageView4.image)
                imagelist.append(a.UIImageView5.image)
                imagelist.append(a.UIImageView6.image)
                imagelist.append(a.UIImageView7.image)
                
                imagenumber_in = 7
            case "8" :
                let a = UITableView_Main.cellForRow(at: aa)! as! NinePhoto_TableViewCell
                imagelist.append(a.UIImageView1.image)
                imagelist.append(a.UIImageView2.image)
                imagelist.append(a.UIImageView3.image)
                imagelist.append(a.UIImageView4.image)
                imagelist.append(a.UIImageView5.image)
                imagelist.append(a.UIImageView6.image)
                imagelist.append(a.UIImageView7.image)
                imagelist.append(a.UIImageView8.image)
                //print("8")
                imagenumber_in = 8
            case "9" :
                let a = UITableView_Main.cellForRow(at: aa)! as! NinePhoto_TableViewCell
                imagelist.append(a.UIImageView1.image)
                imagelist.append(a.UIImageView2.image)
                imagelist.append(a.UIImageView3.image)
                imagelist.append(a.UIImageView4.image)
                imagelist.append(a.UIImageView5.image)
                imagelist.append(a.UIImageView6.image)
                imagelist.append(a.UIImageView7.image)
                imagelist.append(a.UIImageView8.image)
                imagelist.append(a.UIImageView9.image)
                //print("9")
                imagenumber_in = 9
            default:
                break
            }
            
            switch indexPath.row {
            case 0:
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
                
                vc.imagelist = imagelist
                vc.imgaeNumber = imagenumber_in
                
                self.navigationController?.pushViewController(vc, animated: true)
            case 1:
                let vc = UIStoryboard(name: "First", bundle: nil).instantiateViewController(withIdentifier: "ViewPhotoWithScroll_ViewController") as!  ViewPhotoWithScroll_ViewController
                vc.imagelist = imagelist
                vc.imgaeNumber = imagenumber_in
                //print(DataPhotos)
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                break
            }
     
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "Advertisement_TableViewCell", for: indexPath) as! Advertisement_TableViewCell
            cell.UIImageView_M.image = #imageLiteral(resourceName: "Black")
            return cell
        } else {
            switch indexPath.row {
            case 0://文字区
                let cell = tableView.dequeueReusableCell(withIdentifier: "News_Information_TableViewCell", for: indexPath) as! News_Information_TableViewCell
                cell.UIImageViewUserIcon.image = #imageLiteral(resourceName: "Black")
                cell.UIImageViewSetting.image = Imageload_Black
                cell.UIImageViewV_.image = #imageLiteral(resourceName: "v")
                cell.UIImageViewVip_.image = Imageload_Black
                
                //  0       1      2       3        4           5         6
                // detail device newsid newstime photohumber senderid sendername
                cell.UILabelDetail.text = DataWords[indexPath.section]![0] + DataWords[indexPath.section]![4]
                cell.UILabelUserName.text = DataWords[indexPath.section]![6]
                cell.UILabelInformation.text  = DataWords[indexPath.section]![3] + DataWords[indexPath.section]![1]
                
                let TextCount = cell.UILabelInformation.text!.characters.count
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
                    let cell = tableView.dequeueReusableCell(withIdentifier: "OnePhoto_H_NTableViewCell", for: indexPath) as! OnePhoto_H_NTableViewCell
                    
                    /*
                        第一次 无数据 ：查询获取后 写入数组 填入视图
                        之后 有数据： 数组中取得数据 填入视图
                     */

                    if cell.GotPhoto != true {
                    Alamofire.request(FFFFFunctions().GotImageMainServer(ai: ali) + "Zhu00100.jpg")
                        .responseData { response in
                            if let data = response.result.value {
                                let asd = UIImage(data: data)
                                cell.UIImageView_M.image = asd
                            }
                        }
                    } else {
                        print("old-1")
                    }
                    
                    self.TableViewCellHeight = CGFloat(Int(self.DeviceWidth * 0.618 ))
                    return cell
                case "2","3":
                    let aa = Int(DataWords[indexPath.section]![4])!
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ThreePhoto_NTableViewCell", for: indexPath) as! ThreePhoto_NTableViewCell
                    
                    if cell.GotPhoto != true {
                        //print("nnn")
                        for i in 0..<aa
                        {
                            var aaaaaa = [Dictionary<String, UIImage>]()
                            Alamofire.request(FFFFFunctions().GotImageMainServer(ai: ali) + "Zhu000" + String(i + 60) + ".jpg")
                                .responseData { response in
                                if let data = response.result.value {
                                    //print("do23")
                                    switch i {
                                    case 0 :
                                        cell.UIImageView1.image = UIImage(data: data)
                                        aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                    case 1 :
                                        cell.UIImageView2.image = UIImage(data: data)
                                        aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                        if aa == 2{
                                            self.DataPhotos[indexPath.section] = aaaaaa
                                            cell.GotPhoto = true
                                        }
                                    case 2 :
                                        cell.UIImageView3.image = UIImage(data: data)
                                        aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                        if aa == 3{
                                            self.DataPhotos[indexPath.section] = aaaaaa
                                            cell.GotPhoto = true
                                            //print(aaaaaa)
                                        }
                                    default:break
                                    }
                                }
                                
                            }
                        }
                    } else {
                        print("old - 3")
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
                    let cell = tableView.dequeueReusableCell(withIdentifier: "SixPhoto_TableViewCell", for: indexPath) as! SixPhoto_TableViewCell
                    if cell.GotPhoto != true {
                        for i in 0..<aa
                        {
                            var aaaaaa = [Dictionary<String, UIImage>]()
                            Alamofire.request(FFFFFunctions().GotImageMainServer(ai: ali) + "Zhu000" + String(i + 50) + ".jpg")
                                .responseData { response in
                                    if let data = response.result.value {
                                        //print("do456")
                                        switch i {
                                        case 0 :
                                            cell.UIImageView1.image = UIImage(data: data)
                                            aaaaaa.append(["image" + String(i):cell.UIImageView1.image!])
                                        case 1 :
                                            cell.UIImageView2.image = UIImage(data: data)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                        case 2 :
                                            cell.UIImageView3.image = UIImage(data: data)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                        case 3 :
                                            cell.UIImageView4.image = UIImage(data: data)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                            if aa == 4{
                                                self.DataPhotos[indexPath.section] = aaaaaa
                                                //print(aaaaaa)
                                                //print(4)
                                                //print(self.DataPhotos[indexPath.section])
                                                cell.GotPhoto = true
                                            }
                                        case 4 :
                                            cell.UIImageView5.image = UIImage(data: data)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                            if aa == 5{
                                                self.DataPhotos[indexPath.section] = aaaaaa
                                                //print(aaaaaa)
                                                //print(5)
                                                //print(self.DataPhotos[indexPath.section])
                                                cell.GotPhoto = true
                                            }
                                        case 5 :
                                            cell.UIImageView6.image = UIImage(data: data)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                            if aa == 6{
                                                self.DataPhotos[indexPath.section] = aaaaaa
                                                //print(aaaaaa)
                                                //print(6)
                                                //print(self.DataPhotos[indexPath.section])
                                                cell.GotPhoto = true
                                                //print(aaaaaa)
                                            }//
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
                        print("old-6")
                        
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
                    let cell = tableView.dequeueReusableCell(withIdentifier: "NinePhoto_TableViewCell", for: indexPath) as! NinePhoto_TableViewCell
                    
                    if cell.GotPhoto != true {
                    for i in 0..<aa
                    {
                        //print("alaout")
                        var aaaaaa = [Dictionary<String, UIImage>]()
                        //print(FFFFFunctions().GotImageMainServer(ai: ali))
                        Alamofire.request(FFFFFunctions().GotImageMainServer(ai: ali) + "Zhu000" + String(i + 70) + ".jpg")
                                .responseData { response in
                                   // print("alain")
                                    if let data = response.result.value {
                                        //print("do789")
                                        switch i {
                                        case 0 :
                                            cell.UIImageView1.image = UIImage(data: data)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                        case 1 :
                                            cell.UIImageView2.image = UIImage(data: data)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                        case 2 :
                                            cell.UIImageView3.image = UIImage(data: data)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                        case 3 :
                                            cell.UIImageView4.image = UIImage(data: data)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                        case 4 :
                                            cell.UIImageView5.image = UIImage(data: data)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                        case 5 :
                                            cell.UIImageView6.image = UIImage(data: data)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                        case 6 :
                                            cell.UIImageView7.image = UIImage(data: data)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                            if aa == 7{
                                                self.DataPhotos[indexPath.section] = aaaaaa
                                                cell.GotPhoto = true
                                            }
                                        case 7 :
                                            cell.UIImageView8.image = UIImage(data: data)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                            if aa == 8{
                                                self.DataPhotos[indexPath.section] = aaaaaa
                                                cell.GotPhoto = true
                                            }
                                        case 8 :
                                            cell.UIImageView9.image = UIImage(data: data)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                            if aa == 9{
                                                self.DataPhotos[indexPath.section] = aaaaaa
                                                cell.GotPhoto = true
                                                //print(aaaaaa)
                                            }
                                        default:break
                                        }
                                    }
                                    else
                                    {
                                        print("fall")
                                    }
                            }
                        }}
                    else{
                        print("old-9")
                    }
                    
                    TableViewCellHeight = DeviceWidth
                    return cell
                default:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "OnePhoto_Z_NTableViewCell", for: indexPath) as! OnePhoto_Z_NTableViewCell
                    return cell
                }
            default://三按钮区
                let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsPraiseDemote_NTableViewCell", for: indexPath) as! CommentsPraiseDemote_NTableViewCell
                cell.number = [110,112,119]
                cell.UpDateUI()
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
    
    
    func ConnectNib() {
        UITableView_Main.register(UINib(nibName: "OnePhoto_H_NTableViewCell", bundle: nil), forCellReuseIdentifier: "OnePhoto_H_NTableViewCell")
        UITableView_Main.register(UINib(nibName: "ThreePhoto_NTableViewCell", bundle: nil), forCellReuseIdentifier: "ThreePhoto_NTableViewCell")
        UITableView_Main.register(UINib(nibName: "SixPhoto_TableViewCell", bundle: nil), forCellReuseIdentifier: "SixPhoto_TableViewCell")
        UITableView_Main.register(UINib(nibName: "NinePhoto_TableViewCell", bundle: nil), forCellReuseIdentifier: "NinePhoto_TableViewCell")
        UITableView_Main.register(UINib(nibName: "OnePhoto_Z_NTableViewCell", bundle: nil), forCellReuseIdentifier: "OnePhoto_Z_NTableViewCell")
        
        UITableView_Main.register(UINib(nibName: "Advertisement_TableViewCell", bundle: nil), forCellReuseIdentifier: "Advertisement_TableViewCell")
        UITableView_Main.register(UINib(nibName: "CommentsPraiseDemote_NTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentsPraiseDemote_NTableViewCell")
        UITableView_Main.register(UINib(nibName: "News_Information_TableViewCell", bundle: nil), forCellReuseIdentifier: "News_Information_TableViewCell")
    }
    
    
}

