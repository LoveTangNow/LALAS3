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
    @IBOutlet weak var UIBarButtonItem_right: UIBarButtonItem!
    @IBOutlet weak var UIBarButtonItem_left: UIBarButtonItem!
    /** TableViewcell 高度*/
    var TableViewCellHeight:CGFloat = 200
    /**设备宽度*/
    var DeviceWidth =  UIScreen.main.bounds.width
    
    /**动态数据*/
    var DataWords = Dictionary<Int,[String]>()//每一个 ID 对应着一个字符串数组 包括各种信息：NewsID,SenderID,SenderName,SendTime,SendDevice,Detail
    /**动态图片数据*/
    var DataPhotoNames = Dictionary<Int,[String]>()//每一个 ID 对应着一个字符串数组 图片名称们
    
    var row = 0
    /**是否请求阿里云服务器*/
    var ali = true
    
    var MODEL = FirstPageModel()
    
    
    /**顶部 Bar右侧按钮点击*/
    @IBAction func Right_Click(_ sender: AnyObject) {
        //ViewPhotoViewController
        self.tabBarController?.tabBar.isHidden = true
        let vc = UIStoryboard(name: "T", bundle: nil).instantiateViewController(withIdentifier: "SomeOne_ViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /**顶部 左侧侧按钮点击*/
    @IBAction func Send_Click(_ sender: AnyObject) {
        //SendNewMessiageViewController
        
        let vc = UIStoryboard(name: "First", bundle: nil).instantiateViewController(withIdentifier: "SendNewMessiageViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK: - 函数
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "动态"
        self.UITableView_Main.tableFooterView = UIView(frame:CGRect.zero)
        
        UITableView_Main.dataSource = self
        UITableView_Main.delegate = self
        
        self.view.addSubview(imagewhite)
        self.imagewhite.image = #imageLiteral(resourceName: "White")
        self.imagewhite.layer.cornerRadius = 2
        self.imagewhite.clipsToBounds = true
        self.imagewhite.isHidden = true
        
        myview.frame =  CGRect(x:0,y:64,width:UIScreen.main.bounds.width,height:0)
        myview.backgroundColor = UIColor.blue
        self.view.addSubview(myview)
        
        myWord.text = "松手刷新"
        myWord.center = myview.center
        self.view.addSubview(myWord)

        
        ConnectNib()
        // Do any additional setup after loading the view.
        print("viewDidLoad")
        /*
        if let userid = Defalts_ReadWrite().ReadDefalts_String(KEY: "user_id"){
            parameters = ["userid": userid]
        } else {
            //表明来自首页
            let RegisterBool :Bool = true
            UserDefaults.standard.set(RegisterBool, forKey: "data1")
            UserDefaults.standard.synchronize()
            
            let sb = UIStoryboard(name: "Main", bundle:nil)
            let vc = sb.instantiateViewController(withIdentifier: "Login_ViewController") as! Login_ViewController
            self.present(vc, animated: false, completion: nil)
        }*/
        
    }
    var parameters = Parameters()
    
    private func GetDataWithHUD(parameters:Parameters) -> () {
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)//前后颜色
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.native)//菊花
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.show()
        DataPhotoNames.removeAll()
        DataWords.removeAll()
        Alamofire.request(GotServers().GotServerAliScripts() + "GIVE_BACK_INFORMATION.php", method: .post, parameters: parameters)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    let json = JSON(response.result.value)
                    print(json)
                    
                    for i in 0..<json.count
                    {
                        let new_i = json.count - 1 - i
                        //    0     1      2       3          4          5        6
                        // detail device newsid newstime photohumber senderid sendername
                        let aaaaaaaaaaa = [json[new_i]["detail"].string!,json[new_i]["device"].string!,json[new_i]["newsid"].string!,json[new_i]["newstime"].string!,json[new_i]["photonumer"].string!,json[new_i]["senderid"].string!,json[new_i]["sendername"].string!]
                        self.DataWords[self.DataWords.count] = aaaaaaaaaaa
                        
                        let NumberOfPhotos = Int(json[new_i]["photonumer"].string!)!
                        var ArryOfNameOfPhotos = [String]()
                        for j in 0..<NumberOfPhotos
                        {
                            let a = json[new_i ]["photo"][j].string!
                            ArryOfNameOfPhotos.append(a)
                        }
                        self.DataPhotoNames[self.DataPhotoNames.count] = ArryOfNameOfPhotos
                    }
                    
                    //print(self.DataWords)
                    //print(self.DataPhotoNames)
                    
                    self.UITableView_Main.reloadData()
                    SVProgressHUD.dismiss()
                case .failure(let error):
                    print(error)
                    SVProgressHUD.dismiss()
                }
            }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.navigationBar.tintColor = UIColor.white
        tabBarController?.tabBar.isHidden = false
        self.UITableView_Main.isHidden = false
        
        if let a = Defalts_ReadWrite().ReadDefalts_String(KEY: "user_id") {
            if a == "" {
                GotoLogin()
            } else {
                let whereifrom = Defalts_ReadWrite().ReadDefalts_String(KEY: "whereifrom")!
                if whereifrom == "SendNewMessiageViewController" {
                    parameters = ["userid": a]
                    print(parameters)
                    GetDataWithHUD(parameters: parameters)
                }
            }
        }
        else{
            GotoLogin()
        }
    }
    
    func GotoLogin() -> () {
        let alertController = UIAlertController(title: "系统提示",
                                                message: "您需要登录",
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: {
            action in
            self.UITableView_Main.isHidden = true
        })
        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
            action in
            let sb = UIStoryboard(name: "Main", bundle:nil)
            let vc = sb.instantiateViewController(withIdentifier: "Login_ViewController") as! Login_ViewController
            self.present(vc, animated: false, completion: nil)
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        
        
        self.navigationController?.navigationBar.isHidden = false
        if inlema == true {
            UIView.animate(withDuration: 0.2, animations: {
                self.imageviewzooooom.frame = self.rext3
                }, completion: { (_) in
                    self.inlema = false
                    
                    self.imageviewzooooom.frame = self.rext3
                    self.imageviewzooooom.isHidden = true
                    self.imagewhite.isHidden = true
                }
            )
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**放大缩小的 ImageView*/
    var imageviewzooooom = UIImageView()
    /**占位 ImageView:白色*/
    var imagewhite = UIImageView()
    /** 动画是否启动了*/
    var inlema  = false
    /**存放缩小的 frame*/
    var rext3 = CGRect()
    
    
    /**跳转到图片详情页*/
    func GoDetail (_ sender:UIButton)  {
        
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.imageviewzooooom.contentMode = .scaleAspectFill
        self.imageviewzooooom.clipsToBounds = true
        
        let imageviewzooooom_ = UIImageView(image:sender.currentImage)
        let imagekuangaobi = imageviewzooooom_.frame.height / imageviewzooooom_.frame.width //获取宽高比
        //let w  = (UIScreen.main.bounds.width - 20 - 6) / 3
        //imageviewzooooom.frame = CGRect(x:UIScreen.main.bounds.width,y:UIScreen.main.bounds.height,width:w,height:w)
        
        imageviewzooooom_.image = #imageLiteral(resourceName: "Black")
        imageviewzooooom_.frame = CGRect(x:0,y:0,width:UIScreen.main.bounds.width,height:UIScreen.main.bounds.height)
        imageviewzooooom_.alpha = 0
        self.view.addSubview(imageviewzooooom_)
        
        imageviewzooooom.layer.cornerRadius = 2
        self.view.addSubview(imageviewzooooom)
        imageviewzooooom.image = sender.currentImage
        
        var indexPath = IndexPath()
        indexPath = self.UITableView_Main.indexPath(for: sender.superview?.superview as! UITableViewCell)!
        let a = GotPhoto(A: DataWords[indexPath.section]![4], indexpath: indexPath)//获取图片组 和图片数目
        let vc = UIStoryboard(name: "First", bundle: nil).instantiateViewController(withIdentifier: "ViewPhotoWithScroll_ViewController") as!  ViewPhotoWithScroll_ViewController
        vc.imagelist = a.0
        vc.imgaeNumber = a.1
        vc.image_Dijizhang = sender.tag
        
        /*
        print("-------------")
        print(imagekuangaobi)
        print(a.1)
        print(sender.tag)
        print(vc.image_Dijizhang)
        print("-------------")*/

        let window = UIApplication.shared.keyWindow
        let rext1 = sender.convert(sender.frame, from: sender.superview)
        let rext2 = sender.convert(rext1, to: window)
        rext3 = rext2.insetBy(dx: -0.5 * 8, dy: -0.5 * 8)//点击的 button 的frame位置
        
        if inlema == false {
            UIView.animate(withDuration: 0, animations: {
                self.imageviewzooooom.isHidden = false
                self.imageviewzooooom.frame = self.rext3
                self.imagewhite.frame = self.rext3
                self.imagewhite.isHidden = false
                }, completion: { _ in
                    UIView.animate(withDuration: 0.3, animations:{
                        imageviewzooooom_.alpha = 1
                        //self.imageviewzooooom.center = self.view.center
                        self.imageviewzooooom.frame = CGRect(x:0,y:(UIScreen.main.bounds.height / 2) - (UIScreen.main.bounds.width * imagekuangaobi / 2),width:UIScreen.main.bounds.width,height:UIScreen.main.bounds.width * imagekuangaobi)
                        self.navigationController?.navigationBar.alpha = 0
                        },
                        completion: { (_) in
                            self.navigationController?.pushViewController(vc, animated: false)
                            self.inlema = true
                            imageviewzooooom_.removeFromSuperview()
                            self.navigationController?.navigationBar.alpha = 1
                            self.navigationController?.navigationBar.isHidden = true
                        }
                    )
                }
            )
        }
    }
    
    func GoDetaillllll()  {
        print("click")
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
            UserDefaults.standard.synchronize()
            vc.imagelist = a.0
            vc.imgaeNumber = a.1
            
            let aaaaaaaaaaa = UITableView_Main.cellForRow(at: indexPath)! as! News_Information_TableViewCell
            vc.imageicon = (aaaaaaaaaaa.userIcon.imageView?.image)!
            vc.label1 = aaaaaaaaaaa.UILabelUserName.text!
            vc.label2 = aaaaaaaaaaa.UILabelInformation.text!
            vc.label3 = aaaaaaaaaaa.UILabelDetail.text!
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if DataWords.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Advertisement_TableViewCell", for: indexPath) as! Advertisement_TableViewCell
            cell.imgae_main.setBackgroundImage(#imageLiteral(resourceName: "White"), for: .normal)
            TableViewCellHeight = UIScreen.main.bounds.height
            return cell
        } else {
            switch indexPath.row {
            case 0://文字区
                let cell = tableView.dequeueReusableCell(withIdentifier: "News_Information_TableViewCell", for: indexPath) as! News_Information_TableViewCell
                Alamofire.request(GotServers().GotImageIconServer(ai: ali) + String(DataWords[indexPath.section]![5] ) + ".png")
                    .responseData { response in
                        if let data = response.result.value {
                            let asd = UIImage(data: data)
                            cell.userIcon.setImage(asd, for: UIControlState.normal)
                        }
                }
                cell.setting.setBackgroundImage(#imageLiteral(resourceName: "White"), for: .normal)
                cell.UIImageViewV_.image = #imageLiteral(resourceName: "v")
                cell.UIImageViewVip_.image = #imageLiteral(resourceName: "alipay")
                cell.setting.setImage(#imageLiteral(resourceName: "setting"), for: .normal)
                
                //  0       1      2       3        4           5         6
                // detail device newsid newstime photohumber senderid sendername
                cell.UILabelDetail.text = DataWords[indexPath.section]![0] + DataWords[indexPath.section]![4]
                cell.UILabelUserName.text = DataWords[indexPath.section]![6]
                
                let time = DataWords[indexPath.section]![3]
                let device = DataWords[indexPath.section]![1]//长度12 1234 12 34 12 34
                
                let year = time.substring(to: time.index(time.startIndex, offsetBy: 4))
                let month = FFFFFunctions().getsubtring(string: time, space_start: 4, space_end: 6)
                let day = FFFFFunctions().getsubtring(string: time, space_start: 6, space_end: 8)
                let hour = FFFFFunctions().getsubtring(string: time, space_start: 8, space_end: 10)
                let minute = time.substring(from: time.index(time.startIndex, offsetBy: 10))
                
                cell.UILabelInformation.text  =  year + "年" + month + "日" + day + "日 " + hour + ":" + minute + " 来自" + device

                TableViewCellHeight = WorksHieghts().WorkWordsHeightForInformation(Words: cell.UILabelDetail.text!)
                
                return cell
            case 1://图片区
                switch DataWords[indexPath.section]![4] {
                case "0":
                    let cell = tableView.dequeueReusableCell(withIdentifier: "Advertisement_TableViewCell", for: indexPath) as! Advertisement_TableViewCell
                    self.TableViewCellHeight = 0
                    return cell
                case "1":
                    let cell = tableView.dequeueReusableCell(withIdentifier: "OnePhoto_H_NTableViewCell", for: indexPath) as! OnePhoto_H_NTableViewCell
                    if cell.GotPhoto != true {
                    let a = DataPhotoNames[indexPath.section]![0]
                    Alamofire.request(GotServers().GotImageTServer(ai: ali) + a + ".jpeg")
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
                    
                    self.TableViewCellHeight = WorksHieghts().WorkWordsHeightForPhotots(photoNumber: 1)
                    return cell
                case "2","3":
                    let imageNumberForThisCell = Int(DataWords[indexPath.section]![4])!
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ThreePhoto_NTableViewCell", for: indexPath) as! ThreePhoto_NTableViewCell
                    
                    if cell.GotPhoto != true {
                        for i in 0..<imageNumberForThisCell
                        {
                            let a = DataPhotoNames[indexPath.section]![i]
                            Alamofire.request(GotServers().GotImageTServer(ai: ali) + a + ".jpeg")
                                .responseData { response in
                                if let data = response.result.value {
                                    switch i {
                                    case 0 :
                                        cell.image_1.setImage(UIImage(data: data), for: .normal)
                                        cell.image_1.addTarget(self, action: #selector(self.GoDetail), for: UIControlEvents.touchUpInside)
                                        cell.image_1.tag = 1
                                    case 1 :
                                        cell.image_2.setImage(UIImage(data: data), for: .normal)
                                        cell.image_2.addTarget(self, action: #selector(self.GoDetail), for: UIControlEvents.touchUpInside)
                                        cell.image_2.tag = 2
                                    case 2 :
                                        cell.image_3.setImage(UIImage(data: data), for: .normal)
                                        cell.image_3.addTarget(self, action: #selector(self.GoDetail), for: UIControlEvents.touchUpInside)
                                        cell.image_3.tag = 3
                                    default:break
                                    }
                                    if i == imageNumberForThisCell{
                                        cell.GotPhoto = true
                                    }
                                }
                            }
                        }
                    } else {
                        print("old - 3")
                    }
                    
                    TableViewCellHeight = WorksHieghts().WorkWordsHeightForPhotots(photoNumber: 3)
                    return cell

                case "4","5","6":
                    let imageNumberForThisCell = Int(DataWords[indexPath.section]![4])!
                    let cell = tableView.dequeueReusableCell(withIdentifier: "SixPhoto_TableViewCell", for: indexPath) as! SixPhoto_TableViewCell
                    if cell.GotPhoto != true {
                        for i in 0..<imageNumberForThisCell
                        {
                            let a_imageName = DataPhotoNames[indexPath.section]![i]
                            Alamofire.request(GotServers().GotImageTServer(ai: ali) + a_imageName + ".jpeg")
                                .responseData { response in
                                if let data = response.result.value {
                                    switch i {
                                    case 0 :
                                        cell.image_1.setImage(UIImage(data: data), for: .normal)
                                        cell.image_1.addTarget(self, action: #selector(self.GoDetail), for: UIControlEvents.touchUpInside)
                                        cell.image_1.tag = 1
                                    case 1 :
                                        cell.image_2.setImage(UIImage(data: data), for: .normal)
                                        cell.image_2.addTarget(self, action: #selector(self.GoDetail), for: UIControlEvents.touchUpInside)
                                        cell.image_2.tag = 2
                                    case 2 :
                                        cell.image_3.setImage(UIImage(data: data), for: .normal)
                                        cell.image_3.addTarget(self, action: #selector(self.GoDetail), for: UIControlEvents.touchUpInside)
                                        cell.image_3.tag = 3
                                    case 3 :
                                        cell.image_4.setImage(UIImage(data: data), for: .normal)
                                        cell.image_4.addTarget(self, action: #selector(self.GoDetail), for: UIControlEvents.touchUpInside)
                                        cell.image_4.tag = 4
                                    case 4 :
                                        cell.image_5.setImage(UIImage(data: data), for: .normal)
                                        cell.image_5.addTarget(self, action: #selector(self.GoDetail), for: UIControlEvents.touchUpInside)
                                        cell.image_5.tag = 5
                                    case 5 :
                                        cell.image_6.setImage(UIImage(data: data), for: .normal)
                                        cell.image_6.addTarget(self, action: #selector(self.GoDetail), for: UIControlEvents.touchUpInside)
                                        cell.image_6.tag = 6
                                    default:break
                                    }
                                    if i == imageNumberForThisCell{
                                        cell.GotPhoto = true
                                    }
                                }
                            }
                        }

                    } else {
                        print("old-6")
                    }
                    
                    TableViewCellHeight = WorksHieghts().WorkWordsHeightForPhotots(photoNumber: 4)
                    return cell
                case "7","8","9":
                    let imageNumberForThisCell = Int(DataWords[indexPath.section]![4])!
                    let cell = tableView.dequeueReusableCell(withIdentifier: "NinePhoto_TableViewCell", for: indexPath) as! NinePhoto_TableViewCell
                    
                    cell.image_1.tag = 1
                    cell.image_2.tag = 2
                    cell.image_3.tag = 3
                    cell.image_4.tag = 4
                    cell.image_5.tag = 5
                    cell.image_6.tag = 6
                    cell.image_7.tag = 7
                    cell.image_8.tag = 8
                    cell.image_9.tag = 9
                    
                    if cell.GotPhoto != true {
                    for i in 0..<imageNumberForThisCell
                    {
                        Alamofire.request(GotServers().GotImageMainServer(ai: ali) + "Zhu000" + String(i + 70) + ".jpg")
                                .responseData { response in
                                if let data = response.result.value {
                                    switch i {
                                    case 0 :
                                        cell.image_1.setImage(UIImage(data: data), for: .normal)
                                        cell.image_1 .addTarget(self, action: #selector(self.GoDetail), for: UIControlEvents.touchUpInside)
                                    case 1 :
                                        cell.image_2.setImage(UIImage(data: data), for: .normal)
                                        cell.image_2.addTarget(self, action: #selector(self.GoDetail), for: UIControlEvents.touchUpInside)
                                    case 2 :
                                        cell.image_3.setImage(UIImage(data: data), for: .normal)
                                        cell.image_3.addTarget(self, action: #selector(self.GoDetail), for: UIControlEvents.touchUpInside)
                                    case 3 :
                                        cell.image_4.setImage(UIImage(data: data), for: .normal)
                                        cell.image_4.addTarget(self, action: #selector(self.GoDetail), for: UIControlEvents.touchUpInside)
                                    case 4 :
                                        cell.image_5.setImage(UIImage(data: data), for: .normal)
                                        cell.image_5.addTarget(self, action: #selector(self.GoDetail), for: UIControlEvents.touchUpInside)
                                    case 5 :
                                        cell.image_6.setImage(UIImage(data: data), for: .normal)
                                        cell.image_6.addTarget(self, action: #selector(self.GoDetail), for: UIControlEvents.touchUpInside)
                                    case 6 :
                                        cell.image_7.setImage(UIImage(data: data), for: .normal)
                                        cell.image_7.addTarget(self, action: #selector(self.GoDetail), for: UIControlEvents.touchUpInside)
                                    case 7 :
                                        cell.image_8.setImage(UIImage(data: data), for: .normal)
                                        cell.image_8.addTarget(self, action: #selector(self.GoDetail), for: UIControlEvents.touchUpInside)
                                    case 8 :
                                        cell.image_9.setImage(UIImage(data: data), for: .normal)
                                        cell.image_9.addTarget(self, action: #selector(self.GoDetail), for: UIControlEvents.touchUpInside)
                                    default:break
                                    }
                                }
                            }
                        }
                    }
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
        if DataWords.isEmpty {
            return 1
        }
        return DataWords.count 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if DataWords.isEmpty {
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
    //////////
    var myview = UIView()
    var myWord = UILabel()
    var old:CGFloat = 0
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        /*
         小于70，展示下拉刷新：松开上滑
         大于70，展开松开刷新：松开上滑到70，刷新并且更新数据，上滑到0
         */
        //print("--")
        //print(self.UITableView_Main.contentInset.top)
        //print(-self.UITableView_Main.contentOffset.y)//现在的位置
        let heightToNavagateBarBottom = -self.UITableView_Main.contentOffset.y - 64
        let space = heightToNavagateBarBottom - old
        //print(space)
        let myViewAlpha = (heightToNavagateBarBottom)/70
        //print(myViewAlpha)
        myview.alpha = myViewAlpha
        if -self.UITableView_Main.contentOffset.y - self.UITableView_Main.contentInset.top <= 90{
            myview.backgroundColor = UIColor.blue
            UIView.animate(withDuration: 0, animations: {
                self.myview.frame =  CGRect(x:0,y:64,width:UIScreen.main.bounds.width,height:heightToNavagateBarBottom)
            })
        }
        else{//到90的时候就会触发，这个时候开始
            myview.backgroundColor = UIColor.red
            UIView.animate(withDuration: 0, animations: {
                self.myview.frame =  CGRect(x:0,y:64,width:UIScreen.main.bounds.width,height:heightToNavagateBarBottom)
            })
            if space > 0  {
                willReloadData = true
            }
            //UITableView_M.isScrollEnabled = true
        }
        old = heightToNavagateBarBottom
        myWord.center = myview.center
    }
    
    var willReloadData = false
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if willReloadData == true {
            DataPhotoNames.removeAll()
            DataWords.removeAll()
            if let userid = Defalts_ReadWrite().ReadDefalts_String(KEY: "user_id"){
                let parameters: Parameters = ["userid": userid]
                GetDataWithHUD(parameters: parameters)
            } else {
                let sb = UIStoryboard(name: "Main", bundle:nil)
                let vc = sb.instantiateViewController(withIdentifier: "Login_ViewController") as UIViewController
                self.present(vc, animated: true, completion: nil)
            }
            willReloadData = false
        }
        print("scrollViewDidEndDecelerating")
        

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

