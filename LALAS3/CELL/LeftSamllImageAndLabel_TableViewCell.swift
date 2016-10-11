//
//  LeftSamllImageAndLabel_TableViewCell.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/9/29.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class LeftSamllImageAndLabel_TableViewCell: UITableViewCell {
    
    var myimage = UIImage()
    var mystring = String()
    

    @IBOutlet weak var UIImageView_m: UIImageView!
    @IBOutlet weak var UILabel_m: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        UIImageView_m.layer.cornerRadius = 5
        UIImageView_m.clipsToBounds = true
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
