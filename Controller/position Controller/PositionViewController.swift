//
//  PositionViewController.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/3/15.
//  Copyright © 2018年 OS. All rights reserved.
//

import UIKit

class PositionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate{
    
    var stationName:Array<String> = []
    var stationDetail:Array<String> = []
    var stationImage:Array<String> = []
    var jingDu:Array<String> = []
    var weiDu:Array<String> = []
    var stationIndex:Int = 0
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="示范站信息"
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(title:"返回",style:UIBarButtonItemStyle.plain,target:self,action: #selector(returnToHomePage))
        
        let listpath=Bundle.main.path(forResource: "positionList", ofType: "plist")
        let allLists:NSArray=NSArray.init(contentsOfFile:listpath!)!
        let itemList1:Array<String>=allLists[0] as! Array<String>
        let itemList2:Array<String>=allLists[1] as! Array<String>
        
        stationName.append(itemList1[2])
        stationName.append(itemList2[2])
        stationDetail.append(itemList1[3])
        stationDetail.append(itemList2[3])
        stationImage.append("苹果试验站")
        stationImage.append("西农苹果研究中心")
        jingDu.append(itemList1[0])
        jingDu.append(itemList2[0])
        weiDu.append(itemList1[1])
        weiDu.append(itemList2[1])
        
        
        let ScreenRect=UIScreen.main.bounds
        let ScreenWidth=ScreenRect.size.width
        let ScreenHeight=ScreenRect.size.height
        let rect=CGRect(x:0,y:20,width:ScreenWidth,height:ScreenHeight)
        let tableView=UITableView(frame:rect)
        tableView.delegate=self
        tableView.dataSource=self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine;
        tableView.separatorColor = UIColor.clear;
        
        let reSize = CGSize(width: ScreenWidth, height: ScreenHeight)
        tableView.backgroundColor=UIColor.init(patternImage:UIImage(named: "主页背景.png")!.reSizeImage(reSize: reSize))
        
        
        self.view.addSubview(tableView)
        // Do any additional setup after loading the view.
    }
    
    @objc func returnToHomePage()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stationName.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell? = nil
        let cellId: String="subtitle"
        let style: UITableViewCellStyle=UITableViewCellStyle.subtitle
        
        cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        
        if cell == nil {
            cell = UITableViewCell (style: style, reuseIdentifier: cellId)
        }
        let reSize = CGSize(width: 160, height: 160)
        cell?.imageView?.image = UIImage(named: stationImage[indexPath.row])?.reSizeImage(reSize: reSize)
        cell?.textLabel?.numberOfLines=0
        cell?.textLabel?.text = stationName[indexPath.row]
        cell?.detailTextLabel?.numberOfLines=0
        cell?.detailTextLabel?.text = stationDetail[indexPath.row]
        cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell?.backgroundColor=UIColor.clear
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.size.height/4*1.1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        stationIndex=indexPath.row
        
        let actionSheet=UIActionSheet()
        
        actionSheet.title = "请选择操作"
        actionSheet.addButton(withTitle: "取消")
        actionSheet.addButton(withTitle: "试验站地图")
        actionSheet.addButton(withTitle: "田间检测数据")
        actionSheet.addButton(withTitle: "生产现场视频")
        actionSheet.cancelButtonIndex=0
        actionSheet.delegate=self
        actionSheet.show(in: self.view);
        
    }
    
    func actionSheet(_ actionSheet: UIActionSheet,clickedButtonAt buttonIndex:Int){
        if(buttonIndex==1){
            if(JudgeNetWork()){
                let NewPage=MapViewController()
                NewPage.stationLocation.append(Double(jingDu[stationIndex])!)
                NewPage.stationLocation.append(Double(weiDu[stationIndex])!)
                NewPage.selectedStation=stationIndex
                self.navigationController?.pushViewController(NewPage, animated: true)
            }else{
                NoNetWorkAlet()
            }
        }
        if(buttonIndex==2){
            //get
        }
        if(buttonIndex==3){
            //get
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
