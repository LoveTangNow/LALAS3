
//
//  WorksHieghts.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/10/24.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import Foundation
import UIKit

class WorksHieghts: AnyObject {
    func WorkWordsHeightForInformation (Words:String) -> CGFloat {
        let TextCount = Words.characters.count
        var TextLineNumber = 0
        var TotalHeightOfWords = 0
        
        switch UIScreen.main.bounds.width {
        case 320://se 啊发发还是 地方哈迪斯 阿卡哈尔法 和发达阿什顿
            if TextCount % 20 == 0 {
                TextLineNumber = TextCount / 20
            } else {
                TextLineNumber = ( TextCount - TextCount % 20 ) / 20 + 1
            }
        case 375://6  啊发发还是 地方哈迪斯 阿卡哈尔法 和发达阿什顿 发卡机是
            if TextCount % 24 == 0 {
                TextLineNumber = TextCount / 24
            } else {
                TextLineNumber = ( TextCount - TextCount % 24 ) / 24 + 1
            }
        case 414://6p 啊发发还是 地方哈迪斯 阿卡哈尔法 和发达阿什顿 发卡机是打发收
            if TextCount % 27 == 0 {
                TextLineNumber = TextCount / 27
            } else {
                TextLineNumber = ( TextCount - TextCount % 27 ) / 27 + 1
            }
        default: //se 啊发发还是 地方哈迪斯 阿卡哈尔法 和发达阿什顿
            if TextCount % 20 == 0 {
                TextLineNumber = TextCount / 20
            } else {
                TextLineNumber = ( TextCount - TextCount % 20 ) / 20 + 1
            }
        }
        print(TextCount)
        print(TextLineNumber)
        TotalHeightOfWords = TextLineNumber * 15
        return 80 + CGFloat(TotalHeightOfWords) //10 + 47 + 5 + 0+ ?
    }
    
    func WorkWordsHeightForPhotots(photoNumber:Int) -> CGFloat {
        let a  = (UIScreen.main.bounds.width - 20 - 6) / 3
        
        switch photoNumber {
        case 2,3:
            return a
        case 4,5,6:
            return 2 * a + 3
        case 7,8,9:
            return 3 * a + 6
        default:
            return UIScreen.main.bounds.width * 0.618
        }
    }

}
