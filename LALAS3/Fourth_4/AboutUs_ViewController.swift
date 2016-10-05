//
//  AboutUs_ViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/18.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class AboutUs_ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    //MARK: - 绑定 和 变量
     var Imageload_Black:UIImage = UIImage(named: "Black.png")!
    
    @IBOutlet weak var UIImageView_M: UIImageView!
    @IBOutlet weak var UITableView_M: UITableView!

    
    @IBOutlet weak var UILabel_1: UILabel!
    @IBOutlet weak var UILabel_2: UILabel!
    
    var list = ["给我们打分","官方网站","加入我们"]
    
    
    //MARK: - functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITableView_M.delegate = self
        UITableView_M.dataSource = self
        
        
        UIImageView_M.layer.cornerRadius = 10
        UIImageView_M.clipsToBounds = true

        UIImageView_M.image = Imageload_Black
        
        UILabel_1.text = "11111111111111"
        UILabel_2.text = "222222222222222222222"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Tableview
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OnlyOneLabel_TableViewCell", for: indexPath as IndexPath) as! OnlyOneLabel_TableViewCell
        cell.UILabel_M.text = list[indexPath.row]
        //cell.textLabel?.text = "lala"
        return cell
    }

}
