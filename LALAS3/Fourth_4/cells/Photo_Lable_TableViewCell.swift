//
//  Photo_Lable_TableViewCell.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/15.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class Photo_Lable_TableViewCell: UITableViewCell {
    
    @IBOutlet weak var UIImageView_Main: UIImageView!
    @IBOutlet weak var UILabel_Main: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
