//
//  Pinglun_NTableViewCell.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/9/24.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

//评论一般性的TableViewCell 包含：icon 点赞按钮 name time detail

import UIKit

class Pinglun_NTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var image_icon: UIButton!
    @IBOutlet weak var UIButton_Zan: UIButton!
    
    @IBOutlet weak var UILabel_Name: UILabel!
    @IBOutlet weak var UILabelTime: UILabel!
    @IBOutlet weak var UILabelWords: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        image_icon.layer.cornerRadius = 20
        image_icon.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
