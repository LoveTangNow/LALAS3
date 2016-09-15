//
//  Words_TableViewCell.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/14.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class Words_TableViewCell: UITableViewCell {
    
    @IBOutlet weak var UIImageView_UserIcon: UIImageView!
    @IBOutlet weak var UIImageView_Setting: UIImageView!
    
    @IBOutlet weak var UILabel_UserName: UILabel!
    @IBOutlet weak var UILabel_TimeAndDevice: UILabel!
    @IBOutlet weak var UILabel_Detail: UILabel!

    @IBOutlet weak var UIImageView_VIP: UIImageView!
    @IBOutlet weak var UIImageView_V: UIImageView!
    
    override func awakeFromNib() {
       
        // Initialization code
        UIImageView_V.layer.cornerRadius = 6
        UIImageView_V.clipsToBounds = true
        
        UIImageView_VIP.layer.cornerRadius = 8
        UIImageView_VIP.clipsToBounds = true
        
        UIImageView_UserIcon.layer.cornerRadius = 23.5
        UIImageView_UserIcon.clipsToBounds = true
        
        //print(UIImageView_UserIcon.frame.width)
        
        UIImageView_Setting.layer.cornerRadius = 6
        UIImageView_Setting.clipsToBounds = true
        
        UIImageView_VIP.isHidden = true
        
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
