//
//  Select_TableViewCell.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/9/27.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//
//包含一个 UISegmentedControl 和一个 label 的 UITableViewCell 用户 性别的选择

import UIKit

class Select_TableViewCell: UITableViewCell {

    @IBOutlet weak var UILabel_M: UILabel!
    @IBOutlet weak var UISegmentedControl_M: UISegmentedControl!
    
    @IBAction func UISegmentedControl_Valuechanged(_ sender: AnyObject) {
        let a  = UISegmentedControl_M.titleForSegment(at: UISegmentedControl_M.selectedSegmentIndex)! as String
        
        print(a)
        UserDefaults.standard.set(a,forKey:"Sex")
        UserDefaults.standard.synchronize()
    }
    
    var NumberOfSegments = 0
    
    
    override func awakeFromNib() {
        
        NumberOfSegments = 1
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
