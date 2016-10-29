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
        
    }
    @IBAction func ActionSlide(_ sender: UIPanGestureRecognizer) {
        myTextView.resignFirstResponder()
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTextView.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Defalts_ReadWrite().Settssssss_h(DATA: "Pinglun_ViewController", FORKEY: "whereifrom")
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
