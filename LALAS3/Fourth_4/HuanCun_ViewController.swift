//
//  HuanCun_ViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/18.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class HuanCun_ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myTableView.delegate = self
        myTableView.dataSource = self
        
        ConnectNib()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Defalts_ReadWrite().Settssssss_h(DATA: "HuanCun_ViewController", FORKEY: "whereifrom")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableView
    @IBOutlet weak var myTableView: UITableView!
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch indexPath.row {
        case 0:
            MyCoreData().DeleteAll(entityName: "News")
            MyCoreData().CheckNumber(entityName: "News")
        default:
            MyCoreData().AddData_News_Reall(senderId: 1, height: 1, detail: "1", device: "1", image1: "1", image2: "1", image3: "1", image4: "1", image5: "1", image6: "1", image7: "1", image8: "1", image9: "1", senderName: "1", sendTime: "1", saved: true)
            MyCoreData().CheckNumber(entityName: "News")
            
            MyCoreData().AddData_News_Reall(senderId: 1, height: 1, detail: "1", device: "1", image1: "1", image2: "1", image3: "1", image4: "1", image5: "1", image6: "1", image7: "1", image8: "1", image9: "1", senderName: "1", sendTime: "1", saved: false)
            MyCoreData().CheckNumber(entityName: "News")
            MyCoreData().ReadAData_News(senderId: 1)
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OnlyOneLabel_TableViewCell", for: indexPath) as! OnlyOneLabel_TableViewCell
        switch indexPath.row {
        case 0:
            cell.UILabel_M.text = "清空 News 数据"
        case 1:
            cell.UILabel_M.text = "测试1"
        default:
            cell.UILabel_M.text = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //MARK: - Functions
    func ConnectNib() {
        myTableView.register(UINib(nibName: "OnlyOneLabel_TableViewCell", bundle: nil), forCellReuseIdentifier: "OnlyOneLabel_TableViewCell")
    }
    
}
