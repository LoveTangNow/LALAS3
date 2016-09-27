//
//  Web_ViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/9/27.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit
import WebKit

class Web_ViewController: UIViewController {
    //MARK: - 变量
    let width_d  = UIScreen.main.bounds.width
    let height_d = UIScreen.main.bounds.height
    
    var WebView = WKWebView()
    //var TextField  = UITextField()
    
    //MARK: - 绑定
    
    //MARK: - FUNC
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        WebView.frame = CGRect(x:0,y:44,width:width_d,height:height_d)
        self.view.addSubview(WebView)
        self.navigationController?.isNavigationBarHidden = false
        
        //self.navigationController?.popViewController(animated: true)
        //TextField.frame = CGRect(x:0,y:0,width:width_d,height:TextField.frame.height)
        //self.navigationController?.navigationBar.addSubview(TextField)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let url = NSURL(string:"http://www.baidu.com")
        let request = NSURLRequest(url:url! as URL)
        WebView.load(request as URLRequest)
        
        //self.navigationController?.view.sendSubview(toBack: (self.navigationController?.navigationBar)!)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //self.navigationController?.view.bringSubview(toFront: (self.navigationController?.navigationBar)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
