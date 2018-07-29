//
//  ProViewController.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/3/15.
//  Copyright © 2018年 OS. All rights reserved.
//

import UIKit

//var NameRequestFlag=0
//var UserName:String=""
class ProViewController: UIViewController,UITextFieldDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    let titlelb=UILabel()
    let namelb=UITextField()
    let passwordlb=UITextField()
    let SureButton=UIButton()
    let RememberLabel=UILabel()
    let RememberSwitch=UISwitch()
    let RegisterButton=UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title="请登录"
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(title:"返回",style:UIBarButtonItemStyle.plain,target:self,action: #selector(returnToHomePage))
        
        let ScreenRect=UIScreen.main.bounds
        let ScreenWidth=ScreenRect.size.width
        let ScreenHeight=ScreenRect.size.height
        
        
        
        titlelb.frame=CGRect(x:ScreenWidth/8,y:ScreenHeight/6,width:ScreenWidth/8*6,height:ScreenHeight/25*3.4)
        
        namelb.frame=CGRect(x:ScreenWidth/14*3.2,y:ScreenHeight/4*1.2,width:ScreenWidth/14*7.6,height:ScreenHeight/25*1.8)
        
        passwordlb.frame=CGRect(x:ScreenWidth/14*3.2,y:ScreenHeight/4*1.6,width:ScreenWidth/14*7.6,height:ScreenHeight/25*1.8)
        
        SureButton.frame=CGRect(x:ScreenWidth*0.39,y:ScreenHeight/4*2.6,width:ScreenWidth*0.22,height:ScreenHeight/25*2.2)
        RegisterButton.frame=CGRect(x:ScreenWidth*0.39,y:ScreenHeight/4*3.1,width:ScreenWidth*0.22,height:ScreenHeight/25*2.2)
        
        RememberLabel.frame=CGRect(x:ScreenWidth*0.65,y:ScreenHeight/4*2.1,width:ScreenWidth*0.35,height:ScreenHeight/4*0.3)
        RememberSwitch.center=CGPoint(x:ScreenWidth*0.65+60,y:ScreenHeight/4*2.4+10)
        RememberSwitch.isOn=true
        RememberLabel.text="是否记住密码"
        
        
        titlelb.text="神农通用户登录"
        titlelb.textAlignment=NSTextAlignment.center
        titlelb.textColor=UIColor.blue
        titlelb.isHighlighted = true
        titlelb.highlightedTextColor = UIColor.blue
        titlelb.font=UIFont.boldSystemFont(ofSize: 20)
        
        namelb.borderStyle=UITextBorderStyle.roundedRect
        namelb.placeholder="请输入注册邮箱"
        namelb.returnKeyType=UIReturnKeyType.done
        namelb.autocorrectionType=UITextAutocorrectionType.no
        namelb.clearButtonMode=UITextFieldViewMode.whileEditing
        namelb.keyboardType=UIKeyboardType.emailAddress
        namelb.delegate=self
        
        passwordlb.borderStyle=UITextBorderStyle.roundedRect
        passwordlb.placeholder="请输入密码"
        passwordlb.returnKeyType=UIReturnKeyType.done
        passwordlb.autocorrectionType=UITextAutocorrectionType.no
        passwordlb.clearButtonMode=UITextFieldViewMode.whileEditing
        passwordlb.keyboardType=UIKeyboardType.alphabet//密码只允许输入ascII码
        passwordlb.isSecureTextEntry=true
        passwordlb.delegate=self
        
        
        
        
        SureButton.backgroundColor = UIColor.green
        SureButton.setTitle("登录",for:UIControlState.normal)
        SureButton.layer.cornerRadius = 10
        SureButton.layer.masksToBounds = true
        //SureButton.titleLabel?.adjustsFontSizeToFitWidth=true
        SureButton.titleLabel?.font=UIFont.boldSystemFont(ofSize: ScreenWidth*0.22*0.5)
        SureButton.titleLabel?.font=UIFont.boldSystemFont(ofSize: 20)
        
        RegisterButton.backgroundColor=UIColor.red
        RegisterButton.setTitle("注册", for: UIControlState.normal)
        RegisterButton.layer.cornerRadius=10
        RegisterButton.layer.masksToBounds=true
        RegisterButton.titleLabel?.font=UIFont.boldSystemFont(ofSize: ScreenWidth*0.22*0.5)
        RegisterButton.titleLabel?.font=UIFont.boldSystemFont(ofSize: 20)
        RegisterButton.layer.borderWidth = 3
        RegisterButton.layer.borderColor = UIColor.blue.cgColor
        //SureButton.setTitleColor(UIColor.white,for:UIControlState.disabled)
        //SureButton.setTitleShadowColor(UIColor.black, for: UIControlState.disabled)
        SureButton.layer.borderWidth = 3
        SureButton.layer.borderColor = UIColor.black.cgColor
        
        SureButton.addTarget(self, action: #selector(submit), for: UIControlEvents.touchUpInside)
        RegisterButton.addTarget(self, action: #selector(Register), for: UIControlEvents.touchUpInside)
        
        
        
        self.view.addSubview(RememberSwitch)
        self.view.addSubview(RememberLabel)
        self.view.backgroundColor=UIColor.white
        self.view.addSubview(titlelb)
        self.view.addSubview(namelb)
        self.view.addSubview(passwordlb)
        self.view.addSubview(SureButton)
        self.view.addSubview(RegisterButton)
        self.getNameAndPassword()
        
        let reSize = CGSize(width: ScreenWidth, height: ScreenHeight)
        self.view.backgroundColor=UIColor.init(patternImage:UIImage(named: "主页背景.png")!.reSizeImage(reSize: reSize))
        
        // Do any additional setup after loading the view.
    }
    
    @objc func returnToHomePage()
    {
        self.navigationController?.popViewController(animated: true)
        
    }
    @objc func submit(_ button:UIButton){
        //补全向服务器发送请 返回密码
        login()
    }
    @objc func Register(){
        let newPage=RegisterViewController()
        self.navigationController?.pushViewController(newPage, animated: true)
    }
    
    fileprivate func login(){
        let Email = namelb.text!
        let password = passwordlb.text!
        loginClient.instance.requestForLogin(Email, PD: password).responseJSON{
            json-> Void in
            let d=json.result.value as? NSDictionary
            if (d==nil){
                self.alert("连接失败")
                return 
            }
            switch d!["state"] as! String{
            case "SUCCESS":
                print("登录成功")
                if(self.RememberSwitch.isOn){
                    self.saveNameAndPassword()
                }
                
                UserModel.instance.UserLoaded=true
                UserModel.instance.UserEmail=Email
                self.getUserNameAndPushView()
            case "NOTUSER":
                self.alert("该用户尚未注册！")
            case "DEFALUTPD":
                self.alert("密码错误！")
            default:
                self.alert("登录失败！")
            }
        }
    }
    
    private func saveNameAndPassword(){
        UserDefaults.standard.setValue(namelb.text, forKey: "name")
        if(RememberSwitch.isOn){
            UserDefaults.standard.setValue(passwordlb.text, forKey: "password")
        }
    }
    
    private func getNameAndPassword(){
        let name=UserDefaults.standard.string(forKey: "name")
        let password=UserDefaults.standard.string(forKey: "password")
        namelb.text=name
        passwordlb.text=password
    }
    
    func getUserNameAndPushView(){
        var UserName:String=""
        let UserEmail=UserModel.instance.UserEmail
        RequestNameClient.instance.requestForUserName(UserEmail).responseJSON{
            json-> Void in
            let d=json.result.value as? NSDictionary
            if (d==nil){
                print("获取失败1")
                self.alert("获取个人信息失败")
                return
            }
            switch d!["state"] as! String{
            case"SUCCESS":
                print("获取用户名成功")
                UserName=d!["userName"] as! String
            default:
                UserName="无名氏"
                print("获取失败2")
            }
            UserModel.instance.UserName=UserName
            let UserInfoPage=UserDetailViewController()
            self.navigationController?.pushViewController(UserInfoPage, animated:true )
        }
    }
    /*此方法在循环一定次数后大概2000多次，程序终止
     func judgeFlag(){
     if(NameRequestFlag==1){
     print("结果\(UserName)")
     UserModel.instance.UserName=UserName
     }else{
     judgeFlag()
     }
     }
     */
    
    /*func textFieldShouldReturn(_ textField: UITextField) -> Bool {
     namelb.resignFirstResponder()
     passwordlb.resignFirstResponder()
     return true
     }*/
    
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
