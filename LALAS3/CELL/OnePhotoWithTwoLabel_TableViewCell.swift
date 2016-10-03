//
//  OnePhotoWithTwoLabel_TableViewCell.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/10/3.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class OnePhotoWithTwoLabel_TableViewCell: UITableViewCell {
    
    @IBOutlet weak var UIImageView_Left_Main: UIImageView!
    @IBOutlet weak var UILabel_Title: UILabel!
    @IBOutlet weak var UILabel_Detail: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
