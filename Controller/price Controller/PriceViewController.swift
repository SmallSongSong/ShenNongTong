//
//  PriceViewController.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/3/15.
//  Copyright © 2018年 OS. All rights reserved.
//

import UIKit
import Alamofire


class PriceViewController: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource{
    
    let Big=PAK.instance.BigAndSmallKinds
    let MyPickerView = UIPickerView()
    //let Big=PAK.instance.BigAndSmallKinds
    var Small:[String]=[""]
    let Areas=PAK.instance.Areas
    var text1=""
    var text2=""
    var text3=""
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (0==component){
            let count=Big.count
            return count
        }else if (1 == component){
            let count=Small.count
            return count
        }else if (2 == component){
            let count=Areas.count
            return count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        // 每个选择框每行的显示内容
        if 0 == component
        {
            // 第一列
            let BK=[String](Big.keys)
            let BText=BK[row]
            
            return BText
        }
        else if 1 == component
        {
            // 第二列
            let SText=Small[row]
            return SText
        }
        else if 2 == component
        {
            // 第三列
            let Area=Areas[row]
            return Area
        }
        print("titleInitError!\n")
        return nil
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (0==component)
        {
            
            let BK=[String](Big.keys)
            let BText=BK[row]
            // 第二关联改变
            
            Small=Big[BText]!
            MyPickerView.reloadComponent(1)
            MyPickerView.reloadComponent(2)
            MyPickerView.selectRow(0, inComponent: 1, animated: true)
            MyPickerView.selectRow(0, inComponent:2,animated:true)
            text1=BText
            text2=Small[0]
            text3=Areas[0]
        }
        if (1==component){
            text2=Small[row]
            MyPickerView.reloadComponent(2)
            MyPickerView.selectRow(0, inComponent:2,animated:true)
            text3=Areas[0]
            
        }
        if (2==component){
            text3=Areas[row]
        }
        print("你选择了\(text1)  \(text2)  \(text3)")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="市场行情"
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(title:"返回",style:UIBarButtonItemStyle.plain,target:self,action: #selector(returnToHomePage))
        //self.view.backgroundColor=UIColor.brown
        
        let ScreenRect=UIScreen.main.bounds
        let ScreenWidth=ScreenRect.size.width
        let ScreenHeight=ScreenRect.size.height
        
        
        let MyTextLabel=UILabel()
        MyTextLabel.frame=CGRect(x:ScreenWidth/6,y:ScreenHeight/6*1.3,width:ScreenWidth/3*2,height:ScreenHeight/25*3)
        MyTextLabel.text="请选择需查询物品的大类，小类以及地点"
        MyTextLabel.textAlignment=NSTextAlignment.center
        MyTextLabel.font=UIFont.boldSystemFont(ofSize: 20)
        MyTextLabel.adjustsFontSizeToFitWidth=true
        MyTextLabel.minimumScaleFactor=0.6
        MyTextLabel.textColor=UIColor.blue
        MyTextLabel.isHighlighted = true
        MyTextLabel.highlightedTextColor = UIColor.blue
        
        
        MyPickerView.dataSource = self
        MyPickerView.delegate = self
        
        MyPickerView.frame=CGRect(x:ScreenWidth/12,y:ScreenHeight/4*1.2,width:ScreenWidth/12*10,height:ScreenHeight/4*1.1)
        MyPickerView.reloadAllComponents()
        //设置选择框的默认值
        MyPickerView.selectRow(0,inComponent:0,animated:true)
        MyPickerView.selectRow(0,inComponent:1,animated:true)
        MyPickerView.selectRow(0,inComponent:2,animated:true)
        
        let SureButton=UIButton()
        
        SureButton.frame=CGRect(x:ScreenWidth*0.3,y:ScreenHeight/12*7,width:ScreenWidth*0.4,height:ScreenHeight/25*2.2)
        
        SureButton.backgroundColor = UIColor.green
        SureButton.setTitle("显示价格图",for:UIControlState.normal)
        SureButton.layer.cornerRadius = 10
        SureButton.layer.masksToBounds = true
        
        SureButton.titleLabel?.font=UIFont.boldSystemFont(ofSize: ScreenWidth*0.22*0.5)
        SureButton.titleLabel?.font=UIFont.boldSystemFont(ofSize: 20)
        
        SureButton.layer.borderWidth = 3
        SureButton.layer.borderColor = UIColor.black.cgColor
        
        SureButton.addTarget(self, action: #selector(submit), for: UIControlEvents.touchUpInside)
        self.view.backgroundColor=UIColor.white
        self.view.addSubview(SureButton)
        self.view.addSubview(MyTextLabel)
        self.view.addSubview(MyPickerView)
        // Do any additional setup after loading the view.
    }

    @objc func returnToHomePage()
    {
        PAK.instance.Areas.removeAll()
        PAK.instance.BigAndSmallKinds.removeAll()
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func submit(){
        if(JudgeNetWork()){
            //向服务器发送查询价格以及各类增长幅度数据,然后在model里更新
            requestDataAndUpdate()
            //print("大类：\(text1); 小类:\(text2); 地点:\(text3)")
        }
    }
    func requestDataAndUpdate(){
        let sendSignal:Int=4
        var typeName=Array<String>()
        //typeName.append(text1)
        //typeName.append(text2)
        //typeName.append(text3)
        
        let smallName=PAK.instance.smallKinds[text2]
        print(smallName!)
        print("小类")
        print(text3)
        if(smallName==nil){
            self.alert("查找的小类有问题")
            return
        }
        typeName.append(smallName!)
        typeName.append(text3)

        priceClient.instance.requestForPrice(sendSignal, type: typeName).responseJSON {
            json -> Void in
            let d = json.result.value as? NSDictionary
            if d == nil {
                self.alert("网络连接失败")
                return
            }
            switch d!["state"] as! String {
            case "SUCCESS":
                let sevenDaysPrice=d! ["SDP"]as! Array<Double>
                let monthPriceChange=d! ["MPC"]as! Array<Double>
                let DayPriceChange=d! ["DPC"]as! Array<Double>
                
                PAK.instance.Clear()
                
                PAK.instance.SevenDaysPrice=sevenDaysPrice
                PAK.instance.DayPriceChange=DayPriceChange
                PAK.instance.MonthPriceChange=monthPriceChange
                
                for num in 0..<PAK.instance.SevenDaysPrice.count{
                    print(PAK.instance.SevenDaysPrice[num])
                }
                let ChartPage=ChartViewController()
                self.navigationController?.pushViewController(ChartPage, animated: true)
            case "FAIL":
                self.alert("失败")
            default:
                break
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
