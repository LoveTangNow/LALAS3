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
    
    var imageviewzooooom = UIImageView()
    
    
    //MARK: - 函数
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
    }
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
                        //    0     1      2       3          4          5        6
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
        
        let w  = (UIScreen.main.bounds.width - 20 - 6) / 3
        imageviewzooooom.frame = CGRect(x:UIScreen.main.bounds.width,y:UIScreen.main.bounds.height,width:w,height:w)
        imageviewzooooom.layer.cornerRadius = 2
        imageviewzooooom.backgroundColor = UIColor.black
        
        self.view.addSubview(imageviewzooooom)
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
        if inlema == true {
            UIView.animate(withDuration: 1, animations: {
                //let i = sender.currentImage
                //self.imageviewzooooom.frame = CGRect(x:0,y:0,width:UIScreen.main.bounds.width / 3,height:UIScreen.main.bounds.width / 3)
                self.imageviewzooooom.frame = self.rext3
                //self.imageviewzooooom.center = self.view.center
                }, completion: { (_) in
                    self.inlema = false
                    self.imageviewzooooom.frame = CGRect(x:UIScreen.main.bounds.width,y:UIScreen.main.bounds.height,width:UIScreen.main.bounds.width / 3,height:UIScreen.main.bounds.width / 3)
                    //self.imageviewzooooom.frame = self.rext3
                }
            )
        }
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
    
    var inlema  = false
    var rext3 = CGRect()
    
    
    /**跳转到图片详情页*/
    func GoDetail (_ sender:UIButton)  {
        var indexPath = IndexPath()
        indexPath = self.UITableView_Main.indexPath(for: sender.superview?.superview as! UITableViewCell)!
        let a = GotPhoto(A: DataWords[indexPath.section]![4], indexpath: indexPath)//获取图片组 和图片数目
        let vc = UIStoryboard(name: "First", bundle: nil).instantiateViewController(withIdentifier: "ViewPhotoWithScroll_ViewController") as!  ViewPhotoWithScroll_ViewController
        vc.imagelist = a.0
        vc.imgaeNumber = a.1
        vc.image_Dijizhang = sender.tag
        //print(DataPhotos)
        let cell = UITableView_Main.cellForRow(at: indexPath)
        
        print("-------------")
        print(sender.center)
        print(sender.superview?.superview?.center)
        print(cell?.center)
        print("-------------")

        let window = UIApplication.shared.keyWindow
        let button = sender
        
        let rext1 = button.convert(button.frame, from: button.superview)
        let rext2 = button.convert(rext1, to: window)
        rext3 = rext2.insetBy(dx: -0.5 * 8, dy: -0.5 * 8)
        
        print(rext3)
        
        self.imageviewzooooom.image = sender.currentImage

        if inlema == false {
            UIView.animate(withDuration: 0, animations: {
                self.imageviewzooooom.frame = self.rext3
                }, completion: { _ in
                    UIView.animate(withDuration: 0.5, animations:{
                        //let i = sender.currentImage
                        //self.imageviewzooooom.contentMode = .scaleAspectFill
                        self.imageviewzooooom.frame = CGRect(x:0,y:(UIScreen.main.bounds.height / 2) - (UIScreen.main.bounds.width / 2),width:UIScreen.main.bounds.width,height:UIScreen.main.bounds.width)
                        },
                        completion: { (_) in
                            self.navigationController?.pushViewController(vc, animated: false)
                            self.inlema = true
                        }
                        )
                }
            )

        }
        
    }
    
    //MARK: - TableView
    /*
     tableview 的工作是在viewDidLoad 和 viewWillAppear 之后做的
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            var aa = indexPath
            aa.row += 1
            let a = GotPhoto(A: DataWords[indexPath.section]![4], indexpath: aa)
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
            vc.imagelist = a.0
            vc.imgaeNumber = a.1
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if DataWords.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Advertisement_TableViewCell", for: indexPath) as! Advertisement_TableViewCell
            cell.imgae_main.setImage(#imageLiteral(resourceName: "Black"), for: .normal)
            return cell
        } else {
            switch indexPath.row {
            case 0://文字区
                let cell = tableView.dequeueReusableCell(withIdentifier: "News_Information_TableViewCell", for: indexPath) as! News_Information_TableViewCell
                Alamofire.request(FFFFFunctions().GotImageIconServer(ai: ali) + String(DataWords[indexPath.section]![5] ) + ".png")
                    .responseData { response in
                        if let data = response.result.value {
                            let asd = UIImage(data: data)
                            cell.userIcon.setImage(asd, for: UIControlState.normal)
                        }
                }
                cell.setting.setBackgroundImage(#imageLiteral(resourceName: "Black"), for: .normal)
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
                    
                    if cell.GotPhoto != true {
                    Alamofire.request(FFFFFunctions().GotImageMainServer(ai: ali) + "Zhu00100.jpg")
                        .responseData { response in
                            if let data = response.result.value {
                                let asd = UIImage(data: data)
                                cell.image_1.setImage(asd, for: UIControlState.normal)
                            }
                        }
                    } else {
                        print("old-1")
                    }
                    cell.image_1.tag = 1
                    cell.image_1.addTarget(self, action: #selector(GoDetail), for: UIControlEvents.touchUpInside)
                    
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
                                        cell.image_1.setImage(UIImage(data: data), for: .normal)
                                        aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                    case 1 :
                                        cell.image_2.setImage(UIImage(data: data), for: .normal)
                                        aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                        if aa == 2{
                                            self.DataPhotos[indexPath.section] = aaaaaa
                                            cell.GotPhoto = true
                                        }
                                    case 2 :
                                        cell.image_3.setImage(UIImage(data: data), for: .normal)
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
                    }
                    cell.image_1.addTarget(self, action: #selector(GoDetail), for: UIControlEvents.touchUpInside)
                    cell.image_2.addTarget(self, action: #selector(GoDetail), for: UIControlEvents.touchUpInside)
                    cell.image_3.addTarget(self, action: #selector(GoDetail), for: UIControlEvents.touchUpInside)
                    
                    cell.image_1.tag = 1
                    cell.image_2.tag = 2
                    cell.image_3.tag = 3
                    
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
                                            cell.image_1.setImage(UIImage(data: data), for: .normal)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                        case 1 :
                                            cell.image_2.setImage(UIImage(data: data), for: .normal)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                        case 2 :
                                            cell.image_3.setImage(UIImage(data: data), for: .normal)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                        case 3 :
                                            cell.image_4.setImage(UIImage(data: data), for: .normal)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                            if aa == 4{
                                                self.DataPhotos[indexPath.section] = aaaaaa
                                                //print(aaaaaa)
                                                //print(4)
                                                //print(self.DataPhotos[indexPath.section])
                                                cell.GotPhoto = true
                                            }
                                        case 4 :
                                            cell.image_5.setImage(UIImage(data: data), for: .normal)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                            if aa == 5{
                                                self.DataPhotos[indexPath.section] = aaaaaa
                                                //print(aaaaaa)
                                                //print(5)
                                                //print(self.DataPhotos[indexPath.section])
                                                cell.GotPhoto = true
                                            }
                                        case 5 :
                                            cell.image_6.setImage(UIImage(data: data), for: .normal)
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
                    }
                    cell.image_1.addTarget(self, action: #selector(GoDetail), for: UIControlEvents.touchUpInside)
                    cell.image_2.addTarget(self, action: #selector(GoDetail), for: UIControlEvents.touchUpInside)
                    cell.image_3.addTarget(self, action: #selector(GoDetail), for: UIControlEvents.touchUpInside)
                    cell.image_4.addTarget(self, action: #selector(GoDetail), for: UIControlEvents.touchUpInside)
                    cell.image_5.addTarget(self, action: #selector(GoDetail), for: UIControlEvents.touchUpInside)
                    cell.image_6.addTarget(self, action: #selector(GoDetail), for: UIControlEvents.touchUpInside)
                    
                    cell.image_1.tag = 1
                    cell.image_2.tag = 2
                    cell.image_3.tag = 3
                    cell.image_4.tag = 1
                    cell.image_5.tag = 2
                    cell.image_6.tag = 3
                    
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
                                            cell.image_1.setImage(UIImage(data: data), for: .normal)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                        case 1 :
                                            cell.image_2.setImage(UIImage(data: data), for: .normal)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                        case 2 :
                                            cell.image_3.setImage(UIImage(data: data), for: .normal)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                        case 3 :
                                            cell.image_4.setImage(UIImage(data: data), for: .normal)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                        case 4 :
                                            cell.image_5.setImage(UIImage(data: data), for: .normal)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                        case 5 :
                                            cell.image_6.setImage(UIImage(data: data), for: .normal)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                        case 6 :
                                            cell.image_7.setImage(UIImage(data: data), for: .normal)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                            if aa == 7{
                                                self.DataPhotos[indexPath.section] = aaaaaa
                                                cell.GotPhoto = true
                                            }
                                        case 7 :
                                            cell.image_8.setImage(UIImage(data: data), for: .normal)
                                            aaaaaa.append(["image" + String(i):UIImage(data: data)!])
                                            if aa == 8{
                                                self.DataPhotos[indexPath.section] = aaaaaa
                                                cell.GotPhoto = true
                                            }
                                        case 8 :
                                            cell.image_9.setImage(UIImage(data: data), for: .normal)
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
                    cell.image_1.addTarget(self, action: #selector(GoDetail), for: UIControlEvents.touchUpInside)
                    cell.image_2.addTarget(self, action: #selector(GoDetail), for: UIControlEvents.touchUpInside)
                    cell.image_3.addTarget(self, action: #selector(GoDetail), for: UIControlEvents.touchUpInside)
                    cell.image_4.addTarget(self, action: #selector(GoDetail), for: UIControlEvents.touchUpInside)
                    cell.image_5.addTarget(self, action: #selector(GoDetail), for: UIControlEvents.touchUpInside)
                    cell.image_6.addTarget(self, action: #selector(GoDetail), for: UIControlEvents.touchUpInside)
                    cell.image_7.addTarget(self, action: #selector(GoDetail), for: UIControlEvents.touchUpInside)
                    cell.image_8.addTarget(self, action: #selector(GoDetail), for: UIControlEvents.touchUpInside)
                    cell.image_9.addTarget(self, action: #selector(GoDetail), for: UIControlEvents.touchUpInside)
                    
                    cell.image_1.tag = 1
                    cell.image_2.tag = 2
                    cell.image_3.tag = 3
                    cell.image_4.tag = 1
                    cell.image_5.tag = 2
                    cell.image_6.tag = 3
                    cell.image_7.tag = 1
                    cell.image_8.tag = 2
                    cell.image_9.tag = 3
                    
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
    
    func GotPhoto(A:String,indexpath:IndexPath) -> ([UIImage?],Int) {
        var imagelist = [UIImage?]()
        var imagenumber_in = Int()
        let a_  = Int(A)!
        
        switch a_ {
        case 1 :
            let a = UITableView_Main.cellForRow(at: indexpath)! as! OnePhoto_H_NTableViewCell
            imagelist.append(a.image_1.currentImage)
            imagenumber_in = 1
            break
        case 2,3:
            let a = UITableView_Main.cellForRow(at: indexpath)! as! ThreePhoto_NTableViewCell
            imagelist.append(a.image_1.currentImage)
            imagelist.append(a.image_2.currentImage)
            imagenumber_in = 2
            if a_ == 3 {
                imagelist.append(a.image_3.currentImage)
                imagenumber_in = 3
            }
            
        case 4,5,6 :
            let a = UITableView_Main.cellForRow(at: indexpath)! as! SixPhoto_TableViewCell
            imagelist.append(a.image_1.currentImage)
            imagelist.append(a.image_2.currentImage)
            imagelist.append(a.image_3.currentImage)
            imagelist.append(a.image_4.currentImage)
            imagenumber_in = 4
            if a_ == 5 {
                imagenumber_in = 5
                imagelist.append(a.image_5.currentImage)
            }
            if a_ == 6 {
                imagenumber_in = 6
                imagelist.append(a.image_5.currentImage)
                imagelist.append(a.image_6.currentImage)
            }
        case 7,8,9:
            let a = UITableView_Main.cellForRow(at: indexpath)! as! NinePhoto_TableViewCell
            imagelist.append(a.image_1.currentImage)
            imagelist.append(a.image_2.currentImage)
            imagelist.append(a.image_3.currentImage)
            imagelist.append(a.image_4.currentImage)
            imagelist.append(a.image_5.currentImage)
            imagelist.append(a.image_6.currentImage)
            imagelist.append(a.image_7.currentImage)
            imagenumber_in = 7
            if a_ == 8 {
                imagelist.append(a.image_8.currentImage)
                imagenumber_in = 8
            }
            if a_ == 9 {
                imagelist.append(a.image_8.currentImage)
                imagelist.append(a.image_9.currentImage)
                imagenumber_in = 9
            }
        default:
            break
        }
        return (imagelist,imagenumber_in)
    }
    
}

