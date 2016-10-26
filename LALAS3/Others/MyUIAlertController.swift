//
//  MyUIAlertController.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/10/19.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import Foundation
import UIKit

class MyUIAlertController: AnyObject {
    
    /**封装的简单的 UIAlertController  方法：如参数（现在的 viewcontrollore；uialertactions 的数组））*/
    func MyUIAlertController_(viewcontrollor:UIViewController,UIAlertActions:[UIAlertAction]) -> () {
        let actionSheetController: UIAlertController = UIAlertController(title: "请选择", message:nil, preferredStyle: .actionSheet)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "取消", style: .cancel){ action -> Void in
        }
        actionSheetController.addAction(cancelAction)
        //let PikePhoto: UIAlertAction = UIAlertAction(title: "从相册选择图片", style: .destructive){ action -> Void in}
        //actionSheetController.addAction(PikePhoto)
        
        for i  in UIAlertActions {
            actionSheetController.addAction(i)
        }
        
        viewcontrollor.present(actionSheetController, animated: true, completion: nil)
    }
    
    func MyUIAlertController_(viewcontrollor:UIViewController,UIAlertActions:[UIAlertAction],withCancel:Bool) -> () {
        let actionSheetController: UIAlertController = UIAlertController(title: "请选择", message:nil, preferredStyle: .actionSheet)

        if withCancel == true {
            let cancelAction: UIAlertAction = UIAlertAction(title: "取消", style: .cancel){ action -> Void in
            }
            actionSheetController.addAction(cancelAction)
        }

        
        //let PikePhoto: UIAlertAction = UIAlertAction(title: "从相册选择图片", style: .destructive){ action -> Void in}
        //actionSheetController.addAction(PikePhoto)
        
        for i  in UIAlertActions {
            actionSheetController.addAction(i)
        }
        
        viewcontrollor.present(actionSheetController, animated: true, completion: nil)
    }
    
    
    func alertController_simple(viewcontrollor:UIViewController,tips:String,UIAlertActions:String) -> () {
        let alertController = UIAlertController(title: "系统提示",
                                                message: tips,
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
            action in
            
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        viewcontrollor.present(alertController, animated: true, completion: nil)
    }

}
