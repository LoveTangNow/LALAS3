//
//  Label_And_RightBigImage_TableViewCell.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/9/29.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class Label_And_RightBigImage_TableViewCell: UITableViewCell {

    @IBOutlet weak var UILabel_: UILabel!
    @IBOutlet weak var UIImageView_: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        UIImageView_.layer.cornerRadius = 5
        UIImageView_.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
