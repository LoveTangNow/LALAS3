//
//  SaoYiSaoViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/14.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit
import swiftScan

class SaoYiSaoViewController: LBXScanViewController {
    
    
    /**
     @brief  扫码区域上方提示文字
     */
    var topTitle:UILabel?
    
    /**
     @brief  闪关灯开启状态
     */
    var isOpenedFlash:Bool = false
    
    // MARK: - 底部几个功能：开启闪光灯、相册、我的二维码
    //底部显示的功能项
    var bottomItemsView:UIView?
    //相册
    var btnPhoto:UIButton = UIButton()
    //闪光灯
    var btnFlash:UIButton = UIButton()
    //我的二维码
    var btnMyQR:UIButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //需要识别后的图像
        setNeedCodeImage(needCodeImg: true)
        //框向上移动10个像素
        scanStyle?.centerUpOffset += 10
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        drawBottomItems()
    }
    
    
    
    override func handleCodeResult(arrayResult: [LBXScanResult]) {
        for result:LBXScanResult in arrayResult
        {
            print("%@",result.strScanned ?? "")
        }
        let result:LBXScanResult = arrayResult[0]
        let vc = ScanResultController()
        vc.codeResult = result
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func drawBottomItems()
    {
        if (bottomItemsView != nil) {
            
            return;
        }
        
        let yMax = self.view.frame.maxY - self.view.frame.minY
        
        bottomItemsView = UIView(frame:CGRect(x: 0.0, y: yMax-100,width: self.view.frame.size.width, height: 100 ) )
        
        bottomItemsView!.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6)
        
        self.view .addSubview(bottomItemsView!)
        
        
        let size = CGSize(width: 65, height: 87);
        
        self.btnFlash = UIButton()
        btnFlash.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        btnFlash.center = CGPoint(x: bottomItemsView!.frame.width/2, y: bottomItemsView!.frame.height/2)
        btnFlash.setImage(UIImage(named: "lala.bundle/qrcode_scan_btn_flash_nor"), for:UIControlState.normal)
        btnFlash.addTarget(self, action: #selector(openOrCloseFlash), for: UIControlEvents.touchUpInside)
        //light
        
        
        self.btnPhoto = UIButton()
        btnPhoto.bounds = btnFlash.bounds
        btnPhoto.center = CGPoint(x: bottomItemsView!.frame.width/4, y: bottomItemsView!.frame.height/2)
        btnPhoto.setImage(UIImage(named: "lala.bundle/qrcode_scan_btn_photo_nor"), for: UIControlState.normal)
        btnPhoto.setImage(UIImage(named: "lala.bundle/qrcode_scan_btn_photo_down"), for: UIControlState.highlighted)
        btnPhoto.addTarget(self, action: #selector(LBXScanViewController.openPhotoAlbum), for: UIControlEvents.touchUpInside)
        //photo
        
        
        self.btnMyQR = UIButton()
        btnMyQR.bounds = btnFlash.bounds;
        btnMyQR.center = CGPoint(x: bottomItemsView!.frame.width * 3/4, y: bottomItemsView!.frame.height/2);
        btnMyQR.setImage(UIImage(named: "lala.bundle/qrcode_scan_btn_myqrcode_nor"), for: UIControlState.normal)
        btnMyQR.setImage(UIImage(named: "lala.bundle/qrcode_scan_btn_myqrcode_down"), for: UIControlState.highlighted)
        btnMyQR.addTarget(self, action: #selector(myCode), for: UIControlEvents.touchUpInside)
        //mycode
        
        bottomItemsView?.addSubview(btnFlash)
        bottomItemsView?.addSubview(btnPhoto)
        bottomItemsView?.addSubview(btnMyQR)
        
        self.view .addSubview(bottomItemsView!)
        
    }
    
    //开关闪光灯
    func openOrCloseFlash()
    {
        scanObj?.changeTorch();
        
        isOpenedFlash = !isOpenedFlash
        
        if isOpenedFlash
        {
            btnFlash.setImage(UIImage(named: "CodeScan.bundle/qrcode_scan_btn_flash_down"), for:UIControlState.normal)
        }
        else
        {
            btnFlash.setImage(UIImage(named: "CodeScan.bundle/qrcode_scan_btn_flash_nor"), for:UIControlState.normal)
        }
    }
    
    func myCode()
    {
        let vc = MyCodeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
