//
//  OnePhoto_Z_NTableViewCell.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/9/24.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class OnePhoto_Z_NTableViewCell: UITableViewCell {
    
    var GotPhoto = Bool()

    @IBOutlet weak var image_: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        image_.imageView?.contentMode = .scaleAspectFill
        image_.clipsToBounds = true
        image_.layer.cornerRadius = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
