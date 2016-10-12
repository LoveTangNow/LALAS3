//
//  SecondViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/14.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit
import CoreData


class SecondViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource{
    
    
    let image_l = #imageLiteral(resourceName: "Black")
    
    
    @IBOutlet weak var UITableView_M: UITableView!
    @IBAction func UIButton_L_Click(_ sender: AnyObject) {
        let vc = UIStoryboard(name: "T", bundle: nil).instantiateViewController(withIdentifier: "Web_ViewController") as! Web_ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func UIButton_R_Click(_ sender: AnyObject) {
        let vc = UIStoryboard(name: "Fourth", bundle: nil).instantiateViewController(withIdentifier: "SomePeople_ViewController") as! SomePeople_ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "消息"
        
        UITableView_M.delegate = self
        UITableView_M.dataSource = self
        
        ConnectNib()
        
        //self.UITableView_M.setEditing(true, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatPeople_TableViewCell") as? ChatPeople_TableViewCell
        
        cell?.UIImageView_Main.image = image_l
        cell?.UIImageView_Zhiding.image = image_l
        cell?.UIImageView_Readornot.image = image_l
        
        return cell!
        
    }
    
    //T_ViewController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // T_ViewController
        
        //Chat_ViewController
        let vc = UIStoryboard(name: "Second", bundle: nil).instantiateViewController(withIdentifier: "Chat_ViewController")
        self.navigationController?.pushViewController(vc, animated: true)
        
        /**
        let vc = UIStoryboard(name: "Second", bundle: nil).instantiateViewController(withIdentifier: "T_ViewController")
        self.navigationController?.pushViewController(vc, animated: true)
        */
        
        /**
        let uri = "http://www.baidu.com";
        let url = NSURL(string: uri)!;
        let request = NSMutableURLRequest(url: url as URL);
        /**
         *  .设置缓存策略
         *  .UseProtocolCachePolicy：依赖于请求头的设置，默认状态;
         *  .ReloadIgnoringLocalCacheData：忽略缓存，重新请求服务器
         *  .ReturnCacheDataElseLoad：有缓存使用缓存，无缓存请求服务器
         *  .ReturnCacheDataDontLoad：离线模式，有缓存使用缓存，无缓存不请求服务器
         */
        request.cachePolicy = NSURLRequest.CachePolicy.returnCacheDataElseLoad;
        // 获得全局缓存对象
        let cache = URLCache.shared;
        //
        let response = cache.cachedResponse(for: request as URLRequest);
        if response == nil {
            // 本地无缓存
            print("no cache");
        } else {
            // 本地有缓存
            print("exist cache");
            // 将当前请求的缓存数据删除，获取最新数据
            cache.removeCachedResponse(for: request as URLRequest);
            // 清除所有缓存
            // cache.removeAllCachedResponses();
        }
        
        NSURLConnection(request: request as URLRequest, delegate: self);
 */

    }
    
    /**
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.none
    }
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let fromerow = [sourceIndexPath]
        let torow = [destinationIndexPath]
        
        UITableView_M.insertRows(at: torow , with: UITableViewRowAnimation.automatic)
        UITableView_M.deleteRows(at: fromerow , with: UITableViewRowAnimation.automatic)
    }
 */
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 15
        default:
            return 0
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 100
        default:
            return 0
        }
    }
    
    
    func ConnectNib ()  {
        UITableView_M.register(UINib(nibName: "ChatPeople_TableViewCell", bundle: nil), forCellReuseIdentifier: "ChatPeople_TableViewCell")
    }

    /*
     let diaryList:String = Bundle.main.path(forResource: "/Server", ofType:"plist")!
     let data:NSMutableDictionary = NSMutableDictionary(contentsOfFile:diaryList)!
     print(data.object(forKey: "ServerImageT") as! String)
     
     
     let array = NSArray(objects: "hangge.com","baidu.com","google.com","163.com","qq.com")
     let filePath:String = NSHomeDirectory() + "/Documents/webs.plist"
     array.write(toFile: filePath, atomically: true)
     
     
     let webs = NSArray(contentsOfFile: NSHomeDirectory() + "/Documents/webs.plist")
     let url = webs![(webs?.count)! - 1] as! String
     print(url)
     */

}
