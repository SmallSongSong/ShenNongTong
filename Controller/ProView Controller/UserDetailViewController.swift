//
//  UserDetailViewController.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/7/3.
//  Copyright © 2018年 OS. All rights reserved.
//

import Foundation
import UIKit

class UserDetailViewController:UIViewController{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    let namelb=UILabel()
    let Emaillb=UILabel()
    let Identify=UILabel()
    
    override func viewDidLoad() {
        self.title="我的信息"
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(title:"返回主界面",style:UIBarButtonItemStyle.plain,target:self,action: #selector(returnToHomePage))
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(title:"退出登录",style:UIBarButtonItemStyle.plain,target:self,action:#selector(LogOut))
        let ScreenRect=UIScreen.main.bounds
        let ScreenWidth=ScreenRect.size.width
        let ScreenHeight=ScreenRect.size.height
        
        namelb.frame=CGRect(x:ScreenWidth/6,y:ScreenHeight/6,width:ScreenWidth/3*2,height:ScreenHeight/6*0.8)
        Emaillb.frame=CGRect(x:ScreenWidth/6,y:ScreenHeight/6*1.9,width:ScreenWidth/3*2,height:ScreenHeight/6*0.8)
        Identify.frame=CGRect(x:ScreenWidth/6,y:ScreenHeight/6*2.8,width:ScreenWidth/3*2,height:ScreenHeight/6*0.8)
        
        //let UserEmail=UserModel.instance.UserEmail
        
        namelb.text="我的昵称：  \(UserModel.instance.UserName)"
        namelb.textAlignment=NSTextAlignment.left
        
        Emaillb.text="我的邮箱：  \(UserModel.instance.UserEmail)"
        Emaillb.textAlignment=NSTextAlignment.left
        
        let IDSignal=UserModel.instance.UserIdentify
        var ID:String=""
        if(IDSignal==2){
            ID="专家"
        }else{
            ID="农民"
        }
        
        Identify.text="我的身份:  \(ID)"
        Identify.textAlignment=NSTextAlignment.left
        
        self.view.addSubview(namelb)
        self.view.addSubview(Emaillb)
        self.view.addSubview(Identify)
        self.view.backgroundColor=UIColor.white
    }
    
    @objc func returnToHomePage()
    {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func LogOut(){
        UserModel.instance.UserLoaded=false
        LogOutClient.instance.requestForLogOut(UserModel.instance.UserEmail)
        let alertController = UIAlertController(title: "已登出",
                                                message: "账号已登出！", preferredStyle: .alert)
        //显示提示框
        self.present(alertController, animated: true, completion: nil)
        //两秒钟后自动消失
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            sleep(2)
            alertController.dismiss(animated: true, completion: nil)
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
