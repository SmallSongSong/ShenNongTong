//
//  PositionViewController.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/3/15.
//  Copyright © 2018年 OS. All rights reserved.
//

import UIKit

class PositionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate{

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="示范站信息"
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(title:"返回",style:UIBarButtonItemStyle.plain,target:self,action: #selector(returnToHomePage))
        //self.view.backgroundColor=UIColor.green
        
        let ScreenRect=UIScreen.main.bounds
        let ScreenWidth=ScreenRect.size.width
        let ScreenHeight=ScreenRect.size.height
        let rect=CGRect(x:0,y:20,width:ScreenWidth,height:ScreenHeight)
        let tableView=UITableView(frame:rect)
        tableView.delegate=self
        tableView.dataSource=self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine;
        tableView.separatorColor = UIColor.clear;
        
        self.view.addSubview(tableView)

        // Do any additional setup after loading the view.
    }
    
    @objc func returnToHomePage()
    {
        Position.instance.StationName.removeAll()
        Position.instance.PositionJingDu.removeAll()
        Position.instance.PositionWeiDu.removeAll()
        Position.instance.StationDetails.removeAll()
        
        Position.instance.PositionDescription.removeAll()
        Position.instance.StationImage.removeAll()
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Position.instance.StationName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell: UITableViewCell? = nil
        let cellId: String="subtitle"
        let style: UITableViewCellStyle=UITableViewCellStyle.subtitle
        
        cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        
        if cell == nil {
            cell = UITableViewCell (style: style, reuseIdentifier: cellId)
        }
        let reSize = CGSize(width: 260, height: 220)
        cell?.imageView?.image = UIImage(named: Position.instance.StationImage[indexPath.row])?.reSizeImage(reSize: reSize)
        cell?.textLabel?.text = Position.instance.StationName[indexPath.row]
        
        cell?.detailTextLabel?.text = Position.instance.StationDetails[indexPath.row]
        cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.size.height/4*1.1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myIndex=indexPath.row
        Position.instance.selectedStation=myIndex
        /*let alertController = UIAlertController(title: "详细信息", message: "请选择想要了解的信息",
                                                preferredStyle: .actionSheet)
        
        
        let MapAction = UIAlertAction(title: "试验站地图", style: .default, handler: nil)
        let DataAction = UIAlertAction(title: "田间检测数据", style: .default, handler: nil)
        let VideoAction = UIAlertAction(title: "生产现场视频", style: .default, handler: nil)
        
        alertController.addAction(MapAction)
        alertController.addAction(DataAction)
        alertController.addAction(VideoAction)
        
        self.present(alertController, animated: true, completion: nil)*/
        
        let actionSheet=UIActionSheet()
        actionSheet.title = "请选择操作"
        actionSheet.addButton(withTitle: "取消")
        actionSheet.addButton(withTitle: "试验站地图")
        actionSheet.addButton(withTitle: "田间检测数据")
        actionSheet.addButton(withTitle: "生产现场视频")
        actionSheet.cancelButtonIndex=0
        actionSheet.delegate=self
        actionSheet.show(in: self.view);
        
        //let NewsPage=MapViewController()
        
        //self.navigationController?.pushViewController(NewsPage, animated: true)
    }
    
    func actionSheet(_ actionSheet: UIActionSheet,clickedButtonAt buttonIndex:Int){
        print("点击了：\(String(describing: actionSheet.buttonTitle(at: buttonIndex)))")
        print("\(buttonIndex)")
        if(buttonIndex==1){
            if(JudgeNetWork()){
                let NewsPage=MapViewController()
                self.navigationController?.pushViewController(NewsPage, animated: true)
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
