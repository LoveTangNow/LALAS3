//
//  SixPhoto_TableViewCell.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/9/24.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class SixPhoto_TableViewCell: UITableViewCell {
    
    var GotPhoto = Bool()
    
    @IBOutlet weak var image_1: UIButton!
    @IBOutlet weak var image_2: UIButton!
    @IBOutlet weak var image_3: UIButton!
    @IBOutlet weak var image_4: UIButton!
    @IBOutlet weak var image_5: UIButton!
    @IBOutlet weak var image_6: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let w  = UIScreen.main.bounds.width / 3
        
        image_1.frame = CGRect(x:0,y:0,width:w,height:w)
        image_1.imageView?.contentMode = .scaleAspectFill
        image_1.clipsToBounds = true
        image_1.layer.cornerRadius = 2
        
        image_2.frame = CGRect(x:w,y:0,width:w,height:w)
        image_2.imageView?.contentMode = .scaleAspectFill
        image_2.clipsToBounds = true
        image_2.layer.cornerRadius = 2
        
        image_3.frame = CGRect(x:2 * w,y:0,width:w,height:w)
        image_3.imageView?.contentMode = .scaleAspectFill
        image_3.clipsToBounds = true
        image_3.layer.cornerRadius = 2
        
        image_4.frame = CGRect(x:0,y:w,width:w,height:w)
        image_4.imageView?.contentMode = .scaleAspectFill
        image_4.clipsToBounds = true
        image_4.layer.cornerRadius = 2
        
        image_5.frame = CGRect(x:w,y:w,width:w,height:w)
        image_5.imageView?.contentMode = .scaleAspectFill
        image_5.clipsToBounds = true
        image_5.layer.cornerRadius = 2
        
        image_6.frame = CGRect(x:2 * w,y:w,width:w,height:w)
        image_6.imageView?.contentMode = .scaleAspectFill
        image_6.clipsToBounds = true
        image_6.layer.cornerRadius = 2

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
