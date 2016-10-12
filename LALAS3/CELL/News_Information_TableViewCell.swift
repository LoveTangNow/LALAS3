//
//  News_Information_TableViewCell.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/9/24.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class News_Information_TableViewCell: UITableViewCell {
    

    @IBOutlet weak var userIcon: UIButton!
    @IBOutlet weak var setting: UIButton!
    
    @IBOutlet weak var UIImageViewVip_: UIImageView!
    @IBOutlet weak var UIImageViewV_: UIImageView!
    
    @IBOutlet weak var UILabelUserName: UILabel!
    @IBOutlet weak var UILabelInformation: UILabel!
    @IBOutlet weak var UILabelDetail: UILabel!
    

    override func awakeFromNib() {
        
        userIcon.layer.cornerRadius = 23.5
        userIcon.clipsToBounds = true
        
        setting.layer.cornerRadius = 15
        setting.clipsToBounds = true
        
        UIImageViewVip_.layer.cornerRadius = 8
        UIImageViewVip_.clipsToBounds = true
        
        UIImageViewV_.layer.cornerRadius = 6
        UIImageViewV_.clipsToBounds = true
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
