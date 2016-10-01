//
//  CommentsPraiseDemote_NTableViewCell.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/9/24.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class CommentsPraiseDemote_NTableViewCell: UITableViewCell {
    
    var number = [0,0,0]
    
    var did = [false,false,false]
    
    @IBOutlet weak var UIButton1: UIButton!
    @IBOutlet weak var UIButton2: UIButton!
    @IBOutlet weak var UIButton3: UIButton!
    
    @IBAction func UIButton1c(_ sender: AnyObject) {
        if did[0] == false {
            number[0] += 1
            UIButton1.setTitle("⚓️" + String(number[0]), for: .normal)
            did[0] = true
        } else {
            number[0] -= 1
            UIButton1.setTitle("⚓️" + String(number[0]), for: .normal)
            did[0] = false
        }
    }
    
    @IBAction func UIButton2c(_ sender: AnyObject) {
        if did[1] == false {
            number[1] += 1
            UIButton2.setTitle("💭" + String(number[1]), for: .normal)
            did[1] = true
        } else {
            number[1] -= 1
            UIButton2.setTitle("💭" + String(number[1]), for: .normal)
            did[1] = false
        }
    }
    
    @IBAction func UIButton3c(_ sender: AnyObject) {
        if did[2] == false {
            number[2] += 1
            UIButton3.setTitle("👍" + String(number[2]), for: .normal)
            did[2] = true
        } else {
            number[2] -= 1
            UIButton3.setTitle("👍🏿" + String(number[2]), for: .normal)
            did[2] = false
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func UpDateUI() {
        UIButton1.setTitle("⚓️" + String(number[0]), for: .normal)
        UIButton2.setTitle("💭" + String(number[1]), for: .normal)
        UIButton3.setTitle("👍🏿" + String(number[2]), for: .normal)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
