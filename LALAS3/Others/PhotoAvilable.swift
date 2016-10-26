//
//  PhotoAvilable.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/10/12.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit
import Foundation
import MobileCoreServices


/**我的拍照可行性类*/
class PhotoAvilable: AnyObject {
    
    func CanmraSupportsMedia(mediaType:String,sourceType:UIImagePickerControllerSourceType) ->Bool {
        let availableMediatypes = UIImagePickerController.availableMediaTypes(for: sourceType)! as [String]
        
        for type in availableMediatypes {
            if type == mediaType {
                return true
            }
        }
        return false
    }
    
    
    /**能否拍摄图片*/
    func CanShootPhoto()  ->Bool{
        return CanmraSupportsMedia(mediaType: kUTTypeImage as String, sourceType: .camera)
    }
    
    /**能否拍摄视频*/
    func CanShootVideo()  ->Bool{
        return CanmraSupportsMedia(mediaType: kUTTypeMovie as String, sourceType: .camera)
    }
    
    /**摄像头是否可用*/
    func IsCameraAvalible() -> Bool {
        return UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    /**前置摄像头是否可用*/
    func IsFrounCameraAvailabel() -> Bool {
        return UIImagePickerController.isCameraDeviceAvailable(.front)
    }
    
    /**后置摄像头是否可用*/
    func IsBackCameraAvailabel() -> Bool {
        return UIImagePickerController.isCameraDeviceAvailable(.rear)
    }
    
    /**前置闪光灯是否可用*/
    func IsFrountFlashAvailabel() -> Bool {
        return UIImagePickerController.isFlashAvailable(for: .front)
    }
    
    /**后置闪光灯是否可用*/
    func IsBackFlashAvailabel() -> Bool {
        return UIImagePickerController.isFlashAvailable(for: .rear)
    }
}
