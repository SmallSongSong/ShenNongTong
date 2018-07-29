//
//  PriceViewController.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/3/15.
//  Copyright © 2018年 OS. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PriceViewController: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource{
    
    let MyPickerView = UIPickerView()
    //定义一些全局变量，方便进行接受与数据变化的修改
    var allKinds:Array<String> = []
    var places:Array<String> = []
    var apples:Array<String> = []
    var nuts:Array<String> = []
    var foods:Array<String> = []
    var pickerIndex:Array<Array<String>> = []
    var nameTransformToPinyin:Dictionary<String, String> = [:]
    //第二栏联动改变用到的String数组，经常变动
    var pickerSmallKind:Array<String> = []
    //获取选中文本，构造成parameters进行网络数据传输
    var BKText:String = ""
    var SMText:String = ""
    var PText:String = ""
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    //确定每栏的行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (0==component){
            let count=allKinds.count
            return count
        }else if (1 == component){
            let count1 = pickerSmallKind.count
            return count1
        }else if (2==component){
            let count2 = places.count
            return count2
        }
        print("initCountOver!")
        return 0
    }
    
    //初始化显示内容，reloadComponent进行刷新内容
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (0 == component){
            let BK = allKinds[row]
            BKText=BK
            return BK
        }
        else if (1==component){
            let SK = pickerSmallKind[row]
            SMText=SK
            return SK
        }else if (2==component){
            let place = places[row]
            PText=place
            return place
        }
        print("titleInitError!\n")
        return nil
    }
    
    //用来进行pickerview的选中事件，进行全局变量的改变以及刷新（重新初始化),并获得选中内容
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(0==component){
            //改变第二栏变量数组
            pickerSmallKind = pickerIndex[row]
            MyPickerView.reloadComponent(1)
            MyPickerView.reloadComponent(2)
            MyPickerView.selectRow(0, inComponent: 1, animated: true)
            MyPickerView.selectRow(0, inComponent: 2, animated: true)
            
            BKText = allKinds[row]
            SMText = pickerSmallKind[0]
            PText = places[0]
        }
        if(1==component){
            MyPickerView.reloadComponent(2)
            MyPickerView.selectRow(0, inComponent: 2, animated: true)
            
            SMText=pickerSmallKind[row]
            PText = places[0]
        }
        if(2==component){
            PText = places[row]
        }
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
        
        let placeAndKindsLists:NSArray = NSArray.init(contentsOfFile:Bundle.main.path(forResource: "productsList", ofType: "plist")!)!
        let tempAllKinds:Array=placeAndKindsLists[0] as! Array<String>
        let tempPlaces:Array=placeAndKindsLists[1] as! Array<String>
        let tempApples:Array=placeAndKindsLists[2] as! Array<String>
        let tempNuts:Array=placeAndKindsLists[3] as! Array<String>
        let tempFoods:Array=placeAndKindsLists[4] as! Array<String>
        let tempTransform:Dictionary=placeAndKindsLists[5] as! Dictionary<String, String>
        
        allKinds=tempAllKinds
        places=tempPlaces
        apples=tempApples
        nuts=tempNuts
        foods=tempFoods
        nameTransformToPinyin = tempTransform
        
        pickerIndex.append(apples)
        pickerIndex.append(nuts)
        pickerIndex.append(foods)
        pickerSmallKind=pickerIndex[0]
        
        
        let ScreenRect=UIScreen.main.bounds
        let ScreenWidth=ScreenRect.size.width
        let ScreenHeight=ScreenRect.size.height
        
        
        let MyTextLabel=UILabel()
        MyTextLabel.frame=CGRect(x:ScreenWidth/6,y:ScreenHeight/6*1.3,width:ScreenWidth/3*2,height:ScreenHeight/25*3)
        MyTextLabel.text="请选择需查询的种类以及地点"
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
        
        let reSize = CGSize(width: ScreenWidth, height: ScreenHeight)
        self.view.backgroundColor=UIColor.init(patternImage:UIImage(named: "主页背景.png")!.reSizeImage(reSize: reSize))
        
        //self.view.backgroundColor=UIColor.white
        self.view.addSubview(SureButton)
        self.view.addSubview(MyTextLabel)
        self.view.addSubview(MyPickerView)
        // Do any additional setup after loading the view.
    }
    
    @objc func returnToHomePage()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func submit(){
        if(JudgeNetWork()){
            //向服务器发送查询价格以及各类增长幅度数据,然后在model里更新
            requestDataAndUpdate()
        }
    }
    
    func requestDataAndUpdate(){
        
        let SMPinYin:String = nameTransformToPinyin[SMText]!
        //let myJSONData:Parameters = ["bigkinds": BKText,"smallkinds": SMPinYin,"area": PText]
        
        priceClient.instance.requestForPrice(PText,smallkind:SMPinYin).responseJSON{response in
            if let json=response.result.value{
                print(json)
                let d = json as! NSDictionary
                switch d["state"] as! String{
                case "SUCCESS":
                    PAK.instance.Clear()
                    PAK.instance.SevenDaysPrice=d["SDP"]as! Array<Double>
                    PAK.instance.DayPriceChange=d["MPC"]as! Array<Double>
                    PAK.instance.MonthPriceChange=d["DPC"]as! Array<Double>
                    
                    let ChartPage=ChartViewController()
                    self.navigationController?.pushViewController(ChartPage, animated: true)
                    
                case "FAIL":
                    self.alert("非常抱歉，暂无数据!")
                default:
                    self.alert("未知错误，无法获取数据")
                    break
                }
            }else{
                print(response.result.value)
                print("!!!!!")
                self.alert("网络连接失败")
                return
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
