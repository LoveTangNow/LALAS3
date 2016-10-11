//
//  SearchResults_ViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/16.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SearchResults_ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , UICollectionViewDelegate , UICollectionViewDataSource{
    
    //MARK: - bangding
    var Imageload_Black:UIImage = UIImage(named: "Black.png")!
    var Imageload_Wight:UIImage = UIImage(named: "White.png")!
    
    var words = String()
    
    
    @IBOutlet weak var UICollectionView_M: UICollectionView!
    @IBOutlet weak var UITableView_M: UITableView!
    
    //MARK: - FUNCTIONS

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //|||???
        self.UICollectionView_M.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.title = "推荐"
        
        UITableView_M.delegate = self
        UITableView_M.dataSource = self
        
        UICollectionView_M.delegate = self
        UICollectionView_M.dataSource = self
        
        print(words)
        ///來來來 我們來準備數據了！！
        ConnectNib()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - TableView
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OnePhotoTwoLableTableViewCell", for: indexPath) as! OnePhotoTwoLableTableViewCell
        
        if indexPath.row % 2 == 0 {
            cell.UIImageView_M.image = Imageload_Black
        } else {
            cell.UIImageView_M.image = Imageload_Wight
        }
        
        cell.UILabel_m.text = "那你知道个鸡儿"
        cell.UILabel_MAX.text = "是大家爱看啥房间爱死了大家看法克里斯多夫哈市的合法"

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //MARK: - CollectionView
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnePhotoOneLable_CollectionViewCell", for: indexPath) as! OnePhotoOneLable_CollectionViewCell
        
        //??
        cell.UIImageView_M.layer.cornerRadius = 50
        cell.UIImageView_M.clipsToBounds = true
        
        if indexPath.row % 2 == 0 {
            cell.UIImageView_M.image = Imageload_Wight
        } else {
            cell.UIImageView_M.image = Imageload_Black
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if  indexPath.row % 2 == 1{
            return CGSize(width: 50, height: 50)
        }
        else{
            return CGSize(width: 50, height: 50)
        }
    }
    
    private func ConnectNib () {
        UITableView_M.register(UINib(nibName: "OnePhotoTwoLableTableViewCell", bundle: nil), forCellReuseIdentifier: "OnePhotoTwoLableTableViewCell")
        UITableView_M.register(UINib(nibName: "OnePhotoTwoLableTableViewCell", bundle: nil), forCellReuseIdentifier: "OnePhotoTwoLableTableViewCell")
    }
   

}
