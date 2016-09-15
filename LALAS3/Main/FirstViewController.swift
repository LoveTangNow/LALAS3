//
//  FirstViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/14.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

import Alamofire
//网络请求
import SVProgressHUD




class FirstViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    //MARK: - 绑定 和 变量

    @IBOutlet weak var UITableView_Main: UITableView!
    
    var TableViewCellHeight:CGFloat = 200
    var Server:String = ""
    var ServerImageIcon:String = ""
    var ServerImageMain:String = ""
    var ServerImageAD:String = ""
    var ServerImageT:String = ""
    var DeviceWidth =  UIScreen.main.bounds.width
    
    
    
    //肌肤默认的图片
    var Imageload_Black:UIImage = UIImage(named: "Black.png")!
    var Imageload_Wight:UIImage = UIImage(named: "White.png")!
    var ImageloadBackGroud:UIImage = UIImage(named: "FirstBackGround.png")!
    var ImageloadBackGroudn:UIImage = UIImage(named: "BackGround.png")!
    //数据存储
    var DataWords = Dictionary<Int,[String]>()//每一个 ID 对应着一个字符串数组 包括各种信息：NewsID,SenderID,SenderName,SendTime,SendDevice,Detail
    var DataPhotoNames = Dictionary<Int,[String]>()//每一个 ID 对应着一个字符串数组 图片名称们
    var DataPhotos = Dictionary<Int,[UIImage]>()//每一个 ID 对应着一个UIImage数组 图片们
    
    
    //MARK: - 函数
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "动态"
        
        UITableView_Main.dataSource = self
        UITableView_Main.delegate = self
        //这里给 Tableview 准备数据
        let diaryList:String = Bundle.main.path(forResource: "/Server", ofType:"plist")!
        let data:NSMutableDictionary = NSMutableDictionary(contentsOfFile:diaryList)!
        Server = data.object(forKey: "Server") as! String
        ServerImageIcon = data.object(forKey: "ServerImageIcon") as! String
        ServerImageT = data.object(forKey: "ServerImageT") as! String
        ServerImageMain = data.object(forKey: "ServerImageMain") as! String
        ServerImageAD = data.object(forKey: "ServerImageAD") as! String
        
        print(Server)
        print(ServerImageMain)
        print(ServerImageAD)
        print(ServerImageT)
        print(ServerImageIcon)
        
        let parameters: Parameters = [
            "foo": [1,2,3],
            "bar": [
                "baz": "qux"
            ]
        ]
        
        /*
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)//前后颜色
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.native)//菊花
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.show()
        */
        
        // Both calls are equivalent
        Alamofire.request(Server + "SIGNIN.php", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { response in
                
                //SVProgressHUD.dismiss()
                print(response.result.value )
                /*switch response.result {
                case .success:
                    print("Validation Successful")
                case .failure(let error):
                    print(error)
                }*/
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {

        
        //这里给 Tableview 写数据
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Words_TableViewCell", for: indexPath) as! Words_TableViewCell
            
            cell.UIImageView_UserIcon.image = Imageload_Black
            cell.UIImageView_Setting.image = Imageload_Black
            
            cell.UIImageView_V.image = Imageload_Wight
            cell.UIImageView_VIP.isHidden = false
            cell.UIImageView_VIP.image = Imageload_Black
            
            cell.UILabel_UserName.text = "ThomasLiu"
            cell.UILabel_TimeAndDevice.text = "lalallalal"
            cell.UILabel_Detail.text = "啊发发还是地方哈迪斯阿卡哈尔法和发达阿什顿啦"
            
            /*
             主字号用的是 13 号字体
             iphone 5 = 320.0
             iphone 5s = 320.0
             
             iphone 6 = 375.0
             iphone 6p = 414.0
             
             iphone 6s = 375.0
             iphone 6sp = 414.0
             
             iphone 7 = 375.0
             iphone 7p = 414.0
             */
            
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
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OnePhoto_H_TableViewCell", for: indexPath) as! OnePhoto_H_TableViewCell
            cell.UIImageView_Main.image = Imageload_Black
            return cell

        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OnePhoto_Z_TableViewCell", for: indexPath) as! OnePhoto_Z_TableViewCell
             cell.UIImageView_Main.image = Imageload_Black
            return cell

        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TwoThreePhoto_TableViewCell", for: indexPath) as! TwoThreePhoto_TableViewCell
            cell.UIImageView_2.image = Imageload_Black
            return cell

        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FourFiveSix_TableViewCell", for: indexPath) as! FourFiveSix_TableViewCell
            cell.UIImageView_2.image = Imageload_Black
            cell.UIImageView_5.image = Imageload_Black
            return cell

        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SevenEightNinePhoto_TableViewCell", for: indexPath) as! SevenEightNinePhoto_TableViewCell
            cell.UIImageView_5.image = Imageload_Black
            return cell

        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AD_TableViewCell", for: indexPath) as! AD_TableViewCell
            cell.UIImageView_Main.image = Imageload_Black
            return cell

        }
        

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableViewCellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    

    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
       print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
    }

}
