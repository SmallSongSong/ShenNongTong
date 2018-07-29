//
//  ViewController.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/3/14.
//  Copyright © 2018年 OS. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        if(UserModel.instance.UserLoaded==false){
            self.navigationItem.rightBarButtonItem=UIBarButtonItem(title:"用户登录",style:UIBarButtonItemStyle.plain,target:self,action:
                #selector(JumpToLoad))
        }else{
            self.navigationItem.rightBarButtonItem=UIBarButtonItem(title:"我的信息",style:UIBarButtonItemStyle.plain,target:self,action:#selector(JumpToMyInfo))
        }
    }
    override func viewDidLoad() {
        
        
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(title:"设置",style:UIBarButtonItemStyle.plain,target:self,action: #selector(JumpToSet))
        if(UserModel.instance.UserLoaded==false){
            self.navigationItem.rightBarButtonItem=UIBarButtonItem(title:"用户登录",style:UIBarButtonItemStyle.plain,target:self,action:
                #selector(JumpToLoad))
        }else{
            self.navigationItem.rightBarButtonItem=UIBarButtonItem(title:"我的信息",style:UIBarButtonItemStyle.plain,target:self,action:#selector(JumpToMyInfo))
        }
        
        self.view.backgroundColor=UIColor.white
        // Do any additional setup after loading the view, typically from a nib.
        let ScreenRect=UIScreen.main.bounds
        let ScreenWidth=ScreenRect.size.width
        let ScreenHeight=ScreenRect.size.height
        
        let bt1=UIButton()
        let bt2=UIButton()
        let bt3=UIButton()
        let bt4=UIButton()
        let bt5=UIButton()
        let bt6=UIButton()
        
        let lb1=UILabel()
        let lb2=UILabel()
        let lb3=UILabel()
        let lb4=UILabel()
        let lb5=UILabel()
        let lb6=UILabel()
        
        
        
        bt1.frame=CGRect(x:ScreenWidth/20*1.4,y:ScreenHeight/25*3,width:ScreenHeight/25*5,height:ScreenHeight/25*5)
        lb1.frame=CGRect(x:ScreenWidth/8,y:ScreenHeight/25*8.3,width:ScreenHeight/25*3.6,height:ScreenHeight/25)
        
        bt2.frame=CGRect(x:ScreenWidth/20*11,y:ScreenHeight/25*3,width:ScreenHeight/25*5,height:ScreenHeight/25*5)
        lb2.frame=CGRect(x:ScreenWidth/20*12,y:ScreenHeight/25*8.3,width:ScreenHeight/25*3.6,height:ScreenHeight/25)
        
        
        bt3.frame=CGRect(x:ScreenWidth/20*1.4,y:ScreenHeight/25*9.6,width:ScreenHeight/25*5,height:ScreenHeight/25*5)
        lb3.frame=CGRect(x:ScreenWidth/8,y:ScreenHeight/25*14.8,width:ScreenHeight/25*3.6,height:ScreenHeight/25)
        
        bt4.frame=CGRect(x:ScreenWidth/20*11,y:ScreenHeight/25*9.6,width:ScreenHeight/25*5,height:ScreenHeight/25*5)
        lb4.frame=CGRect(x:ScreenWidth/20*12,y:ScreenHeight/25*14.8,width:ScreenHeight/25*3.6,height:ScreenHeight/25)
        
        bt5.frame=CGRect(x:ScreenWidth/20*1.4,y:ScreenHeight/25*16,width:ScreenHeight/25*5,height:ScreenHeight/25*5)
        lb5.frame=CGRect(x:ScreenWidth/8,y:ScreenHeight/25*21.2,width:ScreenHeight/25*3.6,height:ScreenHeight/25)
        
        bt6.frame=CGRect(x:ScreenWidth/20*11,y:ScreenHeight/25*16,width:ScreenHeight/25*5,height:ScreenHeight/25*5)
        lb6.frame=CGRect(x:ScreenWidth/20*12,y:ScreenHeight/25*21.2,width:ScreenHeight/25*3.6,height:ScreenHeight/25)
        
        
        bt1.layer.cornerRadius=ScreenHeight/25*2.5
        bt1.layer.masksToBounds=true
        bt1.setBackgroundImage(UIImage(named:"新闻按钮"),for:.normal)
        bt1.addTarget(self, action: #selector(pushPage1), for: UIControlEvents.touchUpInside)
        
        lb1.text="产业资讯"
        lb1.textAlignment=NSTextAlignment.center
        
        
        bt2.layer.cornerRadius=ScreenHeight/25*2.5
        bt2.layer.masksToBounds=true
        bt2.setBackgroundImage(UIImage(named:"价格按钮"),for:.normal)
        bt2.addTarget(self, action: #selector(pushPage2), for: UIControlEvents.touchUpInside)
        
        lb2.text="市场行情"
        lb2.textAlignment=NSTextAlignment.center
        
        bt3.layer.cornerRadius=ScreenHeight/25*2.5
        bt3.layer.masksToBounds=true
        bt3.setBackgroundImage(UIImage(named:"地点按钮"),for:.normal)
        bt3.addTarget(self, action: #selector(pushPage3), for: UIControlEvents.touchUpInside)
        
        lb3.text="农业示范站"
        lb3.textAlignment=NSTextAlignment.center
        
        bt4.layer.cornerRadius=ScreenHeight/25*2.5
        bt4.layer.masksToBounds=true
        bt4.setBackgroundImage(UIImage(named:"农技服务按钮"),for:.normal)
        bt4.addTarget(self, action: #selector(pushPage4), for: UIControlEvents.touchUpInside)
        
        lb4.text="农技服务"
        lb4.textAlignment=NSTextAlignment.center
        
        bt5.layer.cornerRadius=ScreenHeight/25*2.5
        bt5.layer.masksToBounds=true
        bt5.setBackgroundImage(UIImage(named:"视频按钮"),for:.normal)
        bt5.addTarget(self, action: #selector(pushPage5), for: UIControlEvents.touchUpInside)
        
        lb5.text="专家解答"
        lb5.textAlignment=NSTextAlignment.center
        
        bt6.layer.cornerRadius=ScreenHeight/25*2.5
        bt6.layer.masksToBounds=true
        bt6.setBackgroundImage(UIImage(named:"聊天按钮"),for:.normal)
        bt6.addTarget(self, action: #selector(pushPage6), for: UIControlEvents.touchUpInside)
        lb6.text="智能客服"
        lb6.textAlignment=NSTextAlignment.center
        
        
        self.view.addSubview(bt1)
        self.view.addSubview(bt2)
        self.view.addSubview(bt3)
        self.view.addSubview(bt4)
        self.view.addSubview(bt5)
        self.view.addSubview(bt6)
        self.view.addSubview(lb1)
        self.view.addSubview(lb2)
        self.view.addSubview(lb3)
        self.view.addSubview(lb4)
        self.view.addSubview(lb5)
        self.view.addSubview(lb6)
        let reSize = CGSize(width: ScreenWidth, height: ScreenHeight)
        self.view.backgroundColor=UIColor.init(patternImage:UIImage(named: "主页背景.png")!.reSizeImage(reSize: reSize))
        super.viewDidLoad()
    }
    
    @objc func pushPage1(_ button:UIButton){
        if(JudgeNetWork()){
            let sendSignal:Int=1
            newsClient.instance.requestForNews(sendSignal, type: 0).responseJSON {
                json -> Void in
                let d = json.result.value as? NSDictionary
                if d == nil {
                    self.alert("网络连接失败!")
                    return
                }
                switch d!["state"] as! String  {
                case "SUCCESS":
                    let URLS = d! ["URL"]as! Array<String>
                    let Titles = d! ["Title"]as! Array<String>
                    let Details = d! ["Detail"]as! Array<String>
                    let picturesURL = d! ["pictureURL"]as! Array<String>
                    
                    //新增评论数量获取和id获取
                    let discussnumber = d! ["discussnumber"]as! Array<Int>
                    let newsID=d! ["newsID"]as! Array<String>
                    
                    NewsModel.instance.NewsImageNames=picturesURL
                    NewsModel.instance.NewsTitles=Titles
                    NewsModel.instance.NewsDetails=Details
                    NewsModel.instance.urllists=URLS
                    
                    NewsModel.instance.DiscussNumber=discussnumber
                    NewsModel.instance.newsID = newsID
                    self.pushChanyePage()
                case "FAIL":
                    self.alert("失败")
                default:
                    break
                }
            }
        }
        
        
    }
    @objc func pushPage2(_ button:UIButton){
        pushPricePage()
    }
    
    @objc func pushPage3(_ button:UIButton){
        let page3 = PositionViewController()
        self.navigationController?.pushViewController(page3, animated: true)
    }
    
    @objc func pushPage4(_ button:UIButton){
        if(JudgeNetWork()){
            pushChanPinPage()
        }
    }
    
    @objc func pushPage5(_ button:UIButton){
        if(UserModel.instance.UserLoaded==true){
            //视频直播间界面
            //let page5 = ProViewController()
            //self.navigationController?.pushViewController(page5, animated: true)
        }else{
            self.alert("请先登录！")
        }
    }
    
    @objc func pushPage6(_ button:UIButton){
        //MessageModel.instance.myInit()
        let page6 = SmartChatViewController()
        self.navigationController?.pushViewController(page6, animated: true)
    }
    
    @objc func JumpToSet(){
        let settingPage = SettingViewController()
        self.navigationController?.pushViewController(settingPage, animated: true)
    }
    
    @objc func JumpToLoad(){
        let loadPage = ProViewController()
        self.navigationController?.pushViewController(loadPage, animated: true)
    }
    @objc func JumpToMyInfo(){
        let MyInfoPage = UserDetailViewController()
        self.navigationController?.pushViewController(MyInfoPage, animated: true)
    }
    
    func pushChanyePage(){
        let page1 = ChanYeZiXunViewController()
        self.navigationController?.pushViewController(page1, animated: true)
    }
    
    func pushChanPinPage(){
        ServiceKinds.instance.myInit()
        let page4 = ChanPinFuWuViewController()
        self.navigationController?.pushViewController(page4, animated: true)
    }
    func pushPricePage(){
        PAK.instance.MyInit()
        let page2 = PriceViewController()
        self.navigationController?.pushViewController(page2, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

