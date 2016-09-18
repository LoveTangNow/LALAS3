//
//  AccountManagement_M_TableViewCell.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/18.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class AccountManagement_M_TableViewCell: UITableViewCell {
    
    @IBOutlet weak var UILabel_M: UILabel!
    
    @IBOutlet weak var UIImageView_M: UIImageView!

    override func awakeFromNib() {
        
        UIImageView_M.layer.cornerRadius = 10
        UIImageView_M.clipsToBounds = true
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
