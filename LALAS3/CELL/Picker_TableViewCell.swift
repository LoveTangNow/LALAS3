//
//  Picker_TableViewCell.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/9/25.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class Picker_TableViewCell: UITableViewCell ,UIPickerViewDataSource,UIPickerViewDelegate{
    
    @IBOutlet weak var UIPickerView_M: UIPickerView!
    
    var numberOfComponents = 1
    var numberOfRowsInComponent = [1]
    var titleForRow = [[""]]
    
    

    override func awakeFromNib() {
        UIPickerView_M.dataSource = self
        UIPickerView_M.delegate = self
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return numberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberOfRowsInComponent[component]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return titleForRow[component][row]
    }

}
