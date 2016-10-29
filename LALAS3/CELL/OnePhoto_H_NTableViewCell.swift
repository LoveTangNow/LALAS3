//
//  OnePhoto_H_NTableViewCell.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/9/24.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class OnePhoto_H_NTableViewCell: UITableViewCell {
    
    var GotPhoto = Bool()


    @IBOutlet weak var image_1: UIButton!
    @IBOutlet weak var image1: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        image_1.contentMode = .scaleAspectFill
        image_1.clipsToBounds = true
        image_1.layer.cornerRadius = 3
        image_1.tag = 1
        
        image1.contentMode = .scaleAspectFill
        image1.clipsToBounds = true
        image1.layer.cornerRadius = 3
        
        image1.layer.shadowOpacity = 0.8
        image1.layer.shadowColor = UIColor.red.cgColor
        image1.layer.shadowOffset = CGSize(width: 2, height: 2)
        image1.layer.shadowRadius = 5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
