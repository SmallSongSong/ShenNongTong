//
//  ChanPinFuWuViewController.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/3/15.
//  Copyright © 2018年 OS. All rights reserved.
//

import UIKit
import Alamofire

class ChanPinFuWuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title="产品服务"
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(title:"返回",style:UIBarButtonItemStyle.plain,target:self,action: #selector(returnToHomePage))
        
        let ScreenRect=UIScreen.main.bounds
        let ScreenWidth=ScreenRect.size.width
        let ScreenHeight=ScreenRect.size.height
        let rect=CGRect(x:0,y:20,width:ScreenWidth,height:ScreenHeight)
        let tableView=UITableView(frame:rect)
        tableView.delegate=self
        tableView.dataSource=self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine;
        tableView.separatorColor = UIColor.clear;
        
        /*let indexPath=IndexPath(row:6,section:0)
         tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: true)*/
        
        let reSize = CGSize(width: ScreenWidth, height: ScreenHeight)
        self.view.backgroundColor=UIColor.init(patternImage:UIImage(named: "主页背景.png")!.reSizeImage(reSize: reSize))
        
        self.view.addSubview(tableView)
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ServiceKinds.instance.KindTitles.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.size.height/6
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = nil
        let cellId: String="subtitle"
        let style: UITableViewCellStyle=UITableViewCellStyle.subtitle
        
        cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        
        if cell == nil {
            cell = UITableViewCell (style: style, reuseIdentifier: cellId)
        }
        let reSize = CGSize(width: 260, height: 180)
        cell?.imageView?.image = UIImage(named: ServiceKinds.instance.kindPictures[indexPath.row])?.reSizeImage(reSize: reSize)
        cell?.textLabel?.text = ServiceKinds.instance.KindTitles[indexPath.row]
        cell?.detailTextLabel?.text = ServiceKinds.instance.kindDetails[indexPath.row]
        cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myIndex=indexPath.row
        ServiceKinds.instance.selectedRow=myIndex
        //index传进去让下一个view区分选的是什么
        //let NewsPage=WebNewsViewController()
        //self.navigationController?.pushViewController(NewsPage, animated: true)


        //
       /*let alertController=UIAlertController(title: "提示", message: "功能正在完善，敬请期待!", preferredStyle: .alert)
        let myAction=UIAlertAction(title: "知道了", style: .cancel, handler: nil)
        alertController.addAction(myAction)
        self.present(alertController,animated:true,completion:nil)
        */
        
        //以下是准备进行发出请求后接受url进行webview跳转的代码:
        let sendSignal:Int=3
        ChanPinFuWuClient.instance.requestForChanPinView(sendSignal, type: 0).responseJSON {
            json -> Void in
            let d = json.result.value as? NSDictionary
            if d == nil {
                self.alert("网络连接失败")
                return
            }
            switch d!["state"] as! String {
            case "SUCCESS":
                let URLS = d! ["URL"]as! Array<String>
                print("\(URLS[0])")
                let test=URLS[0]
                print(test)
                print("TestURL")
                ServiceKinds.instance.GetURLS=URLS
        
                let newPage=ChanPinWebViewController()
                self.navigationController?.pushViewController(newPage, animated: true)
                
                print("成功了")
            case "FAIL":
                self.alert("失败")
            default:
                break
            }
        }
    }
    

    
    @objc func returnToHomePage()
    {

        ServiceKinds.instance.Clear()
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
