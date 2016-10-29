//
//  Pinglun_ViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/10/29.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import PhotosUI

class Pinglun_ViewController: UIViewController ,UITextViewDelegate{
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var myTextView: UITextView!
    @IBOutlet weak var leftItem: UIBarButtonItem!
    @IBOutlet weak var rightItem: UIBarButtonItem!
    
    @IBAction func LeftClick(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func RightClick(_ sender: UIBarButtonItem) {
        //发送
        SendData()
    }
    
    func SendData () {
        let Data: Parameters = ["newsid": String(newsid),"userid":userid!,"detail":myTextView.text]
        print(Data)
        Alamofire.request(GotServers().GotServerAliScripts() + "SEND_PINGLUN.php", method: .post, parameters: Data)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success://success
                    print("success")
                    self.dismiss(animated: true, completion: nil)
                    //let json = JSON(response.result.value!)
                case .failure(let error)://failure
                    print(error)
                }
        }
    }
    
    @IBAction func ActionSlide(_ sender: UIPanGestureRecognizer) {
        myTextView.resignFirstResponder()
        
    }

    var newsid = Int()//从第一页面获取
    var userid = Defalts_ReadWrite().ReadDefalts_String(KEY: "user_id")
    //时间：服务器获取
    //内容在textview 中
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTextView.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Defalts_ReadWrite().Settssssss_h(DATA: "Pinglun_ViewController", FORKEY: "whereifrom")
        //如果来自首页，那么进入详情页；如果来自详情页，那么什么也不跳转
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var isfristediting = true
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if isfristediting {
            myTextView.text = ""
            isfristediting = false
        }
        
    }
    

}
