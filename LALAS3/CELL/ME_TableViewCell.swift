//
//  ME_TableViewCell.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/10/7.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class ME_TableViewCell: UITableViewCell {
    
    @IBOutlet weak var UIButton_Main: UIButton!
    @IBOutlet weak var UIButton_Small: UIButton!
    
    @IBOutlet weak var UILabel_UP: UILabel!
    @IBOutlet weak var UILabel_Dwon: UILabel!
    
    @IBAction func UIButton_MC(_ sender: UIButton) {
        
    }
    
    @IBAction func UIButton_SC(_ sender: UIButton) {
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        UIButton_Main.layer.cornerRadius = 5
        UIButton_Main.clipsToBounds = true
        
        UIButton_Small.layer.cornerRadius = 3
        UIButton_Small.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
