/**
//  Chat_ViewController.swift
//  LALAS3
//
//  Created by Thomas Liu on 2016/10/3.
//  Copyright © 2016年 ThomasLiu. All rights reserved.
*/

import UIKit

class Chat_ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate{
    //MARK: - 变量
    var tableViewHeight:CGFloat = 100
    let deviceWidth  = UIScreen.main.bounds.width
    let deviceHeight  = UIScreen.main.bounds.height
    
    var Informations = chatmodel()
    
    //MARK: - 绑定
    
    @IBOutlet weak var UITextView_Word: UITextView!
    @IBOutlet weak var UIButton_Voice: UIButton!
    @IBOutlet weak var UIButton_emoji: UIButton!
    @IBOutlet weak var UIButton_others: UIButton!
    
    @IBOutlet var UIView_Bottom: UIView!
    @IBOutlet weak var UITableView_M: UITableView!
    
    @IBOutlet var UIView_Bottom2: UIView!
    @IBOutlet weak var UICollectionView_: UICollectionView!
    
    @IBAction func Others_Action(_ sender: AnyObject) {
    }
    @IBAction func Emoji_Action(_ sender: AnyObject) {
    }
    @IBAction func Voice_Action(_ sender: AnyObject) {
    }
    
    //MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITableView_M.delegate = self
        UITableView_M.dataSource = self
        
        UITextView_Word.delegate = self

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        print(deviceWidth)
        print(deviceHeight)

        self.title = "chat"
        ConnectNib()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView_Bottom.frame = CGRect(x:0,y:deviceHeight,width:deviceWidth,height:40)
        UIView_Bottom2.frame = CGRect(x:0,y:deviceHeight,width:deviceWidth,height:100)
        UIView_Bottom.backgroundColor = UIColor.lightGray
        
        self.view.addSubview(UIView_Bottom)
        //self.view.addSubview(UIView_Bottom2)
        UITextView_Word.returnKeyType = UIReturnKeyType.go
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            self.UIView_Bottom.center.y -= 40
        })
        
        //UITableView_M.isHidden = true
    }
    
    func keyBoardWillShow(note:NSNotification)
    {
        let userInfo:NSDictionary = note.userInfo! as NSDictionary;
        let keyBoardInfo: AnyObject? = userInfo.object(forKey: UIKeyboardFrameBeginUserInfoKey) as AnyObject?;
        let beginY = keyBoardInfo?.cgRectValue.origin.y;
        let keyBoardInfo2: AnyObject? = userInfo.object(forKey: UIKeyboardFrameEndUserInfoKey) as AnyObject?;
        let endY = keyBoardInfo2?.cgRectValue.origin.y;
        //let aTime = userInfo.object(forKey: UIKeyboardAnimationDurationUserInfoKey) as! TimeInterval
        //5
        let deltaY = beginY! - endY!
        //print(aTime)//0.25
        print("show")
        UIView.animate(withDuration: 0, animations: {
            self.UIView_Bottom.center.y -= deltaY
        })
    }
    
    func keyBoardWillHide(note:NSNotification) {
        let userInfo:NSDictionary = note.userInfo! as NSDictionary;
        let keyBoardInfo: AnyObject? = userInfo.object(forKey: UIKeyboardFrameBeginUserInfoKey) as AnyObject?;
        let beginY = keyBoardInfo?.cgRectValue.origin.y;
        let keyBoardInfo2: AnyObject? = userInfo.object(forKey: UIKeyboardFrameEndUserInfoKey) as AnyObject?;
        let endY = keyBoardInfo2?.cgRectValue.origin.y;
        let deltaY = beginY! - endY!
        UIView.animate(withDuration: 0, animations: {
            self.UIView_Bottom.center.y -= deltaY
        })
        print("hide")
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - TextView
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("DidBeginEditing")
        //开始编辑
    }
    
    func textViewDidChange(_ textView: UITextView) {
        print("DidChang")
        //文字改变2
        //let size = UITextView_Word.font?.pointSize
        //print(size)
        //let chnumber = UITextView_Word.text.characters.count
        //print(chnumber)
        
        /**
        CGSize size = [m_textView.text sizeWithFont:[m_textView font]];
        int length = size.height;
        int colomNumber = m_textView.contentSize.height/length;*/
        
        let a = UITextView_Word.text!
        var c = Character(" ")
        
        switch a.characters.count {
        case 0:
            c = Character(" ")
        case 1:
            c = a[a.startIndex]
        default:
            c = a[a.index(before: a.endIndex)]
        }
        
        let n:Character = "\n"
        print(c)
        if c == n {
            print("会车来了")
            //最后一个是回车 时候 go
            //UITableView_M.insertRows(at:[aaa], with: UITableViewRowAnimation.bottom)
        } else {
            
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("idEndEditing")
        //编辑结束
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        //文字改变1  选取改变
        print("didChangeSelection")
    }
    
    //MARK: - ChatView
    
    
    //MARK: - TableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatYou_TableViewCell") as! ChatYou_TableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatMe_TableViewCell") as! ChatMe_TableViewCell
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UITextView_Word.resignFirstResponder()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    //MARK: - CollectionView

    
    func ConnectNib ()  {
        UITableView_M.register(UINib(nibName: "ChatYou_TableViewCell", bundle: nil), forCellReuseIdentifier: "ChatYou_TableViewCell")
        UITableView_M.register(UINib(nibName: "ChatMe_TableViewCell", bundle: nil), forCellReuseIdentifier: "ChatMe_TableViewCell")
    }
}
