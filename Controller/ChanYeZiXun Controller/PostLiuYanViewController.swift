//
//  PostLiuYanViewController.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/5/2.
//  Copyright © 2018年 OS. All rights reserved.
//

import UIKit
import Alamofire
class PostLiuYanViewController: UIViewController,UITextViewDelegate {
    
    let MessageFrame=UITextView()
    let PostButton=UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ScreenRect=UIScreen.main.bounds
        let ScreenWidth=ScreenRect.size.width
        let ScreenHeight=ScreenRect.size.height
        MessageFrame.frame=CGRect(x:1/6*ScreenWidth,y:1.5/6*ScreenWidth,width:ScreenWidth/3*2,height:ScreenHeight/3*1.3)
        
        MessageFrame.layer.borderWidth=5
        MessageFrame.layer.borderColor=UIColor.black.cgColor
        MessageFrame.returnKeyType=UIReturnKeyType.done
        MessageFrame.backgroundColor=UIColor.lightGray
        MessageFrame.font = UIFont(name: "GillSans", size: 30.0)
        MessageFrame.delegate=self
        
        PostButton.frame=CGRect(x:ScreenWidth*0.39,y:ScreenHeight/4*2.6,width:ScreenWidth*0.22,height:ScreenHeight/25*2.2)
        
        PostButton.backgroundColor = UIColor.green
        PostButton.setTitle("发送",for:UIControlState.normal)
        PostButton.layer.cornerRadius = 10
        PostButton.layer.masksToBounds = true
        
        PostButton.titleLabel?.font=UIFont.boldSystemFont(ofSize: ScreenWidth*0.22*0.5)
        PostButton.titleLabel?.font=UIFont.boldSystemFont(ofSize: 20)
        PostButton.layer.borderWidth = 3
        PostButton.layer.borderColor = UIColor.black.cgColor
        
        PostButton.addTarget(self, action: #selector(submit), for: UIControlEvents.touchUpInside)
        self.view.backgroundColor=UIColor.white
        self.view.addSubview(MessageFrame)
        self.view.addSubview(PostButton)
        // Do any additional setup after loading the view.
    }
    
    @objc func submit(){
        if(UserModel.instance.UserLoaded==false){
            self.alert("请登录后评论")
            return
        }
        
        let IDWillPost:String=LiuYanMessageModel.instance.newsID
        let userEmail:String=UserModel.instance.UserEmail
        let IDAndEmailPost=IDWillPost + "&" + userEmail
        print(IDAndEmailPost)
        print("注意名字")
        if(MessageFrame.text==""||MessageFrame.text==nil){
            self.alert("留言不能为空！")
            return
        }else
        {
            let message=MessageFrame.text!
            PostLiuYanClient.instance.requestForPostLiuYan(IDAndEmailPost, postLY: message).responseJSON {
                
                json -> Void in
                let d = json.result.value as? NSDictionary
                if d == nil {
                    self.alert("留言失败")
                    return
                }
                switch d!["state"] as! String {
                case "SUCCESS":
                    print("成功")
                    //LiuYanMessageModel.instance.LiuYanNumber+=1
                    //LiuYanMessageModel.instance.userCatalog.append(UserModel.instance.UserName)
                    //LiuYanMessageModel.instance.messageCatalog.append(message)
                    let alertController = UIAlertController(title: "留言成功！",
                                                            message: "感谢您的评论！", preferredStyle: .alert)
                    //显示提示框
                    self.present(alertController, animated: true, completion: nil)
                    //两秒钟后自动消失
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                        sleep(2)
                        alertController.dismiss(animated: true, completion: nil)
                    }
                    
                case "FAIL":
                    self.alert("失败")
                default:
                    print("t3")
                    break
                }
            }
        }
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
