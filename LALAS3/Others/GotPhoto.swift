//
//  GotPhoto.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/10/15.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import Foundation
import Alamofire
import UIKit


class GotPhoto: AnyObject {
    
    func GotOnePhoto(Path:String) -> UIImage {
        var asd = UIImage()
        Alamofire.request(Path)
            .responseData { response in
                if let data = response.result.value {
                    asd = UIImage(data: data)!
                }
            }
        return asd
    }
}
