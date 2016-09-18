//
//  AccountSecurityCell_LableSwitch_TableViewCell.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/18.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class AccountSecurityCell_LableSwitch_TableViewCell: UITableViewCell {
    
    @IBOutlet weak var UILabel_M: UILabel!
    @IBOutlet weak var UISwitch_M: UISwitch!

    @IBAction func UISwitch_do(_ sender: AnyObject) {
        print(UISwitch_M.isOn)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
