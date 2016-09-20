//
//  CommentsPraiseDemote_TableViewCell.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/14.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class CommentsPraiseDemote_TableViewCell: UITableViewCell {
    
    @IBOutlet weak var UIButton_1: UIButton!
    @IBOutlet weak var UIButton_2: UIButton!
    @IBOutlet weak var UIButton_3: UIButton!
    
    var Pinglun_NUM = 0
    var Zan_NUM = 0
    var Cai_NUM = 0
    
    var Pinglun_BOOL = false
    var Zan_BOOL = false
    var Cai_BOOL = false
    
    var Sender_ID:String = ""

    
    @IBAction func UIButton_1_Click(_ sender: AnyObject) {
        if Pinglun_BOOL == false {
            Pinglun_NUM += 1
            Pinglun_BOOL = true
        } else {
            Pinglun_NUM -= 1
            Pinglun_BOOL = false
        }
        
        UIButton_1.setTitle("评论" + String(Pinglun_NUM), for:.normal)
        
    }
    @IBAction func UIButton_2_Click(_ sender: AnyObject) {
        //赞
        if Zan_BOOL == false {
            Zan_NUM += 1
            Zan_BOOL = true
        } else {
            Zan_NUM -= 1
            Zan_BOOL = false
        }
        
        UIButton_2.setTitle("赞" + String(Zan_NUM), for:.normal)
        
    }
    @IBAction func UIButton_3_Click(_ sender: AnyObject) {
        //踩
        if Cai_BOOL == false {
            Cai_NUM += 1
            Cai_BOOL = true
        } else {
            Cai_NUM -= 1
            Cai_BOOL = false
        }
        
        UIButton_3.setTitle("踩" + String(Cai_NUM), for:.normal)

        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
         UIButton_1.setTitle("评论" + String(Cai_NUM), for:.normal)
         UIButton_2.setTitle("赞" + String(Cai_NUM), for:.normal)
         UIButton_3.setTitle("踩" + String(Cai_NUM), for:.normal)

        // Configure the view for the selected state
    }

}
