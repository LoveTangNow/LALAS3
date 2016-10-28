//
//  SomeOne_ViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/10/24.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SomeOne_ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView_my.delegate = self
        tableView_my.dataSource = self
        ConnectNib()
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Tableview
    @IBOutlet weak var tableView_my: UITableView!
    var user_id = String()
    var tableview_cell_heights = Dictionary<Int,[CGFloat]>()//heights
    var DataWords = Dictionary<Int,[String]>()//NewsID,SenderID,SenderName,SendTime,SendDevice,Detail
    var DataPhotoNames = Dictionary<Int,[String]>()//photos

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            user_id = "1"
            let cell = tableView.dequeueReusableCell(withIdentifier: "Advertisement_TableViewCell", for: indexPath) as! Advertisement_TableViewCell
            Alamofire.request(GotServers().GotImageIconServer(ai: true) + user_id + ".png")
                .responseData { response in
                    if let data = response.result.value {
                        let asd = UIImage(data: data)
                        cell.imgae_main.setImage(asd, for: .normal)
                    }
            }
            return cell
        } else {
            switch indexPath.row {
            case 1://words
                let cell = tableView.dequeueReusableCell(withIdentifier: "News_Information_TableViewCell", for: indexPath) as! News_Information_TableViewCell
                return cell
            case 2://photos
                let cell = tableView.dequeueReusableCell(withIdentifier: "NinePhoto_TableViewCell", for: indexPath) as! NinePhoto_TableViewCell
                return cell
            default://threewhat
                let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsPraiseDemote_NTableViewCell", for: indexPath) as! CommentsPraiseDemote_NTableViewCell
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UIScreen.main.bounds.width * 0.618
        } else {
            if let a  = tableview_cell_heights[indexPath.section - 1]?[indexPath.row] {
                return a
            }
            else{
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 20
    }
    //MARK: - ToolBar
    
    @IBOutlet weak var leftItem: UIBarButtonItem!
    @IBOutlet weak var midItem: UIBarButtonItem!
    @IBOutlet weak var rightItem: UIBarButtonItem!
    
    /**add friend*/
    @IBAction func leftItem_c(_ sender: UIBarButtonItem) {
        print("left")
    }
    /***/
    @IBAction func midItem_c(_ sender: UIBarButtonItem) {
        print("mid")
    }
    /***/
    @IBAction func rightItem_c(_ sender: UIBarButtonItem) {
        print("right")
    }
    
    //MARK: - Funtions
    func GotDataFromServer() -> () {
        var parameters = Parameters()
        if let userid = Defalts_ReadWrite().ReadDefalts_String(KEY: "user_id"){
            parameters = ["userid": userid]
            Alamofire.request(GotServers().GotServerAliScripts() + "GIVE_BACK_INFORMATION_SOMEONE.php", method: .post, parameters: parameters)
                .validate()
                .responseJSON { response in
                switch response.result {
                case .success:
                    let json = JSON(response.result.value!)
                    for i in 0..<json.count
                    {
                        let new_i = json.count - 1 - i
                        //    0     1      2       3          4          5        6
                        // detail device newsid newstime photohumber senderid sendername
                        let aDataCollecion = [json[new_i]["detail"].string!,json[new_i]["device"].string!,json[new_i]["newsid"].string!,json[new_i]["newstime"].string!,json[new_i]["photonumer"].string!,json[new_i]["senderid"].string!,json[new_i]["sendername"].string!]
                        self.DataWords[self.DataWords.count] = aDataCollecion
                            
                        let NumberOfPhotos = Int(json[new_i]["photonumer"].string!)!
                        var ArryOfNameOfPhotos = [String]()
                        for j in 0..<NumberOfPhotos
                        {
                            let a = json[new_i ]["photo"][j].string!
                            ArryOfNameOfPhotos.append(a)
                        }
                        self.DataPhotoNames[self.DataPhotoNames.count] = ArryOfNameOfPhotos
                            
                        var aHeightsCollection = [CGFloat]()
                        //WordsHeight
                        aHeightsCollection.append(WorksHieghts().WorkWordsHeightForInformation(Words: json[new_i]["detail"].string!))
                        //PhotoHeight
                        aHeightsCollection.append(WorksHieghts().WorkWordsHeightForPhotots(photoNumber: NumberOfPhotos))
                        //ThreeHeight
                        aHeightsCollection.append(40)
                            
                        self.tableview_cell_heights[self.tableview_cell_heights.count] = aHeightsCollection
                    }
                    self.tableView_my.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
       
    func ConnectNib() {
        tableView_my.register(UINib(nibName: "OnePhoto_H_NTableViewCell", bundle: nil), forCellReuseIdentifier: "OnePhoto_H_NTableViewCell")
        tableView_my.register(UINib(nibName: "ThreePhoto_NTableViewCell", bundle: nil), forCellReuseIdentifier: "ThreePhoto_NTableViewCell")
        tableView_my.register(UINib(nibName: "SixPhoto_TableViewCell", bundle: nil), forCellReuseIdentifier: "SixPhoto_TableViewCell")
        tableView_my.register(UINib(nibName: "NinePhoto_TableViewCell", bundle: nil), forCellReuseIdentifier: "NinePhoto_TableViewCell")
        //tableView_my.register(UINib(nibName: "OnePhoto_Z_NTableViewCell", bundle: nil), forCellReuseIdentifier: "OnePhoto_Z_NTableViewCell")
        
        tableView_my.register(UINib(nibName: "Advertisement_TableViewCell", bundle: nil), forCellReuseIdentifier: "Advertisement_TableViewCell")
        tableView_my.register(UINib(nibName: "CommentsPraiseDemote_NTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentsPraiseDemote_NTableViewCell")
        tableView_my.register(UINib(nibName: "News_Information_TableViewCell", bundle: nil), forCellReuseIdentifier: "News_Information_TableViewCell")
    }
}
