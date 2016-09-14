//
//  FirstViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/14.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class FirstViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    //MARK: - 绑定 和 变量

    @IBOutlet weak var UITableView_Main: UITableView!
    
    //肌肤默认的图片
    var Imageload_Black:UIImage = UIImage(named: "Black.png")!
    var Imageload_Wight:UIImage = UIImage(named: "White.png")!
    var ImageloadBackGroud:UIImage = UIImage(named: "FirstBackGround.png")!
    var ImageloadBackGroudn:UIImage = UIImage(named: "BackGround.png")!
    
    //MARK: - 函数
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "动态"
        
        UITableView_Main.dataSource = self
        UITableView_Main.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - TableView
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Words_TableViewCell", for: indexPath) as! Words_TableViewCell
            
            cell.UIImageView_UserIcon.image = Imageload_Black
            cell.UIImageView_Setting.image = Imageload_Black
            
            cell.UILabel_UserName.text = "ThomasLiu"
            cell.UILabel_TimeAndDevice.text = "lalallalal"
            cell.UILabel_Detail.text = "wocao"
            
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
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
       print(Foundations().prints(A: "a"))
    }*/

}
