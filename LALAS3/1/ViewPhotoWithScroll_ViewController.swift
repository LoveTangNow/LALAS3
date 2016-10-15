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
    var imgaeNumber = Int()
    var aa  = CGRect()
    var image_Dijizhang = 1
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(image_Dijizhang)
        self.view.backgroundColor = UIColor.black

        UIScrollView_MM.backgroundColor = UIColor.black
        UIScrollView_MM.contentSize = CGSize(width:self.view.bounds.width * CGFloat( imgaeNumber),height: self.view.bounds.width)   //内容大小
        UIScrollView_MM.isPagingEnabled = true                 //是否支持分页
        UIScrollView_MM.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0) //内边距

        //navigationController?.setNavigationBarHidden(true, animated: false)
        UIPageControl_M.numberOfPages = imgaeNumber
        UIPageControl_M.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        navigationController?.navigationBar.isHidden = true
        UIToolbar_M.isHidden = true
        
        UIToolbar_M.alpha = 0
        
        for i in 0..<imgaeNumber {
            let imageView =  UIImageView(image:imagelist[i])
            imageView.frame = CGRect(x: self.view.bounds.width * CGFloat(i), y:(self.view.bounds.height / 2) - (imageView.frame.height / imageView.frame.width * self.view.bounds.width / 2) - 20, width: self.view.bounds.width, height: imageView.frame.height / imageView.frame.width * self.view.bounds.width)
            UIScrollView_MM.addSubview(imageView)
            UIScrollView_MM.delegate = self
            aa  = imageView.frame
        }
        
        print("photoload")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        //Mybar.isHidden = true
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor.black
        
        UIToolbar_M.barTintColor = UIColor.black
        UIScrollView_MM.isHidden = true
        
        print("photowillapear")
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        for _ in 0..<(image_Dijizhang - 1) {
            print("do")
            UIScrollView_MM.scrollRectToVisible(aa, animated: false)
        }
        UIScrollView_MM.isHidden = false

        print("photodidappear")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = self.view.frame.width
        let offsetX = scrollView.contentOffset.x
        let index = (offsetX + width / 2) / width
        UIPageControl_M.currentPage = Int(index)
        //print(UIPageControl_M.currentPage)
        if UIPageControl_M.currentPage == 0 {
            //⬅️滑是否管用
            navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        } else {
            navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Tabeeee(_ sender: AnyObject) {

        if navigationController?.navigationBar.isHidden == true {
            navigationController?.navigationBar.isHidden = false
            UIToolbar_M.isHidden = false
        } else {
            navigationController?.navigationBar.isHidden = true
            UIToolbar_M.isHidden = true
        }
    }
}
