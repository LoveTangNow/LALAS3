//
//  Lable_And_Switch_TableViewCell.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/9/29.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class Lable_And_Switch_TableViewCell: UITableViewCell {
    
    @IBOutlet weak var UILabel_l: UILabel!
    @IBOutlet weak var uiswitch_: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
