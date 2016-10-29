//
//  FanKui_ViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/18.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit
import Alamofire

class FanKui_ViewController: UIViewController {

    @IBOutlet weak var imaget: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func allll () -> UIImage {
        var im = UIImage()
        Alamofire.request(GotServers().GotImageTServer(ai: true) + "10.jpeg")
            .responseData { response in
                if let data = response.result.value {
                    let asd = UIImage(data: data)
                    im = asd!
                    print("al")
                }
        }
        return im
    }
    
}
