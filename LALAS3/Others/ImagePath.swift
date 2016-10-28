//
//  ImagePath.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/10/29.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import Foundation
import UIKit

class ImagePath: AnyObject {
    
    private func GotCachesPath() -> String {
        let cachesPaths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let cachesPath = cachesPaths[0]
        return cachesPath
    }
    
    func WriteImageToCachesPaths_In_PNG(image:UIImage,imagename:String) -> () {
        let data1 : NSData = UIImagePNGRepresentation(image)! as NSData
        data1.write(toFile: GotCachesPath() + imagename + ".PNG", atomically: true)
    }
    
    func GetImageFromCachesPaths(imagename:String) -> UIImage? {
        let image = UIImage.init(contentsOfFile:  GotCachesPath() + imagename + ".PNG")
        return image
    }
}
