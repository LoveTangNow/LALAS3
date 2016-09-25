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
    
    @IBOutlet weak var UIToolbar_M: UIToolbar!
    @IBOutlet weak var UITextField_M: UITextField!
    @IBOutlet weak var UIButton_1: UIButton!
    @IBOutlet weak var UIButton_2: UIButton!
    @IBOutlet weak var UIButton_3: UIButton!
    
    
    
    var imagelist = [UIImage?]()
    
    var image1 = UIImage()
    var imgaeNumber = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIScrollView_MM.backgroundColor = UIColor.black
        UIScrollView_MM.contentSize = CGSize(width:self.view.bounds.width * CGFloat( imgaeNumber),height: self.view.bounds.width)   //内容大小
        UIScrollView_MM.isPagingEnabled = true                 //是否支持分页
        UIScrollView_MM.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0) //内边距

        //navigationController?.setNavigationBarHidden(true, animated: false)
        UIPageControl_M.numberOfPages = imgaeNumber
        UIPageControl_M.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        for i in 0..<imgaeNumber {
            let imageView =  UIImageView(image:imagelist[i])
            imageView.frame = CGRect(x: self.view.bounds.width*CGFloat(i), y:(self.view.bounds.height / 2) - (imageView.frame.height / imageView.frame.width * self.view.bounds.width / 2) - 60, width: self.view.bounds.width, height: imageView.frame.height / imageView.frame.width * self.view.bounds.width)
            UIScrollView_MM.addSubview(imageView)
            
            UIScrollView_MM.delegate = self
        }
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = self.view.frame.width
        let offsetX = scrollView.contentOffset.x
        let index = (offsetX + width / 2) / width
        UIPageControl_M.currentPage = Int(index)
        print(UIPageControl_M.currentPage)
        if UIPageControl_M.currentPage == 0 {
            //⬅️滑是否管用
            navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        } else {
            navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        //Mybar.isHidden = true
        navigationController?.navigationBar.alpha = 1
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor.black
        
        UIToolbar_M.alpha = 1
        UIToolbar_M.barTintColor = UIColor.black
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Tabeeee(_ sender: AnyObject) {

        if navigationController?.navigationBar.alpha == 0 {
            navigationController?.navigationBar.alpha = 1
        } else {
             navigationController?.navigationBar.alpha = 0
        }
        
        if UIToolbar_M.alpha == 1 {
            UIToolbar_M.alpha = 0
        } else {
            UIToolbar_M.alpha = 1
        }
        
    }

}
