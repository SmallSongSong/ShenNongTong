//
//  SmartChatViewController.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/3/15.
//  Copyright © 2018年 OS. All rights reserved.
//

import UIKit

class SmartChatViewController: UIViewController, ChatDataSource,UITextFieldDelegate{
    
    var Chats:NSMutableArray!
    var tableView:TableView!
    var user:UserInfo!
    var appChater:UserInfo!
    var txtMsg:UITextField!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title="智能客服"
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(title:"返回",style:UIBarButtonItemStyle.plain,target:self,action: #selector(returnToHomePage))
        self.view.backgroundColor=UIColor.white
        setupChatTable()
        setupSendPanel()
        
        // Do any additional setup after loading the view.
    }
    func setupSendPanel()
    {
        let screenWidth = UIScreen.main.bounds.width
        let sendView = UIView(frame:CGRect(x: 0,y: self.view.frame.size.height - 56,width: screenWidth,height: 56))
        
        sendView.backgroundColor=UIColor.lightGray
        sendView.alpha=0.9
        
        txtMsg = UITextField(frame:CGRect(x: 7,y: 10,width: screenWidth - 95,height: 36))
        txtMsg.backgroundColor = UIColor.white
        txtMsg.textColor=UIColor.black
        txtMsg.font=UIFont.boldSystemFont(ofSize: 12)
        txtMsg.layer.cornerRadius = 10.0
        txtMsg.returnKeyType = UIReturnKeyType.send
        
        //Set the delegate so you can respond to user input
        txtMsg.delegate=self
        sendView.addSubview(txtMsg)
        self.view.addSubview(sendView)
        
        let sendButton = UIButton(frame:CGRect(x: screenWidth - 80,y: 10,width: 72,height: 36))
        sendButton.backgroundColor=UIColor(red: 0x37/255, green: 0xba/255, blue: 0x46/255, alpha: 1)
        sendButton.addTarget(self, action:#selector(SmartChatViewController.sendMessage) ,
                             for:UIControlEvents.touchUpInside)
        sendButton.layer.cornerRadius=6.0
        sendButton.setTitle("发送", for:UIControlState())
        sendView.addSubview(sendButton)
    }
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool
    {
        sendMessage()
        return true
    }
    
    @objc func sendMessage()
    {
        //composing=false
        let sender = txtMsg
        let thisChat =  MessageItem(body:sender!.text! as NSString, user:user, date:Date(), mtype:ChatType.mine)
        //得到sender!.text后对其进行分析得到分析结果并返回
        //let response = getMessageAndResponse()
        let thatChat =  MessageItem(body:"你说的是：\(sender!.text!)" as NSString, user:appChater, date:Date(), mtype:ChatType.someone)
        
        Chats.add(thisChat)
        Chats.add(thatChat)
        self.tableView.chatDataSource = self
        self.tableView.reloadData()
        
        //self.showTableView()
        sender?.resignFirstResponder()
        sender?.text = ""
    }
    
    func setupChatTable()
    {
        self.tableView = TableView(frame:CGRect(x: 0, y: 20, width: self.view.frame.size.width, height: self.view.frame.size.height - 76), style: .plain)
        
        //创建一个重用的单元格
        self.tableView!.register(TableViewCell.self, forCellReuseIdentifier: "ChatCell")
        user = UserInfo(name:"Xiaoming" ,logo:("默认头像.png"))
        appChater  = UserInfo(name:"Xiaohua", logo:("机器人客服头像.png"))
        
        //let zero =  MessageItem(body:"t1", user:you,  date:Date(timeIntervalSinceNow:-90096400), mtype:.someone)
        
        //let zero1 =  MessageItem(body:"t2", user:me,  date:Date(timeIntervalSinceNow:-90086400), mtype:.mine)
        
        //let first =  MessageItem(body:"t3", user:me,  date:Date(timeIntervalSinceNow:-90000600), mtype:.mine)
        
        let zero1 =  MessageItem(image:UIImage(named:"欢迎.png")!,user:appChater, date:Date(timeIntervalSinceNow:0), mtype:.someone)
        
        let zero2 =  MessageItem(body:"您好！欢迎使用智能客服查询系统!\n这里提供如下的服务:\n1.农业种植相关知识.\n2.苹果采摘知识\n请问您有什么要问的吗，我将尽力为您解答！",user:appChater, date:Date(timeIntervalSinceNow:0), mtype:.someone)
        let zero3 = MessageItem(body: "很抱歉!目前智能聊天后台系统还没有部署完成，无法提供智能客服功能，该功能将在正式版发布后提供，感谢您的支持", user: appChater, date: Date(timeIntervalSinceNow:0), mtype: .someone)
        
        
        
        Chats = NSMutableArray()
        Chats.addObjects(from: [zero1,zero2,zero3])
        
        //set the chatDataSource
        self.tableView.chatDataSource = self
        
        //call the reloadData, this is actually calling your override method
        self.tableView.reloadData()
        
        //self.tableView.backgroundColor=UIColor.lightGray
        self.view.addSubview(self.tableView)
    }
    
    func rowsForChatTable(_ tableView:TableView) -> Int
    {
        return self.Chats.count
    }
    
    func chatTableView(_ tableView:TableView, dataForRow row:Int) -> MessageItem
    {
        return Chats[row] as! MessageItem
    }
    
    
    
    
    @objc func returnToHomePage()
    {
        self.navigationController?.popViewController(animated: true)
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
