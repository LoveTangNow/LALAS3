//
//  ChatMe_TableViewCell.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/9/22.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//
//chat 界面 的TableViewCell 我方 在右侧

import UIKit

class ChatMe_TableViewCell: UITableViewCell {
    
    @IBOutlet weak var UIImageView_MyIcon: UIImageView!
    @IBOutlet weak var UIImageView_Sanjiao: UIImageView!
    @IBOutlet weak var UIImageView_im:UIImageView!

    
    @IBOutlet weak var UILabel_Words: UILabel!

    override func awakeFromNib() {
        
        //
        UIImageView_MyIcon.layer.cornerRadius = 25
        UIImageView_MyIcon.clipsToBounds = true
        UIImageView_MyIcon.backgroundColor = UIColor.gray
        //
        let a = UIBezierPath()
        
        a.lineWidth = 1
        a.move(to: CGPoint(x:0,y:0))
        a.addLine(to: CGPoint(x:15 ,y:7))
        a.addLine(to: CGPoint(x:0,y:14))
        a.close()
        
        let b = CAShapeLayer()
        b.lineWidth = 1
        b.path = a.cgPath
        
        UIImageView_Sanjiao.layer.mask = b
        //
        
        UIImageView_im.layer.cornerRadius = 5
        UIImageView_im.clipsToBounds = true
        UIImageView_im.backgroundColor = UIColor.green
        
        super.awakeFromNib()
        // Initialization code
        
        /*
         UIView.animate(withDuration: 1, usingSpringWithDamping:0.3,animations: {
         self.UITableView_Main.center.y += self.view.bounds.height
         self.UITableView_Main.center.y -= 50
         self.UITableView_Main.center.y += 50
         */
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
