//
//  FourthViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/14.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    //MARK: - 绑定
    @IBOutlet weak var UITableView_M: UITableView!
    
    //MARK: - 变量
    var  list  = ["我的微博","我的图片","我的赞","其他","设置"]
    var TableViewHeight:CGFloat = 0
    var myview = UIView()
    
    var TableViewHeights = [[Int]]()
    
    
    //MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "我的"
        self.UITableView_M.delegate = self
        self.UITableView_M.dataSource = self
        UITableView_M.backgroundColor = UIColor.white
        
        self.navigationController?.navigationBar.barTintColor = UIColor.red
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        myview.frame =  CGRect(x:0,y:0,width:UIScreen.main.bounds.width,height:70)
        myview.backgroundColor = UIColor.blue
        self.view.addSubview(myview)
        //self.UITableView_M.addSubview(myview)
        
        ConnectNib()
        
        //UserDefaults.standard.set("noSetle", forKey: "isSet")
        
        let a = UserDefaults.standard.value(forKey: "isSet") as? String
        if a == "noSetle" {
            //没有设置过
            UserDefaults.standard.set("Setle", forKey: "isSet")
            UserDefaults.standard.synchronize()
            
            /**
             账号管理：昵称、性别、所在地（省、市、区）、生日、简介、工作信息、教育信息（小学、初中、高中、大学、硕士、博士、博士后）、(qq、手机、邮箱、微博、微信、支付宝、)、等级、积分、注册时间
             账号安全：昵称、id、手机、邮箱、证件信息、
             通用设置：
             通知设置：
             */
            
            //登录注册时已经设置过的有:昵称，id，手机/邮箱
            //我们需要设置其他的一下东西

            //SetUserDefaults(DATA:"",FORKEY:"NiCheng")
            //SetUserDefaults(DATA:"",FORKEY:"ID")
            
            SetUserDefaultsM(DATA:"",FORKEY: "Phone")
            SetUserDefaultsM(DATA:"",FORKEY: "Email")
            SetUserDefaultsM(DATA:"男",FORKEY: "Sex")
            SetUserDefaultsM(DATA:"北京",FORKEY: "Location")
            SetUserDefaultsM(DATA:"",FORKEY: "Brithday")
            SetUserDefaultsM(DATA:"",FORKEY: "Summary")
            SetUserDefaultsM(DATA:"",FORKEY: "Work")
            SetUserDefaultsM(DATA:"",FORKEY: "XX")
            SetUserDefaultsM(DATA:"",FORKEY: "CZ")
            SetUserDefaultsM(DATA:"",FORKEY: "GZ")
            SetUserDefaultsM(DATA:"",FORKEY: "DZ")
            SetUserDefaultsM(DATA:"",FORKEY: "SS")
            SetUserDefaultsM(DATA:"",FORKEY: "BS")
            SetUserDefaultsM(DATA:"",FORKEY: "BSH")
            SetUserDefaultsM(DATA:"",FORKEY: "QQ")
            SetUserDefaultsM(DATA:"",FORKEY: "WB")
            SetUserDefaultsM(DATA:"",FORKEY: "WX")
            SetUserDefaultsM(DATA:"",FORKEY: "ZFB")
            SetUserDefaultsM(DATA:"",FORKEY: "DJ")
            SetUserDefaultsM(DATA:"",FORKEY: "JF")
            SetUserDefaultsM(DATA:"",FORKEY: "ZCSJ")
            SetUserDefaultsM(DATA:"",FORKEY: "ZJ")
            
        }
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0, animations: {
            self.myview.center.y -= 6
        })
    }
    
    var old:CGFloat = 64
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        /*
         小于70，展示下拉刷新：松开上滑
         大于70，展开松开刷新：松开上滑到70，刷新并且更新数据，上滑到0
         */
        print("--")
        print(self.UITableView_M.contentInset.top)
        print(-self.UITableView_M.contentOffset.y)//现在的位置
        let a  = -self.UITableView_M.contentOffset.y - old//移动间距
        print(a)
        if -self.UITableView_M.contentOffset.y - self.UITableView_M.contentInset.top <= 70{
            old = -self.UITableView_M.contentOffset.y
            myview.backgroundColor = UIColor.blue
            UIView.animate(withDuration: 0, animations: {
                self.myview.center.y += a
            })
        }
        else{//到70的时候就会触发，这个时候开始
            //UITableView_M.isScrollEnabled = false
            old = -self.UITableView_M.contentOffset.y
            myview.backgroundColor = UIColor.white
            UIView.animate(withDuration: 0, animations: {
                self.myview.center.y += a
            })
            //UITableView_M.isScrollEnabled = true
        }
        
    }
        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Setting_Click(_ sender: AnyObject) {
        let vc = UIStoryboard(name: "Fourth", bundle: nil).instantiateViewController(withIdentifier: "Setting_TableViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func Login_Click(_ sender: AnyObject) {
        let sb = UIStoryboard(name: "Main", bundle:nil)
        let vc = sb.instantiateViewController(withIdentifier: "Login_ViewController") as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    func ME_GO() {
        let vc = UIStoryboard(name: "T", bundle: nil).instantiateViewController(withIdentifier: "TViewController")
        self.navigationController?.pushViewController(vc, animated: true)
        print("go")
    }
    
    //MARK: - TableView
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 4{
            let a = tableView.cellForRow(at: indexPath)! as! LeftSamllImageAndLabel_TableViewCell
            switch a.UILabel_m.text! {
            case list[indexPath.row]:
                let vc = UIStoryboard(name: "Fourth", bundle: nil).instantiateViewController(withIdentifier: "Setting_TableViewController")
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                break
            }
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ME_TableViewCell", for: indexPath) as! ME_TableViewCell
                
                cell.UIButton_Main.setBackgroundImage(#imageLiteral(resourceName: "White"), for: .normal)
                cell.UIButton_Small.setBackgroundImage(#imageLiteral(resourceName: "White"), for: .normal)
                cell.UIButton_Main.addTarget(self, action: #selector(ME_GO), for: UIControlEvents.touchUpInside)
                
                
                cell.UIButton_Main.setTitle("", for: .normal)
                cell.UIButton_Small.setTitle("", for: .normal)
                
                TableViewHeights[indexPath.section][indexPath.row] = 100
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ThreeWhat_TableViewCell", for: indexPath) as! ThreeWhat_TableViewCell
                TableViewHeights[indexPath.section][indexPath.row] = 70
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LeftSamllImageAndLabel_TableViewCell", for: indexPath) as! LeftSamllImageAndLabel_TableViewCell
            switch indexPath.row {
            case 0://我的微博
                cell.UIImageView_m.image = #imageLiteral(resourceName: "weibo")
            case 1://我的图片
                cell.UIImageView_m.image = #imageLiteral(resourceName: "picture")
            case 2://我的赞
                cell.UIImageView_m.image = #imageLiteral(resourceName: "appreciate_fill_black")
            case 3://其他
                cell.UIImageView_m.image = #imageLiteral(resourceName: "list")
            case 4://设置
                cell.UIImageView_m.image = #imageLiteral(resourceName: "setting")
            default:
                cell.UIImageView_m.image =  #imageLiteral(resourceName: "White")
            }
            
            cell.UILabel_m.text = list[indexPath.row]
            TableViewHeights[indexPath.section][indexPath.row] = 45
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if indexPath.section == 0 {
            return .none
        } else {
            return .delete
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        UITableView_M.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            UITableView_M.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 15
        } else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let a  = 2
        for _  in 0..<a {
            TableViewHeights.append([0])
        }
        return a
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            let a  = 2
            for _  in 0..<a {
                TableViewHeights[0].append(0)
            }
            return a
        }
        else{
            let a  = list.count
            for _  in 0..<a {
                TableViewHeights[1].append(0)
            }
            return a
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CGFloat(TableViewHeights[indexPath.section][indexPath.row])
        
    }
    
    
    //MARK: - FUNCS
    
    func SetUserDefaults(DATA:String,FORKEY:String) {
        UserDefaults.standard.set(DATA,forKey:FORKEY)
        UserDefaults.standard.synchronize()
    }
    
    func SetUserDefaultsM(DATA:String,FORKEY:String) {
        //先判断这个属性有没有设置过 
        //设置过了 什么也不干 
        //没有设置过 NIL 那就设置默认值

        if  UserDefaults.standard.value(forKey: FORKEY) == nil {
            UserDefaults.standard.set(DATA,forKey:FORKEY)
            UserDefaults.standard.synchronize()
        }
        
    }
    
    func ConnectNib ()  {
        UITableView_M.register(UINib(nibName: "ThreeWhat_TableViewCell", bundle: nil), forCellReuseIdentifier: "ThreeWhat_TableViewCell")
        UITableView_M.register(UINib(nibName: "LeftSamllImageAndLabel_TableViewCell", bundle: nil), forCellReuseIdentifier: "LeftSamllImageAndLabel_TableViewCell")
        UITableView_M.register(UINib(nibName: "ME_TableViewCell", bundle: nil), forCellReuseIdentifier: "ME_TableViewCell")
    }
    
}
