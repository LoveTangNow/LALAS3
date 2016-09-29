//
//  NinePhoto_TableViewCell.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/9/24.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class NinePhoto_TableViewCell: UITableViewCell {
    
    var GotPhoto = Bool()
    
    @IBOutlet weak var UIImageView1: UIImageView!
    @IBOutlet weak var UIImageView2: UIImageView!
    @IBOutlet weak var UIImageView3: UIImageView!
    
    @IBOutlet weak var UIImageView4: UIImageView!
    @IBOutlet weak var UIImageView5: UIImageView!
    @IBOutlet weak var UIImageView6: UIImageView!
    
    @IBOutlet weak var UIImageView7: UIImageView!
    @IBOutlet weak var UIImageView8: UIImageView!
    @IBOutlet weak var UIImageView9: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
