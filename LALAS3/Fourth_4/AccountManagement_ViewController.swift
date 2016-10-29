//
//  AccountManagement_ViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/9/26.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit
import Alamofire

enum Enum_Models {
    case Normal_Model
    case Brithday_Model
    case Jianjie_Model
    case w
}

class AccountManagement_ViewController: UIViewController ,UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDataSource,UITableViewDelegate{
    
    //MARK: - 变量

    var piker_b = [0,0]
    
    let width_d  = UIScreen.main.bounds.width
    let height_d = UIScreen.main.bounds.height
    var TableviewHeight:CGFloat = 0
     var NowModel = Enum_Models.Normal_Model
    
    var list = [["用户昵称 和 头像","性别","所在地","生日","用户简介"],
                ["工作信息"],
                ["教育信息","小学","初中","高中","大学"],
                ["绑定","邮箱","手机","QQ","微博","微信","支付宝"],
                ["其他","等级","积分","注册时间"]]

    var list_ = ["用户昵称 和 头像":true,"性别":"","所在地":"","生日":"","用户简介":"",
                 "工作信息":"",
                 "教育信息":"","小学":"","初中":"","高中":"","大学":"",
                 "绑定":"","邮箱":"","手机":"","QQ":"","微博":"","微信":"","支付宝":"",
                 "其他":"","等级":0,"积分":0,"注册时间":""] as [String : Any]
    
    //账号管理：昵称0、性别1、所在地（省2、市3、区4）、生日5、简介6、工作信息7、教育信息（小学8、初中9、\\高中0、大学1、硕士2、博士3、博士后4）、(qq5、手机6、邮箱7、微博8、微信9、支付宝0、)、等级1、积分2、注册时间3

    
    //MARK: - 绑定
    @IBOutlet weak var UIImageView_Cover: UIImageView!
    @IBOutlet weak var UITableView_m: UITableView!
    
    @IBOutlet var UIPickerView_M: UIPickerView!
    
    //日期选择器
    @IBOutlet var UIDatePicker_M: UIDatePicker!
    @IBAction func UIdatepiker_chaged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"//"yyyy年MM月dd日 HH:mm:ss"  //日期样式
        list_["生日"] = formatter.string(from: sender.date)
        
        let formatter_Int = DateFormatter()
        formatter_Int.dateFormat = "yyyyMMdd"
        let aaaa =  Int(formatter_Int.string(from: sender.date))!
        
        let year = aaaa / 10000
        let month = (aaaa / 100) % 100
        let day = aaaa % 100
        
        print(year)
        print(month)
        print(day)
        
