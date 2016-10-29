//
//  FirstViewViewController_.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/10/29.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import CoreData
import SDWebImage

class FirstViewViewController_: UIViewController ,UITableViewDelegate,UITableViewDataSource{


    //////////
    var myview = UIView()
    var myWord = UILabel()
    var myactivity = UIActivityIndicatorView()
    
    var old:CGFloat = 0
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        /*
         小于70，展示下拉刷新：松开上滑
         大于70，展开松开刷新：松开上滑到70，刷新并且更新数据，上滑到0
         */
        //print("--")
        //print(self.UITableView_Main.contentInset.top)
        //print(-self.UITableView_Main.contentOffset.y)//现在的位置
        let heightToNavagateBarBottom = -self.myTableView.contentOffset.y - 64
        let space = heightToNavagateBarBottom - old
        UIView.animate(withDuration: 0, animations: {
            self.myactivity.center.y += space
            self.myWord.center.y += space
        })
        //print(space)
        let myViewAlpha = (heightToNavagateBarBottom)/80
        //print(myViewAlpha)
        myview.alpha = 1 - myViewAlpha
        if -self.myTableView.contentOffset.y - self.myTableView.contentInset.top <= 80{
            myview.backgroundColor = UIColor.lightGray
            UIView.animate(withDuration: 0, animations: {
                self.myview.frame =  CGRect(x:0,y:64,width:UIScreen.main.bounds.width,height:heightToNavagateBarBottom)
            })
        }
        else{//到90的时候就会触发，这个时候开始
            myWord.text = "松手刷新"
            myview.backgroundColor = UIColor.lightGray
            UIView.animate(withDuration: 0, animations: {
                self.myview.frame =  CGRect(x:0,y:64,width:UIScreen.main.bounds.width,height:heightToNavagateBarBottom)
            })
            if space > 0  {
                willReloadData = true
            }
            //UITableView_M.isScrollEnabled = true
        }
        old = heightToNavagateBarBottom
        if !myactivity.isAnimating {
            myactivity.startAnimating()
        }
    }
    
    var willReloadData = false
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if willReloadData == true {
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
        myWord.text = "下拉刷新"
        myactivity.stopAnimating()
        print("scrollViewDidEndDecelerating")
    }
    //MARK: - Navigatebar??
    
    @IBAction func LeftAction(_ sender: UIBarButtonItem) {
        let user_id = Defalts_ReadWrite().ReadDefalts_String(KEY: "user_id")
        if  user_id != "" || user_id == nil{
            let vc = UIStoryboard(name: "First", bundle: nil).instantiateViewController(withIdentifier: "SendNewMessiageViewController")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func RightAction(_ sender: UIBarButtonItem) {
        let user_id = Defalts_ReadWrite().ReadDefalts_String(KEY: "user_id")
        if  user_id != "" || user_id == nil{
            self.tabBarController?.tabBar.isHidden = true
            let vc = UIStoryboard(name: "T", bundle: nil).instantiateViewController(withIdentifier: "SomeOne_ViewController")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    //MARK: - Views
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        myTableView.delegate = self
        self.myTableView.tableFooterView = UIView(frame:CGRect.zero)
        
        self.view.addSubview(imagewhite)
        self.imagewhite.image = #imageLiteral(resourceName: "White")
        self.imagewhite.layer.cornerRadius = 2
        self.imagewhite.clipsToBounds = true
        self.imagewhite.isHidden = true
        
        myview.frame =  CGRect(x:0,y:64,width:UIScreen.main.bounds.width,height:0)
        myview.backgroundColor = UIColor.blue
        self.view.addSubview(myview)
        
        myWord.frame = CGRect(x:0,y:30,width:UIScreen.main.bounds.width,height:20)
        myWord.text = "下拉刷新"
        myWord.font = UIFont(name:"GillSans", size:16)
        myWord.textColor = UIColor.darkGray
        myWord.textAlignment = .center
        self.view.addSubview(myWord)
        
        myactivity.frame = CGRect(x:UIScreen.main.bounds.width / 2 - 8,y:14,width:16,height:16)
        myactivity.color = UIColor.darkGray
        myactivity.isHidden = false
        self.view.addSubview(myactivity)
        
        
        // Do any additional setup after loading the view.
        ConnectNib()
    }
    
    var parameters = Parameters()
    override func viewWillAppear(_ animated: Bool) {
        print("---------------willappear--")
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.navigationBar.tintColor = UIColor.white
        tabBarController?.tabBar.isHidden = false
        self.myTableView.isHidden = false
        
        
        self.NewsIDs = MyCoreData().ReadNewsIDsAll()
        self.NewsTimes = MyCoreData().ReadNewsTimesAll()
        let aaaaaaaa = Paixu().Diclike(ID: self.NewsIDs, Date: self.NewsTimes)
        self.NewsIDs = aaaaaaaa.0
        self.NewsTimes = aaaaaaaa.1
        if let a = Defalts_ReadWrite().ReadDefalts_String(KEY: "user_id") {
            if a == "" {
                //UITableView_Main.reloadData()
                alertController_GotoLogin()
            } else {
                //userid不是空
                let whereifrom = Defalts_ReadWrite().ReadDefalts_String(KEY: "whereifrom")!
                print(whereifrom)
                if whereifrom == "SendNewMessiageViewController" || whereifrom == "Login_ViewController" {
                    parameters = ["userid": a]
                    print(parameters)
                    GetDataWithHUD(parameters: parameters)
                }
            }
        }
        else{
            //UITableView_Main.reloadData()
            alertController_GotoLogin()
        }
    }
    
    private func GetDataWithHUD(parameters:Parameters) -> () {
        //MyCoreData().DeleteAll(entityName: "News")
        print("GetDataWithHUD")
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)//前后颜色
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.native)//菊花
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.show()
        Alamofire.request(GotServers().GotServerAliScripts() + "GIVE_BACK_INFORMATION.php", method: .post, parameters: parameters)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    let json = JSON(response.result.value!)
                    print(json)
                    for i in 0..<json.count
                    {
                        let new_i = json.count - 1 - i
                        //    0     1      2       3          4          5        6         7
                        // detail device newsid newstime photohumber senderid sendername height
                        
                        //(senderId:Int,height:Float,detail:String,device:String,
                        //image1:String?,image2:String?,image3:String?,image4:String?,image5:String?,
                        //image6:String?,image7:String?,image8:String?,image9:String?,imageNumber:Int,
                        //senderName:String,sendTime:String,saved:Bool)
                        let id = json[new_i]["newsid"].string!
                        let detail = json[new_i]["detail"].string!
                        let height = WorksHieghts().WorkWordsHeightForInformation(Words: detail)
                        let device = json[new_i]["device"].string!
                        
                        let imageNumber = Int(json[new_i]["photonumer"].string!)!
                        let senderName = json[new_i]["sendername"].string!
                        let senderId = json[new_i]["senderid"].string!
                        let sendTime = json[new_i]["newstime"].string!
                        let saved = false
                        
                        let NumberOfPhotos = Int(json[new_i]["photonumer"].string!)!
                        var ArryOfNameOfPhotos = ""
                        for j in 0..<NumberOfPhotos
                        {
                            if j == 0{
                                ArryOfNameOfPhotos = json[new_i ]["photo"][j].string!
                            }
                            else{
                                ArryOfNameOfPhotos += "&"
                                ArryOfNameOfPhotos += json[new_i ]["photo"][j].string!
                            }
                        }
                        MyCoreData().AddData_News_Reall(id:Int(id)!,senderId: Int(senderId)!, height: Float(height), detail: detail, device: device, image1: ArryOfNameOfPhotos, image2: nil, image3: nil, image4: nil, image5: nil, image6: nil, image7: nil, image8: nil, image9: nil, imageNumber: imageNumber, senderName: senderName, sendTime: sendTime, saved: saved)
                        if id == "1"{
                            print("wwwwwwwwwwwwwwwwwwww")
                            print(detail)
                            print(self.Userid_Read_SenderDetail(id: 1))
                            print(self.Userid_Read_SenderHeight(id: 1))
                        }
                    }
                    //读取 COREDATA 更新 NewsIDS NewsTimes
                    self.NewsIDs = MyCoreData().ReadNewsIDsAll()
                    self.NewsTimes = MyCoreData().ReadNewsTimesAll()
                    
                    print("9090909090909")
                    print(MyCoreData().CheckNumber(entityName: "News"))
                    print(MyCoreData().CheckDataall_News())
                    
                    let aaaaaaaa = Paixu().Diclike(ID: self.NewsIDs, Date: self.NewsTimes)
                    self.NewsIDs = aaaaaaaa.0
                    self.NewsTimes = aaaaaaaa.1
                    
                    self.myTableView.reloadData()
                    SVProgressHUD.dismiss()
                case .failure(let error):
                    print(error)
                    SVProgressHUD.dismiss()
                }
        }
        
    }

    override func viewDidAppear(_ animated: Bool) {
        print("did---------------")
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
    
    override func viewWillDisappear(_ animated: Bool) {
        Defalts_ReadWrite().Settssssss_h(DATA: "FirstViewViewController_", FORKEY: "whereifrom")
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
        
        var indexPath = IndexPath()
        indexPath = self.myTableView.indexPath(for: sender.superview?.superview as! UITableViewCell)!
        let a = GotPhoto(A: Userid_Read_ImageNumber(id: NewsIDs[indexPath.section]), indexpath: indexPath)//获取图片组 和图片数目
        let vc = UIStoryboard(name: "First", bundle: nil).instantiateViewController(withIdentifier: "ViewPhotoWithScroll_ViewController") as!  ViewPhotoWithScroll_ViewController
        vc.imagelist = a.0
        vc.imgaeNumber = a.1
        print("================++=")
        print(sender.tag)
        print(a.0.count)
        print(a.1)
        vc.image_Dijizhang = sender.tag
        print(sender.tag - 1)
        let imageviewzooooom_ = UIImageView(image:(a.0)[sender.tag - 1])
        let imagekuangaobi = imageviewzooooom_.frame.height / imageviewzooooom_.frame.width //获取宽高比
        //let w  = (UIScreen.main.bounds.width - 20 - 6) / 3
        //imageviewzooooom.frame = CGRect(x:UIScreen.main.bounds.width,y:UIScreen.main.bounds.height,width:w,height:w)
        
        imageviewzooooom_.image = #imageLiteral(resourceName: "Black")
        imageviewzooooom_.frame = CGRect(x:0,y:0,width:UIScreen.main.bounds.width,height:UIScreen.main.bounds.height)
        imageviewzooooom_.alpha = 0
        self.view.addSubview(imageviewzooooom_)
        
        imageviewzooooom.layer.cornerRadius = 2
        self.view.addSubview(imageviewzooooom)
        imageviewzooooom.image = (a.0)[sender.tag - 1]
        
        
        
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


   //MARK: - TableView
    @IBOutlet weak var myTableView: UITableView!
    /** TableViewcell 高度*/
    var TableViewCellHeight:CGFloat = 200
    /**设备宽度*/
    var DeviceWidth =  UIScreen.main.bounds.width
    var NewsIDs = [Int]()
    var NewsTimes = [String]()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            var aa = indexPath
            aa.row += 1
            let a = GotPhoto(A: Userid_Read_ImageNumber(id: NewsIDs[indexPath.section]), indexpath: aa)
            let vc = UIStoryboard(name: "First", bundle: nil).instantiateViewController(withIdentifier: "MessiageDetail_TableViewController") as!  MessiageDetail_TableViewController
            UserDefaults.standard.synchronize()
            print("----+------+-------")
            print(a.0.count)
            vc.imagelist = a.0
            vc.imgaeNumber = a.1
            
            let aaaaaaaaaaa = myTableView.cellForRow(at: indexPath)! as! News_Information_TableViewCell
            vc.imageicon = (aaaaaaaaaaa.userIcon.imageView?.image)!
            vc.label1 = aaaaaaaaaaa.UILabelUserName.text!
            vc.label2 = aaaaaaaaaaa.UILabelInformation.text!
            vc.label3 = aaaaaaaaaaa.UILabelDetail.text!
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if NewsIDs.isEmpty{
        //if MyCoreData().CheckNumber(entityName: "News") == 0 {
            print("0")
            let cell = tableView.dequeueReusableCell(withIdentifier: "Advertisement_TableViewCell", for: indexPath) as! Advertisement_TableViewCell
            cell.imgae_main.setBackgroundImage(#imageLiteral(resourceName: "White"), for: .normal)
            TableViewCellHeight = UIScreen.main.bounds.height
            return cell
        } else {
            let flag = indexPath.section
            switch indexPath.row {
            case 0://文字区
                let cell = tableView.dequeueReusableCell(withIdentifier: "News_Information_TableViewCell", for: indexPath) as! News_Information_TableViewCell
                print(NewsIDs)
                print(flag)
                print(indexPath.section)
                Alamofire.request(GotServers().GotImageIconServer(ai: true) + Userid_Read_Senderid(id: NewsIDs[flag]) + ".png")
                    .responseData { response in
                        if let data = response.result.value {
                            let asd = UIImage(data: data)
                            cell.userIcon.setImage(asd, for: UIControlState.normal)
                        }
                }
                cell.userIcon.addTarget(self, action: #selector(GoSomeOne), for: UIControlEvents.touchUpInside)
                cell.userIcon.addTarget(self, action: #selector(IconClock_Double ), for: UIControlEvents.touchDownRepeat)
                cell.setting.setBackgroundImage(#imageLiteral(resourceName: "White"), for: .normal)
                cell.UIImageViewV_.image = #imageLiteral(resourceName: "v")
                cell.UIImageViewVip_.image = #imageLiteral(resourceName: "alipay")
                cell.setting.setImage(#imageLiteral(resourceName: "setting"), for: .normal)
                cell.setting.isHidden = true
                cell.setting.addTarget(self, action: #selector(Setting), for: UIControlEvents.touchUpInside)
                //  0       1      2       3        4           5         6
                // detail device newsid newstime photohumber senderid sendername
                cell.UILabelDetail.text = Userid_Read_SenderDetail(id: NewsIDs[flag])
                cell.UILabelUserName.text = Userid_Read_SenderName(id: NewsIDs[flag])
                
                let time = Userid_Read_SenderTime(id: NewsIDs[flag])
                let device = Userid_Read_SenderDevice(id: NewsIDs[flag])//长度12 1234 12 34 12 34
                

                if time.characters.count > 0 {
                    let year = time.substring(to: time.index(time.startIndex, offsetBy: 4))
                    let month = FFFFFunctions().getsubtring(string: time, space_start: 4, space_end: 6)
                    let day = FFFFFunctions().getsubtring(string: time, space_start: 6, space_end: 8)
                    let hour = FFFFFunctions().getsubtring(string: time, space_start: 8, space_end: 10)
                    let minute = time.substring(from: time.index(time.startIndex, offsetBy: 10))
                    //
                    cell.UILabelInformation.text  =  year + "年" + month + "日" + day + "日 " + hour + ":" + minute + " 来自" + device
                } else {
                    cell.UILabelInformation.text = time + device
                }
                

                TableViewCellHeight = Userid_Read_SenderHeight(id: NewsIDs[flag])
                
                return cell
            case 1://图片区
                switch Userid_Read_ImageNumber(id: NewsIDs[flag]) {
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "Advertisement_TableViewCell", for: indexPath) as! Advertisement_TableViewCell
                    self.TableViewCellHeight = 0
                    return cell
                case 1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "OnePhoto_H_NTableViewCell", for: indexPath) as! OnePhoto_H_NTableViewCell
                    /*
                    DispatchQueue.global().async {
                       // print("task" + "\(Thread.current)")
                        if let imageFromCaches = ImagePath().GetImageFromCachesPaths(imagename: self.Userid_Read_ImageName(id: self.NewsIDs[flag])) {
                            cell.image_1.setImage(imageFromCaches, for: .normal)
                            print("------------path")
                        } else {
                            Alamofire.request(GotServers().GotImageTServer(ai: true) + self.Userid_Read_ImageName(id: self.NewsIDs[flag]) + ".jpeg")
                                .responseData { response in
                                    if let data = response.result.value {
                                        let asd = UIImage(data: data)
                                        cell.image_1.setImage(asd, for: UIControlState.normal)
                                        ImagePath().WriteImageToCachesPaths_In_PNG(image: asd!, imagename: self.Userid_Read_ImageName(id: self.NewsIDs[flag]))
                                        print("--------alamo")
                                    }
                            }
                        }
                    }*/
                    let urlstring = GotServers().GotImageTServer(ai: true) + self.Userid_Read_ImageName(id: self.NewsIDs[flag]) + ".jpeg"
                    //v.sd_setImage(with: NSURL(string:urlstring)! as URL!, placeholderImage: #imageLiteral(resourceName: "White"), options: .progressiveDownload)
                    //v.sd_setImage(with: NSURL(string:urlstring)! as URL!, placeholderImage: #imageLiteral(resourceName: "White"))
                    cell.image1.sd_setImage(with: NSURL(string:urlstring)! as URL!, placeholderImage: #imageLiteral(resourceName: "White"), options: .progressiveDownload)
                    
                    cell.image_1.addTarget(self, action: #selector(GoDetail), for: UIControlEvents.touchUpInside)
                    
                    self.TableViewCellHeight = WorksHieghts().WorkWordsHeightForPhotots(photoNumber: 1)
                    return cell
                case 2,3:
                    let imageNames = Userid_Read_ImageName(id: NewsIDs[flag]).components(separatedBy: "&")
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ThreePhoto_NTableViewCell", for: indexPath) as! ThreePhoto_NTableViewCell
                    
                    let urlstring1 = GotServers().GotImageTServer(ai: true) + imageNames[0] + ".jpeg"
                    cell.image1.sd_setImage(with: NSURL(string:urlstring1)! as URL!, placeholderImage: #imageLiteral(resourceName: "White"), options: .progressiveDownload)
                    cell.image_1.addTarget(self, action: #selector(GoDetail), for: UIControlEvents.touchUpInside)
                    
                    let urlstring2 = GotServers().GotImageTServer(ai: true) + imageNames[1] + ".jpeg"
                    cell.image2.sd_setImage(with: NSURL(string:urlstring2)! as URL!, placeholderImage: #imageLiteral(resourceName: "White"), options: .progressiveDownload)
                    cell.image_2.addTarget(self, action: #selector(GoDetail), for: UIControlEvents.touchUpInside)
                    
                    if imageNames.count == 3 {
                        let urlstring3 = GotServers().GotImageTServer(ai: true) + imageNames[2] + ".jpeg"
                        cell.image3.sd_setImage(with: NSURL(string:urlstring3)! as URL!, placeholderImage: #imageLiteral(resourceName: "White"), options: .progressiveDownload)
                        cell.image_3.addTarget(self, action: #selector(GoDetail), for: UIControlEvents.touchUpInside)
                    }
                    
                    TableViewCellHeight = WorksHieghts().WorkWordsHeightForPhotots(photoNumber: 3)
                    return cell
                case 4,5,6:
                    let imageNames = Userid_Read_ImageName(id: NewsIDs[flag]).components(separatedBy: "&")
                    let cell = tableView.dequeueReusableCell(withIdentifier: "SixPhoto_TableViewCell", for: indexPath) as! SixPhoto_TableViewCell
                    let urlstring1 = GotServers().GotImageTServer(ai: true) + imageNames[0] + ".jpeg"
                    cell.image1.sd_setImage(with: NSURL(string:urlstring1)! as URL!, placeholderImage: #imageLiteral(resourceName: "White"), options: .progressiveDownload)
                    cell.image_1.addTarget(self, action: #selector(GoDetail), for: UIControlEvents.touchUpInside)
                    
                    let urlstring2 = GotServers().GotImageTServer(ai: true) + imageNames[1] + ".jpeg"
                    cell.image2.sd_setImage(with: NSURL(string:urlstring2)! as URL!, placeholderImage: #imageLiteral(resourceName: "White"), options: .progressiveDownload)
                    cell.image_2.addTarget(self, action: #selector(GoDetail), for: UIControlEvents.touchUpInside)
                    
                    let urlstring3 = GotServers().GotImageTServer(ai: true) + imageNames[2] + ".jpeg"
                    cell.image3.sd_setImage(with: NSURL(string:urlstring3)! as URL!, placeholderImage: #imageLiteral(resourceName: "White"), options: .progressiveDownload)
                    cell.image_3.addTarget(self, action: #selector(GoDetail), for: UIControlEvents.touchUpInside)
                    
                    let urlstring4 = GotServers().GotImageTServer(ai: true) + imageNames[3] + ".jpeg"
                    cell.image4.sd_setImage(with: NSURL(string:urlstring4)! as URL!, placeholderImage: #imageLiteral(resourceName: "White"), options: .progressiveDownload)
                    cell.image_4.addTarget(self, action: #selector(GoDetail), for: UIControlEvents.touchUpInside)
                    
                    if imageNames.count == 5  || imageNames.count == 6{
                        let urlstring5 = GotServers().GotImageTServer(ai: true) + imageNames[4] + ".jpeg"
                        cell.image5.sd_setImage(with: NSURL(string:urlstring5)! as URL!, placeholderImage: #imageLiteral(resourceName: "White"), options: .progressiveDownload)
                        cell.image_5.addTarget(self, action: #selector(GoDetail), for: UIControlEvents.touchUpInside)
                    }
                    
                    if imageNames.count == 6 {
                        let urlstring6 = GotServers().GotImageTServer(ai: true) + imageNames[5] + ".jpeg"
                        cell.image6.sd_setImage(with: NSURL(string:urlstring6)! as URL!, placeholderImage: #imageLiteral(resourceName: "White"), options: .progressiveDownload)
                        cell.image_6.addTarget(self, action: #selector(GoDetail), for: UIControlEvents.touchUpInside)
                    }

                    TableViewCellHeight = WorksHieghts().WorkWordsHeightForPhotots(photoNumber: 4)
                    return cell
                case 7,8,9:
                    let imageNames = Userid_Read_ImageName(id: NewsIDs[flag]).components(separatedBy: "&")
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
                    
                    for i in 0..<imageNames.count
                    {
                        Alamofire.request(GotServers().GotImageMainServer(ai: true) + "Zhu000" + String(i + 70) + ".jpg")
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
                    TableViewCellHeight = DeviceWidth
                    return cell
                    
                default:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "OnePhoto_Z_NTableViewCell", for: indexPath) as! OnePhoto_Z_NTableViewCell
                    return cell
                }
                
            case 2://三按钮区
                let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsPraiseDemote_NTableViewCell", for: indexPath) as! CommentsPraiseDemote_NTableViewCell
                cell.number = [110,112,119]
                cell.UIButton1.addTarget(self, action: #selector(self.Funczhuan), for: UIControlEvents.touchUpInside)
                cell.UIButton2.addTarget(self, action: #selector(self.Pinglun), for: UIControlEvents.touchUpInside)
                cell.UIButton3.addTarget(self, action: #selector(self.Zan), for: UIControlEvents.touchUpInside)
                cell.UpDateUI()
                TableViewCellHeight = 40
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "Advertisement_TableViewCell", for: indexPath) as! Advertisement_TableViewCell
                TableViewCellHeight = 0
                return cell
            }
        }
    }
    func Funczhuan() -> () {
        print("Funczhuan")
    }
    func Pinglun() ->() {
        print("Pinglun")
        let vc = UIStoryboard(name: "First", bundle: nil).instantiateViewController(withIdentifier: "Pinglun_ViewController") as!  Pinglun_ViewController
        self.present(vc, animated: true, completion: nil)
    }
    func Zan () -> () {
        print("Zan")
    }
    

    func GoSomeOne() -> () {
        print("GoSomeOne")
    }
    func IconClock_Double() -> () {
        print("IconClock_Double")
    }
    
    func Setting () -> () {
        print("Setting")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableViewCellHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if NewsIDs.isEmpty {
            return 1
        }
        return NewsIDs.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
        
    }
    
    
    
    //MAEK: - Functions
    func ConnectNib() {
        myTableView.register(UINib(nibName: "OnePhoto_H_NTableViewCell", bundle: nil), forCellReuseIdentifier: "OnePhoto_H_NTableViewCell")
        myTableView.register(UINib(nibName: "ThreePhoto_NTableViewCell", bundle: nil), forCellReuseIdentifier: "ThreePhoto_NTableViewCell")
        myTableView.register(UINib(nibName: "SixPhoto_TableViewCell", bundle: nil), forCellReuseIdentifier: "SixPhoto_TableViewCell")
        myTableView.register(UINib(nibName: "NinePhoto_TableViewCell", bundle: nil), forCellReuseIdentifier: "NinePhoto_TableViewCell")
        
        myTableView.register(UINib(nibName: "Advertisement_TableViewCell", bundle: nil), forCellReuseIdentifier: "Advertisement_TableViewCell")
        myTableView.register(UINib(nibName: "CommentsPraiseDemote_NTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentsPraiseDemote_NTableViewCell")
        myTableView.register(UINib(nibName: "News_Information_TableViewCell", bundle: nil), forCellReuseIdentifier: "News_Information_TableViewCell")
    }
    
    private func alertController_GotoLogin() -> () {
        let alertController = UIAlertController(title: "系统提示",
                                                message: "您需要登录",
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: {
            action in
            self.myTableView.isHidden = true
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
    
    private func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    private func Userid_Read_Senderid(id:Int) -> String {
        var senderid = String()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            //print("numbers of \(searchResults.count)")
            for p in (searchResults as! [NSManagedObject]){
                if (p.value(forKey: "id") as! Int) == id {
                    senderid =  "\(p.value(forKey: "senderId")!)"
                    print("senderid:\(p.value(forKey: "senderId")!)")
                }
            }
        } catch  {
            print(error)
        }
        return senderid
    }
    
    private func Userid_Read_SenderName(id:Int) -> String {
        var senderName = String()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            //print("numbers of \(searchResults.count)")
            for p in (searchResults as! [NSManagedObject]){
                if (p.value(forKey: "id") as! Int) == id {
                    senderName = "\(p.value(forKey: "senderName")!)"
                    print("sendername:\(p.value(forKey: "senderName")!)")
                }
            }
        } catch  {
            print(error)
        }
        return senderName
    }
    
    private func Userid_Read_SenderTime(id:Int) -> String {
        var sendTime = String()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            //print("numbers of \(searchResults.count)")
            for p in (searchResults as! [NSManagedObject]){
                if (p.value(forKey: "id") as! Int) == id {
                    sendTime = "\(p.value(forKey: "sendTime")!)"
                    print("sendtime:\(p.value(forKey: "sendTime")!)")
                }
            }
        } catch  {
            print(error)
        }
        return sendTime
    }
    
    private func Userid_Read_SenderDevice(id:Int) -> String {
        var device = String()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            //print("numbers of \(searchResults.count)")
            for p in (searchResults as! [NSManagedObject]){
                if (p.value(forKey: "id") as! Int) == id {
                    device = "\(p.value(forKey: "device")!)"
                    print("decice:\(p.value(forKey: "device")!)")
                }
            }
        } catch  {
            print(error)
        }
        return device
    }
    
    private func Userid_Read_SenderDetail(id:Int) -> String {
        var detail = String()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            //print("numbers of \(searchResults.count)")
            for p in (searchResults as! [NSManagedObject]){
                if (p.value(forKey: "id") as! Int) == id {
                    detail = "\(p.value(forKey: "detail")!)"
                    print("detail:\(p.value(forKey: "detail")!)")
                }
            }
        } catch  {
            print(error)
        }
        return detail
    }
    
    private func Userid_Read_SenderHeight(id:Int) -> CGFloat {
        var height = Float()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            //print("numbers of \(searchResults.count)")
            for p in (searchResults as! [NSManagedObject]){
                if (p.value(forKey: "id") as! Int) == id {
                    height = Float("\(p.value(forKey: "height")!)")!
                    print(height)
                }
            }
        } catch  {
            print(error)
        }
        return CGFloat(height)
    }
    
    private func Userid_Read_ImageNumber(id:Int) -> Int {
        var imageNumber = Int()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            //print("numbers of \(searchResults.count)")
            for p in (searchResults as! [NSManagedObject]){
                if (p.value(forKey: "id") as! Int) == id {
                    imageNumber = Int("\(p.value(forKey: "imageNumber")!)")!
                    print(imageNumber)
                }
            }
        } catch  {
            print(error)
        }
        return imageNumber
    }
    
    private func Userid_Read_ImageName(id:Int) -> String {
        var ImageName = String()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            //print("numbers of \(searchResults.count)")
            for p in (searchResults as! [NSManagedObject]){
                if (p.value(forKey: "id") as! Int) == id {
                    ImageName = "\(p.value(forKey: "image1")!)"
                    print(ImageName)
                }
            }
        } catch  {
            print(error)
        }
        return ImageName
    }
    
    
    private func GotPhoto(A:Int,indexpath:IndexPath) -> ([UIImage?],Int) {
        var imagelist = [UIImage?]()
        var imagenumber_in = Int()
        let a_  = A
        
        switch a_ {
        case 1 :
            let a = myTableView.cellForRow(at: indexpath)! as! OnePhoto_H_NTableViewCell
            imagelist.append(a.image1.image)
            imagenumber_in = 1
            break
        case 2,3:
            let a = myTableView.cellForRow(at: indexpath)! as! ThreePhoto_NTableViewCell
            imagelist.append(a.image1.image)
            imagelist.append(a.image2.image)
            imagenumber_in = 2
            if a_ == 3 {
                imagelist.append(a.image3.image)
                imagenumber_in = 3
            }
            
        case 4,5,6 :
            let a = myTableView.cellForRow(at: indexpath)! as! SixPhoto_TableViewCell
            imagelist.append(a.image1.image)
            imagelist.append(a.image2.image)
            imagelist.append(a.image3.image)
            imagelist.append(a.image4.image)
            imagenumber_in = 4
            if a_ == 5 {
                imagenumber_in = 5
                imagelist.append(a.image5.image)
            }
            if a_ == 6 {
                imagenumber_in = 6
                imagelist.append(a.image5.image)
                imagelist.append(a.image6.image)
            }
        case 7,8,9:
            let a = myTableView.cellForRow(at: indexpath)! as! NinePhoto_TableViewCell
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
