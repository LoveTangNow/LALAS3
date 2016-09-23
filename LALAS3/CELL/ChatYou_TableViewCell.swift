//
//  ChatYou_TableViewCell.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/9/22.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class ChatYou_TableViewCell: UITableViewCell {

    @IBOutlet weak var UIImageView_SenderIcon: UIImageView!
    @IBOutlet weak var UIImageView_Sanjiao: UIImageView!
    @IBOutlet weak var UIImageView_im:UIImageView!
    
    @IBOutlet weak var UILabel_Words: UILabel!
    
    
    override func awakeFromNib() {
        //
        UIImageView_SenderIcon.layer.cornerRadius = 25
        UIImageView_SenderIcon.clipsToBounds = true
        //
        let a = UIBezierPath()
        
        a.lineWidth = 1
        a.move(to: CGPoint(x:20,y:0))
        a.addLine(to: CGPoint(x:5 ,y:7))
        a.addLine(to: CGPoint(x:20,y:14))
        a.close()
        
        let b = CAShapeLayer()
        b.lineWidth = 1
        b.path = a.cgPath
        
        UIImageView_Sanjiao.layer.mask = b
        //
        UIImageView_im.layer.cornerRadius = 5
        UIImageView_im.clipsToBounds = true
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
