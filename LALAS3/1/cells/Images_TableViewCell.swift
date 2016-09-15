//
//  Images_TableViewCell.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/15.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class Images_TableViewCell: UITableViewCell {

    @IBOutlet weak var UIImageView_1: UIImageView!
    @IBOutlet weak var UIImageView_2: UIImageView!
    @IBOutlet weak var UIImageView_3: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
