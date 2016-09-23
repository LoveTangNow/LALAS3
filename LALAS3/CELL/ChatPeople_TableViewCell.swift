//
//  ChatPeople_TableViewCell.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/9/22.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class ChatPeople_TableViewCell: UITableViewCell {
    
    @IBOutlet weak var UIImageView_Main: UIImageView!
    @IBOutlet weak var UIImageView_Zhiding: UIImageView!
    @IBOutlet weak var UIImageView_Readornot: UIImageView!
    
    @IBOutlet weak var UILabel_Name: UILabel!
    @IBOutlet weak var UILabel_Words: UILabel!
    

    override func awakeFromNib() {
        //print(self.frame.height)
        
        
        UIImageView_Main.layer.cornerRadius = (self.frame.height - 10) / 8
        UIImageView_Main.clipsToBounds = true
        
        UIImageView_Zhiding.layer.cornerRadius = 3
        UIImageView_Zhiding.clipsToBounds = true
        
        UIImageView_Readornot.layer.cornerRadius = 5
        UIImageView_Readornot.clipsToBounds = true
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
