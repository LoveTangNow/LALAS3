//
//  ThreeWhat_TableViewCell.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/10/7.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class ThreeWhat_TableViewCell: UITableViewCell {
    
    @IBOutlet weak var UILabel_l: UILabel!
    @IBOutlet weak var UILabel_m: UILabel!
    @IBOutlet weak var UILabel_r: UILabel!
    
    @IBOutlet weak var UIButton_l: UIButton!
    @IBOutlet weak var UIButton_m: UIButton!
    @IBOutlet weak var UIButton_r: UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
