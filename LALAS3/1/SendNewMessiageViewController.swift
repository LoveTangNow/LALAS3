//
//  SendNewMessiageViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/14.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit
import AVFoundation

class SendNewMessiageViewController: UIViewController{
    
    //MARK: - 绑定
    @IBOutlet weak var UITextView_Main: UITextView!
    
    @IBOutlet weak var UIButton_1: UIButton!
    @IBOutlet weak var UIButton_2: UIButton!
    @IBOutlet weak var UIButton_3: UIButton!
    @IBOutlet weak var UIButton_4: UIButton!
    
    @IBOutlet weak var UIButton_5: UIButton!
    //选择 图片 或者 拍摄
    @IBAction func UIButton_1_c(_ sender: AnyObject) {
        UIButton_2.isHidden = false
        Voice_Beng?.play()
    }

    @IBAction func UIButton_2_c(_ sender: AnyObject) {
        UIButton_3.isHidden = false
        Voice_Beng?.play()
    }
    
    @IBAction func UIButton_3_c(_ sender: AnyObject) {
        if DeivecWidth == 414 {//6p 才管用
            UIButton_4.isHidden = false
        }
        Voice_Beng?.play()
    }
    
    @IBAction func UIButton_4_c(_ sender: AnyObject) {
        Voice_Beng?.play()
    }
    
    @IBAction func UIButton_location(_ sender: AnyObject) {
    }
    
    
    @IBAction func Xiala(_ sender: AnyObject) {
        UITextView_Main.resignFirstResponder()
    }
    
    @IBAction func Send_Click(_ sender: AnyObject) {
        print("send click")
    }

    
    //MARK: - 变量
    var lmagelist = UIImage()
    
    let DeivecWidth = UIScreen.main.bounds.width
    let DeivecHeight = UIScreen.main.bounds.height
    
    var TableViewCellHeight:CGFloat = 0
    
    //肌肤默认的图片
    var Imageload_Black:UIImage = UIImage(named: "Black.png")!
    var Imageload_Wight:UIImage = UIImage(named: "White.png")!
    
    var Voice_Beng : AVAudioPlayer?
    
    //MARK: - ViewFuncs
    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer?  {
        let path = Bundle.main.path(forResource: file as String, ofType: type as String)
        let url = NSURL.fileURL(withPath: path!)
        var audioPlayer:AVAudioPlayer?
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url)
        } catch {
            print("Player not available")
        }
        
        return audioPlayer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIButton_1.setBackgroundImage(#imageLiteral(resourceName: "Black"), for: .normal)
        UIButton_2.setBackgroundImage(#imageLiteral(resourceName: "Black"), for: .normal)
        UIButton_3.setBackgroundImage(#imageLiteral(resourceName: "Black"), for: .normal)
        UIButton_4.setBackgroundImage(#imageLiteral(resourceName: "Black"), for: .normal)
        
        UIButton_1.setTitle("", for: .normal)
        UIButton_2.setTitle("", for: .normal)
        UIButton_3.setTitle("", for: .normal)
        UIButton_4.setTitle("", for: .normal)
        
        if let Voice_Beng = self.setupAudioPlayerWithFile(file: "Beng", type:"aiff") {
            self.Voice_Beng = Voice_Beng
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //左10 右10 上方的 textview 高度是 1/3
        //***********UI调整位置  在这里***********
        UITextView_Main.frame = CGRect(x:10,y:5,width:DeivecWidth - 20,height:DeivecHeight / 3)

        switch DeivecWidth {
        case 320:
            /**小屏幕：3列
             300
             间距是 3 的话，那么剩余297 / 3 = 99
             */
            UIButton_4.removeFromSuperview()
            let w = (DeivecWidth - 20 - 6) / 3
            
            UIButton_1.frame = CGRect(x:10,                y:(DeivecHeight / 3) + 10,width:w,height:w)
            UIButton_2.frame = CGRect(x:10 + w + 3,        y:(DeivecHeight / 3) + 10,width:w,height:w)
            UIButton_3.frame = CGRect(x:10 + w + 3 + w + 3,y:(DeivecHeight / 3) + 10,width:w,height:w)
            
            UIButton_2.isHidden = true
            UIButton_3.isHidden = true
            
            UIButton_5.frame = CGRect(x:10,y: (DeivecHeight / 3) + 15 + w,width:DeivecWidth - 10,height:45)
            UIButton_5.setTitle("   选择地点", for: .normal)
            UIButton_5.contentHorizontalAlignment = .left
            
        case 414:
            /**大屏幕：4列
             405 + 9 414
             间距是 3 的话，那么剩余405 / 4 = 101
             101* 4 404
             */
            let w = (DeivecWidth - 20 - 9) / 4
            UIButton_1.frame = CGRect(x:10,              y:(DeivecHeight / 3) + 10,width:w,height:w)
            UIButton_2.frame = CGRect(x:10 + w + 3,      y:(DeivecHeight / 3) + 10,width:w,height:w)
            UIButton_3.frame = CGRect(x:10 + (w + 3) * 2,y:(DeivecHeight / 3) + 10,width:w,height:w)
            UIButton_4.frame = CGRect(x:10 + (w + 3) * 3,y:(DeivecHeight / 3) + 10,width:w,height:w)
            
            UIButton_2.isHidden = true
            UIButton_3.isHidden = true
            UIButton_4.isHidden = true
            
            UIButton_5.frame = CGRect(x:10,y: (DeivecHeight / 3) + 15 + w,width:DeivecWidth - 10,height:45)
            UIButton_5.setTitle("   选择地点", for: .normal)
            UIButton_5.contentHorizontalAlignment = .left
            
        default:
            break
        }
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
