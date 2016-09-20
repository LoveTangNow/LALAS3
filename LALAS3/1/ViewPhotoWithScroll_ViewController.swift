//
//  ViewPhotoWithScroll_ViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 16/9/20.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
//

import UIKit

class ViewPhotoWithScroll_ViewController: UIViewController ,UIScrollViewDelegate{
    
    @IBOutlet weak var UIScrollView_MM: UIScrollView!
    @IBOutlet weak var UIPageControl_M: UIPageControl!
    
    var imagelist = [UIImage]()
    
    var image1 = UIImage()
    var imgaeNumber = Int()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ImageNumber = UserDefaults.standard.value(forKey: "ImageNumber") as! Int
        
       
        /*
         for i in 0..<ImageNumber {
            let a = UserDefaults.standard.value(forKey: "image" + String(i)) as! UIImage
            imagelist[i] = a
            print(a)
        }
        */
        
        UIScrollView_MM.backgroundColor = UIColor.gray
        UIScrollView_MM.contentSize = CGSize(width:self.view.bounds.width * CGFloat( imgaeNumber),height: self.view.bounds.width)   //内容大小
        UIScrollView_MM.isPagingEnabled = true                 //是否支持分页
        UIScrollView_MM.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0) //内边距

        //navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
        UIPageControl_M.numberOfPages = imgaeNumber
        //UIPageControl_M.backgroundColor = UIColor.gray
        
        for i in 0..<imgaeNumber {
            let imageView =  UIImageView(image:imagelist[i])
            imageView.frame = CGRect(x: self.view.bounds.width*CGFloat(i), y:(self.view.bounds.height / 2) - (imageView.frame.height / imageView.frame.width * self.view.bounds.width / 2) - 40, width: self.view.bounds.width, height: imageView.frame.height / imageView.frame.width * self.view.bounds.width)
            UIScrollView_MM.addSubview(imageView)
            
            UIScrollView_MM.delegate = self
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = self.view.frame.width
        let offsetX = scrollView.contentOffset.x
        let index = (offsetX + width / 2) / width
        //pc.currentPage = Int(index)
        print(index)
        UIPageControl_M.currentPage = Int(index)
        print("------------")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func Tabeeee(_ sender: AnyObject) {
        /**
        if navigationController?.isNavigationBarHidden == true {
            navigationController?.setNavigationBarHidden(false, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
        */
    }
    
    @IBAction func UIControl_Click(_ sender: AnyObject) {
        if navigationController?.isNavigationBarHidden == true {
            navigationController?.setNavigationBarHidden(false, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
        
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
