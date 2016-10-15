//
//  Advertisement_TableViewCell.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/9/22.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//


//单一图片 填充满的TableViewCell 用户广告的展示？

import UIKit

class Advertisement_TableViewCell: UITableViewCell {

    @IBOutlet weak var imgae_main: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgae_main.imageView?.contentMode = .topLeft
        imgae_main.backgroundColor = UIColor.purple
        //imgae_main.setTitle("", for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
