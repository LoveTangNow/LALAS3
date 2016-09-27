//
//  ThirdViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/14.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

//  *********发现页面**********
//  *********其实就是个推荐页面页面**********

import UIKit

class ThirdViewController: UIViewController , UITableViewDataSource , UITableViewDelegate{
    
    //MARK: - 变量和 绑定
    var Imageload_Black:UIImage = UIImage(named: "Black.png")!
    var Imageload_Wight:UIImage = UIImage(named: "White.png")!
    
    @IBOutlet weak var UITextField_S: UITextField!
    @IBOutlet weak var UITableView_M: UITableView!
    
    var TableViewHeight:CGFloat = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "发现"
        
        UITableView_M.dataSource = self
        UITableView_M.delegate = self
        
        UITextField_S.placeholder = "搜索 用户 动态"
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: - FUNCTIONS
    @IBAction func Search_begain_(_ sender: AnyObject) {
        print("in")
    }
    
    @IBAction func Search_End(_ sender: AnyObject) {
        print("out")
    }
    @IBAction func Search_Click(_ sender: AnyObject) {
        /*
         判断输入文字的类型
            默认 还是自己输入的
         然后 完成不同的查询 跳转
         */
        
        var Words:String = ""
        if UITextField_S.text! == "" {
            Words = UITextField_S.placeholder!
        } else {
            Words = UITextField_S.text!
        }
        
        //SearchResults_ViewController
        let vc = UIStoryboard(name: "Third", bundle: nil).instantiateViewController(withIdentifier: "SearchResults_ViewController") as! SearchResults_ViewController
        vc.words = Words
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    

    
    //MARK: - Tableview
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UITextField_S.resignFirstResponder()
        print(indexPath.row)
        //keyboardWillDisappear()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OnePhotoTwoLabel_TableViewCell", for: indexPath) as! OnePhotoTwoLabel_TableViewCell
        cell.UIImageView_Main.image = Imageload_Black
        cell.UILabel_Title.text = "阿西吧！！！"
        cell.UILabel_Detail.text = "大红色的发挥的双方哈里斯的客服哈里斯的卡号发来看技术的发挥拉克丝活动福利卡就会少打了客服号"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableViewHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    

}
