//
//  SendNewMessiageViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/14.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices

class SendNewMessiageViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    //MARK: - 变量
    var lmagelist = UIImage()
    
    let DeivecWidth = UIScreen.main.bounds.width
    let DeivecHeight = UIScreen.main.bounds.height
    
    var TableViewCellHeight:CGFloat = 0
    var controllor:UIImagePickerController?
    
    //肌肤默认的图片
    var Imageload_Black:UIImage = UIImage(named: "Black.png")!
    var Imageload_Wight:UIImage = UIImage(named: "White.png")!
    
    var Voice_Beng : AVAudioPlayer?
    var imageNumbersAlreadyGot = 0
    var imagePicker     : UIImagePickerController!
    
    
    //MARK: - 绑定
    @IBOutlet weak var UITextView_Main: UITextView!
    @IBOutlet weak var UIButton_1: UIButton!
    @IBOutlet weak var UIButton_5: UIButton!
    
    //选择 图片 或者 拍摄
    @IBAction func UIButton_1_c(_ sender: AnyObject) {
        TakePhoto()
        
        Voice_Beng?.play()
        //print(imageNumbersAlreadyGot)
        let w = (DeivecWidth - 20 - 9) / 4//button 和 图片 的宽高度
        switch imageNumbersAlreadyGot {
        case 0,1,2://→
            UIView.animate(withDuration: 0.5, animations: {
                self.UIButton_1.center.x += w
            })
        case 3:
            UIView.animate(withDuration: 0, animations: {
                self.UIButton_1.center.y += w
                self.UIButton_1.alpha = 0
            })
        default://8返回
            break
        }
        imageNumbersAlreadyGot += 1
    }
    
    @IBAction func UIButton_location(_ sender: AnyObject) {
        
        let piker = UIImagePickerController()
        piker.delegate = self
        
        
        let actionSheetController: UIAlertController = UIAlertController(title: "请选择", message:nil, preferredStyle: .actionSheet)
        let cancelAction: UIAlertAction = UIAlertAction(title: "取消", style: .cancel) { action -> Void in}
        let takePictureAction: UIAlertAction = UIAlertAction(title: "拍照", style: .default){ action -> Void in
            piker.sourceType = .camera
            self.navigationController?.present(piker, animated: true, completion: nil)
            //self .initWithImagePickView(type: "拍照")
        }
        let choosePictureAction: UIAlertAction = UIAlertAction(title: "相册", style: .default){ action -> Void in
            //self .initWithImagePickView(type: "相册")
            self.navigationController?.present(piker, animated: true, completion: nil)
        }
        let moviePictureAction: UIAlertAction = UIAlertAction(title: "摄像", style: .default){ action -> Void in
            //self .initWithImagePickView(type: "摄像")
        }
        actionSheetController.addAction(cancelAction)
        actionSheetController.addAction(takePictureAction)
        actionSheetController.addAction(choosePictureAction)
        actionSheetController.addAction(moviePictureAction)
        
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    func TakePhoto()  {
        let a  = PhotoAvilable()
        if a.IsCameraAvalible() && a.CanShootPhoto(){
            controllor = UIImagePickerController()
            if let thecontrollor = controllor {
                thecontrollor.sourceType = .camera
                thecontrollor.mediaTypes = [kUTTypeImage as String]
                thecontrollor.allowsEditing = true
                thecontrollor.delegate = self
                present(thecontrollor, animated: true, completion: nil)
            }
            else{
                print("boooooooom")
            }
        }
    }

    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let mediaType:AnyObject? = info[UIImagePickerControllerMediaType] as AnyObject?
        if let type:AnyObject = mediaType {
            if type is String {
                let stringType = type as! String
                if stringType == kUTTypeMovie  as String {
                    let urlvedio = info[UIImagePickerControllerMediaURL] as? NSURL
                    if let url = urlvedio {
                        print("video url = \(url)")
                    }
                }
                else if stringType == kUTTypeImage as String{
                    let metadata = info[UIImagePickerControllerMediaMetadata] as? NSDictionary
                    if let themetadata = metadata {
                        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
                        if let theimage = image {
                            print("\(themetadata)")
                            print("image = \(theimage)")
                            //得到了 IMAGE
                            UIButton_1.setImage(theimage, for: .normal)
                        }
                    }
                }
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    /*
     private func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
     let mediaType = info[UIImagePickerControllerMediaType] as! String
     let compareResult = CFStringCompare(mediaType as NSString!, kUTTypeMovie, CFStringCompareFlags.compareCaseInsensitive)
     
     if compareResult == CFComparisonResult.compareEqualTo {
     let moviePath = info[UIImagePickerControllerMediaURL] as? NSURL
     //获取路径
     let moviePathString = moviePath!.relativePath
     if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(moviePathString!){
     UISaveVideoAtPathToSavedPhotosAlbum(moviePathString!, nil, nil, nil)
     }
     print("视频")
     }else {
     print("图片")
     _ = info[UIImagePickerControllerOriginalImage] as? UIImage
     //lmagelist.append(image!)
     //self.tableView.reloadData()
     //得到了 image //怎么传达 tableview 的控件上？、
     //self.imageView!.image =  image;
     }
     imagePicker.dismiss(animated: true, completion: nil)
     }*/

    
    /*
    func initWithImagePickView(type:NSString){
        self.imagePicker = UIImagePickerController()
        self.imagePicker.delegate      = self;
        self.imagePicker.allowsEditing = true;
        
        switch type{
        case "拍照":
            self.imagePicker.sourceType = .camera
        case "相册":
            self.imagePicker.sourceType = .photoLibrary
        case "摄像":
            self.imagePicker.sourceType = .camera
            self.imagePicker.videoMaximumDuration = 60 * 3
            self.imagePicker.videoQuality = .type640x480
            self.imagePicker.mediaTypes = [String(kUTTypeMovie)]
        default:
            print("error")
        }
        self.present(self.imagePicker, animated: true, completion: nil)
    }*/
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func Xiala(_ sender: AnyObject) {
        UITextView_Main.resignFirstResponder()
    }
    
    @IBAction func Send_Click(_ sender: AnyObject) {
        print("send click")
    }
    
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
    
    func click(note:UIControlEvents)
    {
        print("cc")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIButton_1.setBackgroundImage(#imageLiteral(resourceName: "Black"), for: .normal)
        UIButton_1.setTitle("", for: .normal)

        if let Voice_Beng = self.setupAudioPlayerWithFile(file: "Beng", type:"aiff") {
            self.Voice_Beng = Voice_Beng
        }
        
        let btn:UIButton = UIButton(frame: CGRect(x: 50, y: 65, width: 50, height: 50))
        btn.setImage(#imageLiteral(resourceName: "Black"), for: UIControlState.normal)
        self.view.addSubview(btn)
        //给按钮添加点击事件
        btn.addTarget(self, action: #selector(click), for: UIControlEvents.touchUpInside)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        //左10 右10 上方的 textview 高度是 1/3
        //***********UI调整位置  在这里***********
        UITextView_Main.frame = CGRect(x:10,y:5,width:DeivecWidth - 20,height:DeivecHeight / 3)

        let w = (DeivecWidth - 20 - 9) / 4
            
        UIButton_1.frame = CGRect(x:10,y:(DeivecHeight / 3) + 10,width:w,height:w)
            
        UIButton_5.frame = CGRect(x:10,y: (DeivecHeight / 3) + 15 + w,width:DeivecWidth - 10,height:45)
        UIButton_5.setTitle("   选择地点", for: .normal)
        UIButton_5.contentHorizontalAlignment = .left

    }
    override func viewDidAppear(_ animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
