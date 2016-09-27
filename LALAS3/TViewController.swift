//
//  TViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/9/27.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class TViewController: UIViewController {
    @IBOutlet weak var UIImageView_b: UIImageView!
    let width_d  = UIScreen.main.bounds.width

    @IBAction func button_c(_ sender: AnyObject) {
        let A = self.UIImageView_b.frame.height / self.UIImageView_b.frame.width
        UIView.animate(
            withDuration: 0.3,
            delay: 0.0,
            usingSpringWithDamping: 0.55,
            initialSpringVelocity: 5.0,
            options: UIViewAnimationOptions.curveEaseIn,
            animations: {
                self.UIImageView_b.frame =  CGRect(x:0,y:0,width:self.width_d,height:self.width_d * A)
            })
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
