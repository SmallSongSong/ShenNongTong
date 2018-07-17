//
//  LiuYanMessageViewController.swift
//  ShenNongTongV0.2
//
//  Created by OS/Users/os/Desktop/ShenNongTong/ShenNongTongV0.2/ShenNongTongV0.2/Info.plist on 2018/5/2.
//  Copyright © 2018年 OS. All rights reserved.
//

import UIKit
import Alamofire
//这个界面因为接受数据写的有会有隐形崩溃的危险，从新弄个model吧，然后在webnews点击那里就进行请求。
class LiuYanMessageViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView=UITableView(frame:self.view.frame,style:.plain)
        self.tableView.delegate=self
        self.tableView.dataSource=self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SwiftCell")

        print("111")
        self.tableView.estimatedRowHeight=50
        print("222")
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.view.addSubview(self.tableView)

        print("良好")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(LiuYanMessageModel.instance.LiuYanNumber==0){
            return 1
        }else{
            return LiuYanMessageModel.instance.LiuYanNumber
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identify:String="SwiftCell"
        let cell=tableView.dequeueReusableCell(withIdentifier: identify, for: indexPath) as UITableViewCell
        cell.textLabel?.numberOfLines = 0
        if(LiuYanMessageModel.instance.LiuYanNumber==0){
            cell.textLabel?.attributedText=getAttributedString(title: "目前没有人留言！",subtitle: "快在下方留下你精彩的言论吧!")
        }else
        {
            cell.textLabel?.attributedText=getAttributedString(title: LiuYanMessageModel.instance.userCatalog[indexPath.row],subtitle: LiuYanMessageModel.instance.messageCatalog[indexPath.row])
        }
        return cell
    }
    
    func getAttributedString(title: String,
                             subtitle: String)-> NSAttributedString{
        let titleFont=UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        let titleColor=UIColor(red:45/255,green:153/255,blue:0/255,alpha:1)
        let titleAttributes=[NSAttributedStringKey.font:titleFont,NSAttributedStringKey.foregroundColor:titleColor]
        let subtitleFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        let subtitleAttributes=[NSAttributedStringKey.font:subtitleFont]
        let titleString = NSMutableAttributedString(string:"\(title)\n",attributes:titleAttributes)
        let subtitleString = NSAttributedString(string:subtitle,attributes:subtitleAttributes)
        titleString.append(subtitleString)
        return titleString
    
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
