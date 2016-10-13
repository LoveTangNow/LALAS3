//
//  SomePeople_ViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/10/12.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class SomePeople_ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var tableViewMain: UITableView!
    
    @IBOutlet weak var Item1: UIBarButtonItem!
    @IBOutlet weak var Item2: UIBarButtonItem!
    @IBOutlet weak var Item3: UIBarButtonItem!
    
    @IBAction func ACTION1(_ sender: UIBarButtonItem) {
    }
    @IBAction func ACTION2(_ sender: UIBarButtonItem) {
    }
    @IBAction func ACTION3(_ sender: UIBarButtonItem) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewMain.delegate = self
        tableViewMain.dataSource = self
        
        navigationController?.navigationBar.barTintColor = UIColor.cyan
        navigationController?.navigationBar.tintColor = UIColor.purple
    
        ConnectNib()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Tableview
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width / 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThreePhoto_NTableViewCell", for: indexPath) as! ThreePhoto_NTableViewCell
        
        cell.image_1.setImage(#imageLiteral(resourceName: "Black"), for: .normal)
        cell.image_2.setImage(#imageLiteral(resourceName: "Black"), for: .normal)
        cell.image_3.setImage(#imageLiteral(resourceName: "Black"), for: .normal)
        //图片是显示有问题 但是不影响 以后有了正常的大图就可以啦！~~~~
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 44
    }
    
    
    //MARK: - Founctions
    func ConnectNib() {
        tableViewMain.register(UINib(nibName: "OnePhoto_H_NTableViewCell", bundle: nil), forCellReuseIdentifier: "OnePhoto_H_NTableViewCell")
        tableViewMain.register(UINib(nibName: "ThreePhoto_NTableViewCell", bundle: nil), forCellReuseIdentifier: "ThreePhoto_NTableViewCell")
        tableViewMain.register(UINib(nibName: "SixPhoto_TableViewCell", bundle: nil), forCellReuseIdentifier: "SixPhoto_TableViewCell")
        tableViewMain.register(UINib(nibName: "NinePhoto_TableViewCell", bundle: nil), forCellReuseIdentifier: "NinePhoto_TableViewCell")
        tableViewMain.register(UINib(nibName: "OnePhoto_Z_NTableViewCell", bundle: nil), forCellReuseIdentifier: "OnePhoto_Z_NTableViewCell")
        
        tableViewMain.register(UINib(nibName: "Advertisement_TableViewCell", bundle: nil), forCellReuseIdentifier: "Advertisement_TableViewCell")
        tableViewMain.register(UINib(nibName: "CommentsPraiseDemote_NTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentsPraiseDemote_NTableViewCell")
        tableViewMain.register(UINib(nibName: "News_Information_TableViewCell", bundle: nil), forCellReuseIdentifier: "News_Information_TableViewCell")
    }
}
