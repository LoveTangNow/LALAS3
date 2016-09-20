//
//  SevenEightNinePhoto_TableViewCell.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/14.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class SevenEightNinePhoto_TableViewCell: UITableViewCell {

    @IBOutlet weak var UIImageView_1: UIImageView!
    @IBOutlet weak var UIImageView_2: UIImageView!
    @IBOutlet weak var UIImageView_3: UIImageView!
    
    @IBOutlet weak var UIImageView_4: UIImageView!
    @IBOutlet weak var UIImageView_5: UIImageView!
    @IBOutlet weak var UIImageView_6: UIImageView!
    
    @IBOutlet weak var UIImageView_7: UIImageView!
    @IBOutlet weak var UIImageView_8: UIImageView!
    @IBOutlet weak var UIImageView_9: UIImageView!
    
    var GotPhoto:Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
