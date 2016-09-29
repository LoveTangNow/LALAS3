//
//  ThreePhoto_NTableViewCell.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/9/24.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class ThreePhoto_NTableViewCell: UITableViewCell {
    
    var GotPhoto = Bool()

    @IBOutlet weak var UIImageView1: UIImageView!
    @IBOutlet weak var UIImageView2: UIImageView!
    @IBOutlet weak var UIImageView3: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
