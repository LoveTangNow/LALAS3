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
    
    @IBOutlet weak var image_1: UIButton!
    @IBOutlet weak var image_2: UIButton!
    @IBOutlet weak var image_3: UIButton!
    @IBOutlet weak var image_4: UIButton!
    @IBOutlet weak var image_5: UIButton!
    @IBOutlet weak var image_6: UIButton!
    @IBOutlet weak var image_7: UIButton!
    @IBOutlet weak var image_8: UIButton!
    @IBOutlet weak var image_9: UIButton!
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var image6: UIImageView!
    @IBOutlet weak var image7: UIImageView!
    @IBOutlet weak var image8: UIImageView!
    @IBOutlet weak var image9: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let w  = UIScreen.main.bounds.width / 3
        
        image_1.frame = CGRect(x:0,y:0,width:w,height:w)
        image_1.imageView?.contentMode = .scaleAspectFill
        image_1.clipsToBounds = true
        image_1.layer.cornerRadius = 2
        image_1.tag = 1
        
        image_2.frame = CGRect(x:w,y:0,width:w,height:w)
        image_2.imageView?.contentMode = .scaleAspectFill
        image_2.clipsToBounds = true
        image_2.layer.cornerRadius = 2
        image_1.tag = 2
        
        image_3.frame = CGRect(x:2 * w,y:0,width:w,height:w)
        image_3.imageView?.contentMode = .scaleAspectFill
        image_3.clipsToBounds = true
        image_3.layer.cornerRadius = 2
        image_1.tag = 3
        
        image_4.frame = CGRect(x:0,y:w,width:w,height:w)
        image_4.imageView?.contentMode = .scaleAspectFill
        image_4.clipsToBounds = true
        image_4.layer.cornerRadius = 2
        image_1.tag = 4
        
        image_5.frame = CGRect(x:w,y:w,width:w,height:w)
        image_5.imageView?.contentMode = .scaleAspectFill
        image_5.clipsToBounds = true
        image_5.layer.cornerRadius = 2
        image_1.tag = 5
        
        image_6.frame = CGRect(x:2 * w,y:w,width:w,height:w)
        image_6.imageView?.contentMode = .scaleAspectFill
        image_6.clipsToBounds = true
        image_6.layer.cornerRadius = 2
        image_1.tag = 6
        
        image_7.frame = CGRect(x:0,y:2 * w,width:w,height:w)
        image_7.imageView?.contentMode = .scaleAspectFill
        image_7.clipsToBounds = true
        image_7.layer.cornerRadius = 2
        image_1.tag = 7
        
        image_8.frame = CGRect(x:w,y:2 * w,width:w,height:w)
        image_8.imageView?.contentMode = .scaleAspectFill
        image_8.clipsToBounds = true
        image_8.layer.cornerRadius = 2
        image_1.tag = 8
        
        image_9.frame = CGRect(x:2 * w,y:2 * w,width:w,height:w)
        image_9.imageView?.contentMode = .scaleAspectFill
        image_9.clipsToBounds = true
        image_9.layer.cornerRadius = 2
        image_1.tag = 9
        
        //-------------------------------//
        image1.frame = CGRect(x:0,y:0,width:w,height:w)
        image1.contentMode = .scaleAspectFill
        image1.clipsToBounds = true
        image1.layer.cornerRadius = 2
        
        image2.frame = CGRect(x:w,y:0,width:w,height:w)
        image2.contentMode = .scaleAspectFill
        image2.clipsToBounds = true
        image2.layer.cornerRadius = 2
        
        image3.frame = CGRect(x:2 * w,y:0,width:w,height:w)
        image3.contentMode = .scaleAspectFill
        image3.clipsToBounds = true
        image3.layer.cornerRadius = 2
        
        image4.frame = CGRect(x:0,y:w,width:w,height:w)
        image4.contentMode = .scaleAspectFill
        image4.clipsToBounds = true
        image4.layer.cornerRadius = 2
        
        image5.frame = CGRect(x:w,y:w,width:w,height:w)
        image5.contentMode = .scaleAspectFill
        image5.clipsToBounds = true
        image5.layer.cornerRadius = 2
        
        image6.frame = CGRect(x:2 * w,y:w,width:w,height:w)
        image6.contentMode = .scaleAspectFill
        image6.clipsToBounds = true
        image6.layer.cornerRadius = 2
        
        image7.frame = CGRect(x:0,y:2 * w,width:w,height:w)
        image7.contentMode = .scaleAspectFill
        image7.clipsToBounds = true
        image7.layer.cornerRadius = 2
        
        image8.frame = CGRect(x:w,y:2 * w,width:w,height:w)
        image8.contentMode = .scaleAspectFill
        image8.clipsToBounds = true
        image8.layer.cornerRadius = 2
        
        image9.frame = CGRect(x:2 * w,y:2 * w,width:w,height:w)
        image9.contentMode = .scaleAspectFill
        image9.clipsToBounds = true
        image9.layer.cornerRadius = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
