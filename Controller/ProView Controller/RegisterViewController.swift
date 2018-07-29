//
//  RegisterViewController.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/4/24.
//  Copyright © 2018年 OS. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegisterViewController: UIViewController,UITextFieldDelegate  {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    let namelb=UITextField()
    let maillb=UITextField()
    let passwordlb=UITextField()
    let repeatpasswordlb=UITextField()
    let SureButton=UIButton()
    
    
    override func viewDidLoad() {
        self.title="注册页面"
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(title:"返回登录",style:UIBarButtonItemStyle.plain,target:self,action: #selector(returnToHomePage))
        
        let ScreenRect=UIScreen.main.bounds
        let ScreenWidth=ScreenRect.size.width
        let ScreenHeight=ScreenRect.size.height
        
        namelb.frame=CGRect(x:ScreenWidth/14*3.2,y:ScreenHeight/4*1.0,width:ScreenWidth/14*7.6,height:ScreenHeight/25*1.8)
        
        
        maillb.frame=CGRect(x:ScreenWidth/14*3.2,y:ScreenHeight/4*1.4,width:ScreenWidth/14*7.6,height:ScreenHeight/25*1.8)
        
        passwordlb.frame=CGRect(x:ScreenWidth/14*3.2,y:ScreenHeight/4*1.8,width:ScreenWidth/14*7.6,height:ScreenHeight/25*1.8)
        
        repeatpasswordlb.frame=CGRect(x:ScreenWidth/14*3.2,y:ScreenHeight/4*2.2,width:ScreenWidth/14*7.6,height:ScreenHeight/25*1.8)
        
        SureButton.frame=CGRect(x:ScreenWidth*0.39,y:ScreenHeight/4*2.8,width:ScreenWidth*0.22,height:ScreenHeight/25*2.2)
        
        namelb.borderStyle=UITextBorderStyle.roundedRect
        namelb.placeholder="请输入注册用户名"
        namelb.returnKeyType=UIReturnKeyType.done
        namelb.autocorrectionType=UITextAutocorrectionType.no
        namelb.clearButtonMode=UITextFieldViewMode.whileEditing
        namelb.keyboardType=UIKeyboardType.emailAddress
        namelb.delegate=self
        
        maillb.borderStyle=UITextBorderStyle.roundedRect
        maillb.placeholder="请输入注册邮箱"
        maillb.returnKeyType=UIReturnKeyType.done
        maillb.autocorrectionType=UITextAutocorrectionType.no
        maillb.clearButtonMode=UITextFieldViewMode.whileEditing
        maillb.keyboardType=UIKeyboardType.emailAddress
        maillb.delegate=self
        
        passwordlb.borderStyle=UITextBorderStyle.roundedRect
        passwordlb.placeholder="请输入注册密码"
        passwordlb.returnKeyType=UIReturnKeyType.done
        passwordlb.autocorrectionType=UITextAutocorrectionType.no
        passwordlb.clearButtonMode=UITextFieldViewMode.whileEditing
        passwordlb.keyboardType=UIKeyboardType.alphabet//密码只允许输入ascII码
        passwordlb.isSecureTextEntry=true
        passwordlb.delegate=self
        
        repeatpasswordlb.borderStyle=UITextBorderStyle.roundedRect
        repeatpasswordlb.placeholder="确认注册密码"
        repeatpasswordlb.returnKeyType=UIReturnKeyType.done
        repeatpasswordlb.autocorrectionType=UITextAutocorrectionType.no
        repeatpasswordlb.clearButtonMode=UITextFieldViewMode.whileEditing
        repeatpasswordlb.keyboardType=UIKeyboardType.alphabet//密码只允许输入ascII码
        repeatpasswordlb.isSecureTextEntry=true
        repeatpasswordlb.delegate=self
        
        SureButton.backgroundColor = UIColor.green
        SureButton.setTitle("确认",for:UIControlState.normal)
        SureButton.layer.cornerRadius = 10
        SureButton.layer.masksToBounds = true
        //SureButton.titleLabel?.adjustsFontSizeToFitWidth=true
        SureButton.titleLabel?.font=UIFont.boldSystemFont(ofSize: ScreenWidth*0.22*0.5)
        SureButton.titleLabel?.font=UIFont.boldSystemFont(ofSize: 20)
        
        SureButton.addTarget(self, action: #selector(Register), for: UIControlEvents.touchUpInside)
        
        self.view.backgroundColor=UIColor.white
        self.view.addSubview(namelb)
        self.view.addSubview(maillb)
        self.view.addSubview(passwordlb)
        self.view.addSubview(repeatpasswordlb)
        self.view.addSubview(SureButton)
        
        let reSize = CGSize(width: ScreenWidth, height: ScreenHeight)
        self.view.backgroundColor=UIColor.init(patternImage:UIImage(named: "主页背景.png")!.reSizeImage(reSize: reSize))
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func returnToHomePage()
    {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func Register(){
        if(namelb.text! == ""){
            print("空名字")
            self.alert("用户名不能为空！")
            return
        }else if(maillb.text! == ""){
            self.alert("邮箱地址不能为空！")
            return
        }else if(passwordlb.text! == ""){
            self.alert("密码不能为空！")
            return
        }
        else if(repeatpasswordlb.text! == ""){
            self.alert("请确认密码")
            return
        }
        else if(repeatpasswordlb.text! != passwordlb.text!){
            self.alert("两次输入密码不一致！")
            return
        }else{
            
            let mailAndPD=maillb.text!+"&"+passwordlb.text!
            
            registerClient.instance.requestForRegister(namelb.text!, MailAndPD:mailAndPD).validate().responseJSON{
                json-> Void in
                let d = json.result.value as? NSDictionary
                if(!self.JudgeNetWork()){
                    self.NoNetWorkAlet()
                }else if (d == nil)
                {
                    self.alert("服务器信息错误")
                }else
                {
                    switch d!["state"] as! String{
                        
                    case "EmailNotFind":
                        self.alert("邮箱格式不正确！")
                    case "EmailHasIn":
                        self.alert("邮箱已被注册！")
                    case "SUCCESS":
                        let alertController = UIAlertController(title: "邮件已发送",
                                                                message: "请在注册邮箱中点击注册链接，4秒后跳转至登录界面", preferredStyle: .alert)
                        //显示提示框
                        self.present(alertController, animated: true, completion: nil)
                        //两秒钟后自动消失
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                            self.presentedViewController?.dismiss(animated: false, completion: nil)
                            sleep(2)
                            self.navigationController?.popViewController(animated: true)
                        }
                    default:
                        self.alert("未知的错误")
                    }
                }
            }
        }
    }
    
    //原来的注册码本地验证程序块儿
    /* func showAndGetRegisterCode(_ Code:String){
     let alertController = UIAlertController(title: "验证",
     message: "请输入邮箱验证吗", preferredStyle: .alert)
     alertController.addTextField {
     (textField: UITextField!) -> Void in
     textField.placeholder = "邮箱验证码"
     }
     
     let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
     let okAction = UIAlertAction(title: "确认", style: .default, handler: {
     action in
     //也可以用下标的形式获取textField let login = alertController.textFields![0]
     let reCode = alertController.textFields!.first!
     if(Code != reCode.text!){
     self.alert("验证码错误！")
     }else if(reCode.text == Code){
     let alertController = UIAlertController(title: "注册成功!,即将跳转至登录界面",
     message: nil, preferredStyle: .alert)
     //显示提示框
     self.present(alertController, animated: true, completion: nil)
     //两秒钟后自动消失
     DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
     self.presentedViewController?.dismiss(animated: false, completion: nil)
     sleep(1000)
     self.navigationController?.popViewController(animated: true)
     }
     }
     
     }
     )
     alertController.addAction(cancelAction)
     alertController.addAction(okAction)
     self.present(alertController, animated: true, completion: nil)
     }*/
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
