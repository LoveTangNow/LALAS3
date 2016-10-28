//
//  Paixu.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/10/28.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import Foundation

class Paixu : AnyObject {
    
    ///类数字型 字符串数组 冒泡排序
    func Stringlike_Number(Data:[String]) -> [Int] {
        var End = Data.count
        var NumberData = [Int]()
        for i in Data {
            NumberData.append(Int(i)!)
        }
        let repeatTimr = End - 1
        let EndPlace = End - 2
        for _  in 0...repeatTimr {
            for i in 0...EndPlace {
                if NumberData[i] > NumberData[i + 1]  {
                    //对调
                    let inin = NumberData[i + 1]
                    NumberData[i + 1] = NumberData[i]
                    NumberData[i] = inin
                }
            }
            End -= 1
        }
        return NumberData
    }
    
    ///Int数组 冒泡排序
    func Stringlike_Number(Data:[Int]) -> [Int] {
        var End = Data.count
        var Data = Data
        let repeatTimr = End - 1
        let EndPlace = End - 2
        for _  in 0...repeatTimr {
            for i in 0...EndPlace {
                if Data[i] > Data[i + 1]  {
                    //对调
                    let inin = Data[i + 1]
                    Data[i + 1] = Data[i]
                    Data[i] = inin
                }
            }
            End -= 1
        }
        return Data
    }
    
    /*
     一个是 id ，一个是时间。
     我们是按照时间来排列顺序
     */
    
    func Diclike(ID:[Int],Date:[String]) ->([Int],[String]) {
        var End = ID.count
        var ID  = ID
        let Date = Date
        //得到外来两个数据
        var NewDate = [Int]()
        for i in Date {
            NewDate.append(Int(i)!)
        }
        let repeatTimr = End - 1
        let EndPlace = End - 2
        for _  in 0...repeatTimr {
            for i in 0...EndPlace {
                
                if  NewDate[i] > NewDate[i + 1]  {
                    //对调 两个
                    let inin = NewDate[i + 1]
                    NewDate[i + 1] = NewDate[i]
                    NewDate[i] = inin
                    
                    let ininin = ID[i + 1]
                    ID[i + 1] = ID[i]
                    ID[i] = ininin
                }
            }
            End -= 1
        }
        var NewDate_ = [String]()
        for i in NewDate {
            NewDate_.append(String(i))
        }
        return (ID,NewDate_)
        
    }

}