        Defalts_ReadWrite().Settssssss_h(DATA: year, FORKEY: "birthday_year")
        Defalts_ReadWrite().Settssssss_h(DATA: month, FORKEY: "birthday_month")
        Defalts_ReadWrite().Settssssss_h(DATA: day, FORKEY: "birthday_day")
        UserDefaults.standard.synchronize()
        self.UITableView_m.reloadData()
    }
    
    //个人简介
    @IBOutlet var UIView_Text: UIView!
    @IBOutlet weak var UITextView_t: UITextView!
    @IBOutlet weak var UIButton_cancel: UIButton!
    @IBAction func UIButton_Cancel_T(_ sender: AnyObject) {
        UITextView_t.resignFirstResponder()
        UIView.animate(withDuration: 0.3, animations: {
            self.UIView_Text.center.y += 200
            self.UIImageView_Cover.alpha = 0
            }, completion: {_ in
                self.NowModel = Enum_Models.Normal_Model
                self.UITableView_m.isScrollEnabled = true
        })
    }
    @IBOutlet weak var UIButton_yes: UIButton!
    @IBAction func UIButton_YES_T(_ sender: AnyObject) {
        UITextView_t.resignFirstResponder()
        self.list_["用户简介"] = UITextView_t.text
        Defalts_ReadWrite().Settssssss_h(DATA: UITextView_t.text, FORKEY: "introduction")
        self.UITableView_m.reloadData()
        UIView.animate(withDuration: 0.3, animations: {
            self.UIView_Text.center.y += 200
            self.UIImageView_Cover.alpha = 0
            }, completion: {_ in
                self.NowModel = Enum_Models.Normal_Model
                self.UITableView_m.isScrollEnabled = true
        })

    }
    
    /////////>>
    private func handalint (number:Int) -> String {
        switch number {
        case 0,1,2,3,4,5,6,7,8,9:
            return "0" + String(number)
        default:
            return String(number)
        }
    }
    
    //MARK: - VIEW
    override func viewDidLoad() {
        super.viewDidLoad()
        //[["用户昵称 和 头像","性别","所在地","生日","用户简介"],["工作信息"], ["教育信息","小学","初中","高中","大学","硕士","博士","博士后"], ["邮箱","手机","QQ","微博","微信","支付宝"],["等级","积分","注册时间"]]
        //从 plist 中同步数据过来
        
        list_["性别"] = Defalts_ReadWrite().ReadDefalts_Bool(KEY: "sex")!
        list_["所在地"] = String(describing: Defalts_ReadWrite().ReadDefalts_String(KEY: "province")!) + " " + String(describing: Defalts_ReadWrite().ReadDefalts_String(KEY: "municipality")!) + " " + String(describing: Defalts_ReadWrite().ReadDefalts_String(KEY: "county")!)
        
        list_["生日"] = handalint(number: Defalts_ReadWrite().ReadDefalts_Int(KEY: "birthday_year")!) + "年" + handalint(number: Defalts_ReadWrite().ReadDefalts_Int(KEY: "birthday_month")!) + "月" + handalint(number: Defalts_ReadWrite().ReadDefalts_Int(KEY: "birthday_day")!) + "日"
        list_["用户简介"] = Defalts_ReadWrite().ReadDefalts_String(KEY: "introduction")!
        
        list_["工作信息"] = Defalts_ReadWrite().ReadDefalts_String(KEY: "work")!
        
        list_["小学"] = Defalts_ReadWrite().ReadDefalts_String(KEY: "primary")!
        list_["初中"] = Defalts_ReadWrite().ReadDefalts_String(KEY: "middle")!
        list_["高中"] = Defalts_ReadWrite().ReadDefalts_String(KEY: "j_middle")!
        list_["大学"] = Defalts_ReadWrite().ReadDefalts_String(KEY: "university")!
        
        list_["邮箱"] = Defalts_ReadWrite().ReadDefalts_String(KEY: "email")!
        list_["手机"] = Defalts_ReadWrite().ReadDefalts_String(KEY: "phone")!
        list_["QQ"] = Defalts_ReadWrite().ReadDefalts_String(KEY: "qq")!
        list_["微博"] = Defalts_ReadWrite().ReadDefalts_String(KEY: "weibo")!
        list_["微信"] = Defalts_ReadWrite().ReadDefalts_String(KEY: "wechat")!
        list_["支付宝"] = Defalts_ReadWrite().ReadDefalts_String(KEY: "alipay")!
        
        list_["等级"] = Defalts_ReadWrite().ReadDefalts_Int(KEY: "level")!
        list_["积分"] = Defalts_ReadWrite().ReadDefalts_Int(KEY: "score")!
        
        list_["注册时间"] = handalint(number: Defalts_ReadWrite().ReadDefalts_Int(KEY: "register_year")!) + "年" + handalint(number: Defalts_ReadWrite().ReadDefalts_Int(KEY: "register_month")!) + "月" + handalint(number: Defalts_ReadWrite().ReadDefalts_Int(KEY: "register_day")!) + "日"
        
        print(list_)

        UIImageView_Cover.alpha = 0
        UIImageView_Cover.image = #imageLiteral(resourceName: "Black")
        
        UITableView_m.dataSource = self
        UITableView_m.delegate = self
        
        //print(self.view.frame.height)
        //print(UIScreen.main.bounds.height)
        //print(self.UITableView_m.frame.height)
        UIPickerView_M.frame = CGRect(x:0,y:height_d,width:width_d,height:130)
        UIPickerView_M.delegate = self
        UIPickerView_M.dataSource = self
        UIPickerView_M.backgroundColor = UIColor.red
        self.view.addSubview(UIPickerView_M)

        
        UIDatePicker_M.frame = CGRect(x:0,y:height_d,width:width_d,height:250)
        UIDatePicker_M.locale = NSLocale(localeIdentifier: "zh_CN") as Locale
        UIDatePicker_M.datePickerMode = UIDatePickerMode.date
        UIDatePicker_M.alpha = 1
        UIDatePicker_M.backgroundColor = UIColor.white
        self.view.addSubview(UIDatePicker_M)
        
        
        UIView_Text.frame = CGRect(x:0,y:height_d,width:width_d,height:200)
        self.view.addSubview(UIView_Text)
        self.UIButton_cancel.layer.cornerRadius = 2
        self.UIButton_yes.layer.cornerRadius = 2
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        // Do any additional setup after loading the view.
        //NotificationCenter.default.add
        ConnectNib()
    }
    
    func keyBoardWillShow(note:NSNotification)
    {
        let userInfo:NSDictionary = note.userInfo! as NSDictionary;
        let keyBoardInfo: AnyObject? = userInfo.object(forKey: UIKeyboardFrameBeginUserInfoKey) as AnyObject?;
        let beginY = keyBoardInfo?.cgRectValue.origin.y;
        let keyBoardInfo2: AnyObject? = userInfo.object(forKey: UIKeyboardFrameEndUserInfoKey) as AnyObject?;
        let endY = keyBoardInfo2?.cgRectValue.origin.y;
        //let aTime = userInfo.object(forKey: UIKeyboardAnimationDurationUserInfoKey) as! TimeInterval
        //5
        let deltaY = beginY! - endY!
        //print(beginY)
        //print(endY)
        print(deltaY)
        //print(aTime)//0.25
        print("show")
        UIView.animate(withDuration: 0, animations: {
            self.UIView_Text.center.y -= deltaY
        })
    }
    
    func keyBoardWillHide(note:NSNotification) {
        let userInfo:NSDictionary = note.userInfo! as NSDictionary;
        let keyBoardInfo: AnyObject? = userInfo.object(forKey: UIKeyboardFrameBeginUserInfoKey) as AnyObject?;
        let beginY = keyBoardInfo?.cgRectValue.origin.y;
        let keyBoardInfo2: AnyObject? = userInfo.object(forKey: UIKeyboardFrameEndUserInfoKey) as AnyObject?;
        let endY = keyBoardInfo2?.cgRectValue.origin.y;
        let deltaY = beginY! - endY!
        UIView.animate(withDuration: 0, animations: {
            self.UIView_Text.center.y -= deltaY
        })
        print("hide")
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        /*UIView.animate(withDuration: 3, animations: {
         self.UIPickerView_MMM.center.y += 50
         self.UIPickerView_MMM.frame =  CGRect(x:100,y:100,width:150,height:150)
         })*/
        
        /**
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, animations: {
            self.UIView_Text.center.y -= 200
            }, completion: {_ in
        })
         */
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Defalts_ReadWrite().Settssssss_h(DATA: "AccountManagement_ViewController", FORKEY: "whereifrom")
        uploadDataBack()
    }
    
    //传回数据
    private func uploadDataBack()  {
        
    }
    
    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.NowModel {
        case Enum_Models.Normal_Model:
            //正常情况
            switch indexPath.section {
            case 0://主要信息
                if indexPath.row == 0 {//头像行动作
                }
                //性别行不需要动作 2
                if indexPath.row == 3 {//所在地行动作
                    //
                }
                if indexPath.row == 3 {//生日行动作
                    UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.5, initialSpringVelocity: 5, animations: {
                        self.UIDatePicker_M.center.y -= 250
                        self.UIImageView_Cover.alpha = 0.5
                        }, completion: {_ in
                            self.UITableView_m.isScrollEnabled = false
                            self.NowModel = Enum_Models.Brithday_Model
                    })
                    
                }
                if indexPath.row == 4 {//简介行动作
                    UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.5, initialSpringVelocity: 5, animations: {
                        self.UITextView_t.text = self.list_["用户简介"] as! String!
                        self.UIView_Text.center.y -= 200
                        self.UIImageView_Cover.alpha = 0.5
                        }, completion: {_ in
                            self.UITableView_m.isScrollEnabled = false
                            self.NowModel = Enum_Models.Jianjie_Model
                    })
                }
            case 1://工作信息
                break
            case 2://教育
                
                let alertController = UIAlertController(title: "教育信息",message: "请输入就读学校名称", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addTextField {
                    (textField: UITextField!) -> Void in
                    textField.placeholder = "学校"
                }
                
                let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                let okAction = UIAlertAction(title: "确定", style: .default,handler: {action in
                    //也可以用下标的形式获取textField let login = alertController.textFields![0]
                    //let login = alertController.textFields!.first! as UITextField
                    self.UITableView_m.reloadData()
                    //print(self.list_[indexPath.section])
                    //let password = alertController.textFields!.last! as UITextField
                    //print("用户名：\(login.text) 密码：\(password.text)")
                    print(self.list_)
                })
                alertController.addAction(cancelAction)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            case 3://绑定 6
                
                break
            case 4://其它 3
                
                break
            default:
                break
            }
        case Enum_Models.Brithday_Model:
            //从生日状态返回
            //数据变化由动作监控
            self.UITableView_m.reloadData()
            UIView.animate(withDuration: 0.3, animations: {
                self.UIDatePicker_M.center.y += 250
                self.UIImageView_Cover.alpha = 0
                self.UIDatePicker_M.alpha = 0.5
                }, completion: {_ in
                    self.NowModel = Enum_Models.Normal_Model
                    self.UITableView_m.isScrollEnabled = true
                    self.UIDatePicker_M.alpha = 1
            })
        case Enum_Models.Jianjie_Model:
            UITextView_t.resignFirstResponder()
            //数据变化
            self.list_["用户简介"] = UITextView_t.text
            self.UITableView_m.reloadData()
            UIView.animate(withDuration: 0.3, animations: {
                self.UIView_Text.center.y += 200
                self.UIImageView_Cover.alpha = 0
                self.UIView_Text.alpha = 0.5
                }, completion: {_ in
                    self.NowModel = Enum_Models.Normal_Model
                    self.UITableView_m.isScrollEnabled = true
                    self.UIView_Text.alpha = 1
            })
        default:
            break
        }
        
        /**插入到固定一行的方法是
        var a  = IndexPath()
        a.section = 0
        a.row = 0
        tableView.insertRows(at: [a], with: UITableViewRowAnimation.automatic)
        
        */
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            switch list[indexPath.section][indexPath.row] {//["用户昵称 和 头像","性别","所在地","生日","用户简介"]
            case "用户昵称 和 头像"://头像 昵称
                let cell = tableView.dequeueReusableCell(withIdentifier: "Label_And_RightBigImage_TableViewCell", for: indexPath) as! Label_And_RightBigImage_TableViewCell
                cell.UILabel_.text = "啦啦同学"
                Alamofire.request(GotServers().GotImageIconServer(ai: true) + "1.png")
                    .responseData { response in
                        if let data = response.result.value {
                            cell.UIImageView_.image = UIImage(data: data)
                        }
                }
                
                TableviewHeight = 100
                
                return cell
            case "性别":
                let cell = tableView.dequeueReusableCell(withIdentifier: "Select_TableViewCell", for: indexPath) as! Select_TableViewCell
                
                cell.UILabel_M.text = list[indexPath.section][indexPath.row]
                cell.UISegmentedControl_M.setTitle("男", forSegmentAt: 1)
                cell.UISegmentedControl_M.setTitle("女", forSegmentAt: 0)
                
                
                if let a  = Defalts_ReadWrite().ReadDefalts_Bool(KEY: "sex")
                {
                    if a {//ture 是男
                        cell.UISegmentedControl_M.selectedSegmentIndex = 1
                    } else {
                        cell.UISegmentedControl_M.selectedSegmentIndex = 0
                    }
                }
                
                TableviewHeight = 45
                return cell
            case "用户简介"://简介
                let cell = tableView.dequeueReusableCell(withIdentifier: "TwoLabel_TableViewCell", for: indexPath) as! TwoLabel_TableViewCell
                cell.UILabel_l.text = "简介"
                cell.UILabel_r.text = list_["用户简介"] as! String?
                
                TableviewHeight = 100
                
                return cell
            case "生日"://生日
                let cell = tableView.dequeueReusableCell(withIdentifier: "TwoLabel_TableViewCell", for: indexPath) as! TwoLabel_TableViewCell
                cell.UILabel_l.text = "生日"
                cell.UILabel_r.text = list_["生日"] as! String?
                TableviewHeight = 45
                return cell
            default://所在地
                let cell = tableView.dequeueReusableCell(withIdentifier: "TwoLabel_TableViewCell", for: indexPath) as! TwoLabel_TableViewCell
                cell.UILabel_l.text = "所在地"
                cell.UILabel_r.text = list_["所在地"] as! String?
                TableviewHeight = 45
                return cell
            }
            
        case 1://工作信息
            let cell = tableView.dequeueReusableCell(withIdentifier: "TwoLabel_TableViewCell", for: indexPath) as! TwoLabel_TableViewCell
            cell.UILabel_l.text = list[indexPath.section][indexPath.row]
            cell.UILabel_r.text = list_["工作信息"] as! String?
            TableviewHeight = 45
            return cell
            
        case 2://教育
            switch indexPath.row {
            case 1,2,3,4:
                let cell = tableView.dequeueReusableCell(withIdentifier: "TwoLabel_TableViewCell", for: indexPath) as! TwoLabel_TableViewCell
                cell.UILabel_l.text = list[indexPath.section][indexPath.row]
                switch indexPath.row {
                case 1:
                    cell.UILabel_r.text = list_["小学"] as! String?
                case 2:
                    cell.UILabel_r.text = list_["初中"] as! String?
                case 3:
                    cell.UILabel_r.text = list_["高中"] as! String?
                default:
                    cell.UILabel_r.text = list_["大学"] as! String?
                }
                TableviewHeight = 45
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "OnlyOneLabel_TableViewCell", for: indexPath) as! OnlyOneLabel_TableViewCell
                cell.UILabel_M.text = list[indexPath.section][indexPath.row]
                TableviewHeight = 45
                return cell
            }

        case 3://绑定
            switch indexPath.row {
            case 1,2,3,4,5,6:
                let cell = tableView.dequeueReusableCell(withIdentifier: "TwoLabel_TableViewCell", for: indexPath) as! TwoLabel_TableViewCell
                cell.UILabel_l.text = list[indexPath.section][indexPath.row]
                //"绑定":"","邮箱":"","手机":"","QQ":"","微博":"","微信":"","支付宝":"",
                switch indexPath.row {
                case 1:
                    cell.UILabel_r.text = list_["邮箱"] as! String?
                case 2:
                    cell.UILabel_r.text = list_["手机"] as! String?
                case 3:
                    cell.UILabel_r.text = list_["QQ"] as! String?
                case 4:
                    cell.UILabel_r.text = list_["微博"] as! String?
                case 5:
                    cell.UILabel_r.text = list_["微信"] as! String?
                default:
                    cell.UILabel_r.text = list_["支付宝"] as! String?
                }
                TableviewHeight = 45
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "OnlyOneLabel_TableViewCell", for: indexPath) as! OnlyOneLabel_TableViewCell
                cell.UILabel_M.text = list[indexPath.section][indexPath.row]
                TableviewHeight = 45
                return cell
            }
        default://其他
            switch indexPath.row {
            case 1,2,3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "TwoLabel_TableViewCell", for: indexPath) as! TwoLabel_TableViewCell
                cell.UILabel_l.text = list[indexPath.section][indexPath.row]
                //"其他":"","等级":0,"积分":0,"注册时间":""
                switch indexPath.row {
                case 1:
                    let a  =  list_["等级"] as? Int
                    cell.UILabel_r.text = String(describing: a)
                case 2:
                    let a  =  list_["积分"] as? Int
                    cell.UILabel_r.text = String(describing: a)
                default:
                    cell.UILabel_r.text = list_["注册时间"] as! String!
                }
                TableviewHeight = 45
                return cell
            default:
                //AccountManagement_OneLabel_TableViewCell
                let cell = tableView.dequeueReusableCell(withIdentifier: "OnlyOneLabel_TableViewCell", for: indexPath) as! OnlyOneLabel_TableViewCell
                cell.UILabel_M.text = list[indexPath.section][indexPath.row]
                TableviewHeight = 45
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableviewHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0,1,2,3:
            return 15
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return list.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return list[0].count
        case 1:
            return list[1].count
        case 2:
            return list[2].count
        case 3:
            return list[3].count
        default:
            return list[4].count
        }
    }
    
    //MARK: - pickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        //print("numberOfComponents")
        return dddddd.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //print("numberOfRowsInComponent")
        return dddddd[component].count
    }
    
    var dddddd = [["赵","钱","孙"],["李","周","刘","张"]]
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //print("titleForRow")
        return  dddddd[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

    }
    
    //MARK: - OTHERS
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func ConnectNib () {
        UITableView_m.register(UINib(nibName: "Label_And_RightBigImage_TableViewCell", bundle: nil), forCellReuseIdentifier: "Label_And_RightBigImage_TableViewCell")
        UITableView_m.register(UINib(nibName: "Select_TableViewCell", bundle: nil), forCellReuseIdentifier: "Select_TableViewCell")
        UITableView_m.register(UINib(nibName: "Label_And_TextView_TableViewCell", bundle: nil), forCellReuseIdentifier: "Label_And_TextView_TableViewCell")
        UITableView_m.register(UINib(nibName: "OnlyOneLabel_TableViewCell", bundle: nil), forCellReuseIdentifier: "OnlyOneLabel_TableViewCell")
        UITableView_m.register(UINib(nibName: "TwoLabel_TableViewCell", bundle: nil), forCellReuseIdentifier: "TwoLabel_TableViewCell")
         UITableView_m.register(UINib(nibName: "LeftSamllImageAndLabel_TableViewCell", bundle: nil), forCellReuseIdentifier: "LeftSamllImageAndLabel_TableViewCell")
    }
}
