//
//  FourthViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/14.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

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
        UITableView_M.tableFooterView = UIView(frame:CGRect.zero)
        
        
        self.navigationController?.navigationBar.barTintColor = UIColor.red
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        myview.frame =  CGRect(x:0,y:0,width:UIScreen.main.bounds.width,height:70)
        myview.backgroundColor = UIColor.blue
        self.view.addSubview(myview)
        //self.UITableView_M.addSubview(myview)
        
        ConnectNib()
        
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
        if indexPath.section == 1 && indexPath.row == 3 {
            let vc = UIStoryboard(name: "T", bundle: nil).instantiateViewController(withIdentifier: "Health_ViewController") as! Health_ViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ME_TableViewCell", for: indexPath) as! ME_TableViewCell
                
                cell.UIButton_Small.setBackgroundImage(#imageLiteral(resourceName: "Black"), for: .normal)
                cell.UIButton_Main.addTarget(self, action: #selector(ME_GO), for: UIControlEvents.touchUpInside)
                
                
                if let user_id  = Defalts_ReadWrite().ReadDefalts_String(KEY: "user_id"){
                    Alamofire.request(GotServers().GotImageIconServer(ai: true) + user_id + ".png")
                        .responseData { response in
                            if let data = response.result.value {
                                cell.UIButton_Main.setBackgroundImage(UIImage(data: data), for: .normal)
                            }
                    }
                } else {
                    cell.UIButton_Main.setBackgroundImage(#imageLiteral(resourceName: "White"), for: .normal)
                }
                
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
    

    
    func ConnectNib ()  {
        UITableView_M.register(UINib(nibName: "ThreeWhat_TableViewCell", bundle: nil), forCellReuseIdentifier: "ThreeWhat_TableViewCell")
        UITableView_M.register(UINib(nibName: "LeftSamllImageAndLabel_TableViewCell", bundle: nil), forCellReuseIdentifier: "LeftSamllImageAndLabel_TableViewCell")
        UITableView_M.register(UINib(nibName: "ME_TableViewCell", bundle: nil), forCellReuseIdentifier: "ME_TableViewCell")
    }
    
}
