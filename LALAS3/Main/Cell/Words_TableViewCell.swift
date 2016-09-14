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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
