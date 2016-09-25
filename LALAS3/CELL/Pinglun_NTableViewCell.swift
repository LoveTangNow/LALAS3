//
//  Pinglun_NTableViewCell.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/9/24.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class Pinglun_NTableViewCell: UITableViewCell {
    
    @IBOutlet weak var UIImageView_Icon: UIImageView!
    
    @IBOutlet weak var UIButton_Zan: UIButton!

    @IBOutlet weak var UILabel_Name: UILabel!
    @IBOutlet weak var UILabelTime: UILabel!
    @IBOutlet weak var UILabelWords: UILabel!
    
    @IBAction func ButtonC(_ sender: AnyObject) {
    }
    
    override func awakeFromNib() {
        
        UIImageView_Icon.layer.cornerRadius = 20
        UIImageView_Icon.clipsToBounds = true
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
