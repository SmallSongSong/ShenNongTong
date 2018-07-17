//
//  NewsTabBarViewController.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/4/27.
//  Copyright © 2018年 OS. All rights reserved.
//

import UIKit
import Alamofire

class NewsTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var tempNewsNum:Int=0
        //一共包含了两个视图
        //let viewMain = WebNewsViewController()
        let viewMain=WKWebNewsViewController()
        viewMain.title = "资讯详情"
        let viewDiscuss = LiuYanMessageViewController()
        viewDiscuss.title = "查看评论"
        let viewLiuYan = PostLiuYanViewController()
        viewLiuYan.title = "发表评论"
        //分别声明两个视图控制器
        let main = UINavigationController(rootViewController:viewMain)
        //main.tabBarItem.image = UIImage(named:"news")
        
        let discuss = UINavigationController(rootViewController:viewDiscuss)
        //discuss.tabBarItem.image = UIImage(named:"rightdiscuss")
        
        tempNewsNum=LiuYanMessageModel.instance.LiuYanNumber
        print(tempNewsNum)
        print("this!")
        discuss.tabBarItem.badgeValue=String(tempNewsNum)
        
        let PostLiuYan = UINavigationController(rootViewController:viewLiuYan)
        
        
        self.viewControllers = [main,discuss,PostLiuYan]
        //默认选中的webview
        self.selectedIndex = 0

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func SelectItem(selectedItem:Int){
         self.selectedIndex=1
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
