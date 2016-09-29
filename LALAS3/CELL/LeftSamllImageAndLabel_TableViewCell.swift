//
//  LeftSamllImageAndLabel_TableViewCell.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/9/29.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class LeftSamllImageAndLabel_TableViewCell: UITableViewCell {

    @IBOutlet weak var UIImageView_m: UIImageView!
    @IBOutlet weak var UILabel_m: UILabel!
    
    override func awakeFromNib() {
        
        UIImageView_m.layer.cornerRadius = 5
        UIImageView_m.clipsToBounds = true
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
