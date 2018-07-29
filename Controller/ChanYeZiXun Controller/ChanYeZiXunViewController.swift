//
//  ChanYeZiXunViewController.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/3/14.
//  Copyright © 2018年 OS. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ChanYeZiXunViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    let refreshControl=UIRefreshControl()
    var reFreshTimes:Int=0
    var tableView=UITableView()
    var timer: Timer!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad( )
        
        self.title="农业资讯导航"
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(title:"返回",style:UIBarButtonItemStyle.plain,target:self,action: #selector(returnToHomePage))
        
        refreshControl.addTarget(self, action:  #selector(refreshData),
                                 for: UIControlEvents.valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新资讯")
        
        
        let ScreenRect=UIScreen.main.bounds
        let ScreenWidth=ScreenRect.size.width
        let ScreenHeight=ScreenRect.size.height
        let rect=CGRect(x:0,y:20,width:ScreenWidth,height:ScreenHeight)
        tableView=UITableView(frame:rect)
        tableView.delegate=self
        tableView.dataSource=self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine;
        tableView.separatorColor = UIColor.clear;
        
        /*let indexPath=IndexPath(row:6,section:0)
        tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: true)*/
        
        let reSize = CGSize(width: ScreenWidth, height: ScreenHeight)
        self.view.backgroundColor=UIColor.init(patternImage:UIImage(named: "主页背景.png")!.reSizeImage(reSize: reSize))
   
        tableView.addSubview(refreshControl)
        self.view.addSubview(tableView)
        
        // Do any additional setup after loading the view.
        //refreshData()
    }
    @objc func returnToHomePage()
    {
      NewsModel.instance.Clear()
      self.navigationController?.popViewController(animated: true)
    }
    
    @objc func refreshData(){
        let sendSignal:Int=233
        reFreshTimes+=1
        refreshControl.attributedTitle=NSAttributedString(string:"新闻加载中......")
        print("刷新次数:\(reFreshTimes)")
        newsClient.instance.requestForNews(sendSignal, type: reFreshTimes).responseJSON {
            
            json -> Void in
            print("进入刷新！！！！！！！！！！！！！！！！！！！！！！！！")
            let d = json.result.value as? NSDictionary
            if d == nil {
                self.alert("网络连接失败3")
                self.refreshControl.attributedTitle = NSAttributedString(string: "刷新失败")
                self.refreshControl.endRefreshing()
                return
            }
            switch d!["state"] as! String {
            case "SUCCESS":
                print("刷新成功")
                NewsModel.instance.Clear()
                let URLS = d! ["URL"]as! Array<String>
                let Titles = d! ["Title"]as! Array<String>
                let Details = d! ["Detail"]as! Array<String>
                let picturesURL = d! ["pictureURL"]as! Array<String>
                let newsID = d! ["newsID"]as! Array<String>
                let Discussnumber = d! ["discussnumber"]as! Array<Int>
                
                NewsModel.instance.NewsImageNames=picturesURL
                NewsModel.instance.NewsTitles=Titles
                NewsModel.instance.NewsDetails=Details
                NewsModel.instance.urllists=URLS
                NewsModel.instance.newsID=newsID
                NewsModel.instance.DiscussNumber=Discussnumber
                
                self.tableView.reloadData()
            case "FAIL":
                self.alert("失败")
            default:
                print("t3")
                break
            }
            self.refreshControl.attributedTitle = NSAttributedString(string: "刷新完成")
            self.refreshControl.endRefreshing()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsModel.instance.NewsTitles.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.size.height/5*1.1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*let cell=UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "reuseIdentifier")
        cell.imageView?.image=UIImage(named: "pic1")
        cell.textLabel?.text=NewsModel.instance.studyLessons[indexPath.row]
        cell.detailTextLabel?.text=NewsModel.instance.studyLessonInroduction[indexPath.row]
        */
        var cell: UITableViewCell? = nil
        let cellId: String="subtitle"
        let style: UITableViewCellStyle=UITableViewCellStyle.subtitle
        
        cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        
        if cell == nil {
            cell = UITableViewCell (style: style, reuseIdentifier: cellId)
        }
        //let reSize = CGSize(width: 260, height: 180)
        
        
        var urls=Array<URL>()//没给他初始化长度，注意了

        for num in 0..<NewsModel.instance.NewsImageNames.count{
            //print("rangeNum:")
            //print(NewsModel.instance.NewsImageNames[num])
            let transTemp=NewsModel.instance.NewsImageNames[num]
            urls.append(URL(string:transTemp)!)
        }
        
        //异步进行网络图片加载
        loadImage((cell?.imageView)!, getURL: urls, row: indexPath.row)
        //cell?.imageView?.image = UIImage(named: NewsModel.instance.NewsImageNames[indexPath.row])?.reSizeImage(reSize: reSize)
        cell?.textLabel?.numberOfLines=0
        cell?.textLabel?.text = NewsModel.instance.NewsTitles[indexPath.row]
        cell?.detailTextLabel?.numberOfLines=2
        cell?.detailTextLabel?.text = NewsModel.instance.NewsDetails[indexPath.row]
        cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myIndex=indexPath.row
        NewsModel.instance.selectedRow=myIndex

        //let NewsPage=WebNewsViewController()
        //
        //self.navigationController?.pushViewController(NewsPage, animated: true)

        //现对LiuYanMessageModel进行清空:
        LiuYanMessageModel.instance.Clear()
        
        //对留言界面的josn请求：
        let LiuYanSignal:Int=111
        //print("slecetedRow数量是\(NewsModel.instance.selectedRow)")
        let IDWillPost:String=NewsModel.instance.newsID[NewsModel.instance.selectedRow]//Attention1
        LiuYanMessageModel.instance.newsID=IDWillPost
        LiuYanClient.instance.requestForLiuYan(LiuYanSignal, postID: IDWillPost).responseJSON {
            
            json -> Void in
            let d = json.result.value as? NSDictionary
            if d == nil {
                self.alert("查看留言请求失败")
                return
            }
            switch d!["state"] as! String {
            case "SUCCESS":
                print("成功")
                LiuYanMessageModel.instance.userCatalog = d!["UserName"]as! Array<String>
                LiuYanMessageModel.instance.messageCatalog = d!["UserLiuYan"]as! Array<String>
                let tempNewsNum=NewsModel.instance.DiscussNumber[NewsModel.instance.selectedRow]
                LiuYanMessageModel.instance.LiuYanNumber=tempNewsNum
                
                let tabBarControllerPage=NewsTabBarViewController()
                self.navigationController?.pushViewController(tabBarControllerPage, animated: true)
            case "NoMessage":
                LiuYanMessageModel.instance.LiuYanNumber=0
                let tabBarControllerPage=NewsTabBarViewController()
                self.navigationController?.pushViewController(tabBarControllerPage, animated: true)
                print("没有留言")
            case "FAIL":
                let tabBarControllerPage=NewsTabBarViewController()
                self.navigationController?.pushViewController(tabBarControllerPage, animated: true)
                self.alert("不能获得该文章的留言")
            default:
                print("查看新闻失败!")
                break
            }
        }
    }
    /*@objc func timeOut(){
        //tableView.reloadData()
        //refreshControl.attributedTitle = NSAttributedString(string: "刷新完成")
        //self.refreshControl.endRefreshing()
        //print("刷新完成")
    }
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//异步加载网络图片
    func loadImage(_ rowImgView:UIImageView,getURL:Array<URL>,row:Int){
        let reSize = CGSize(width: 120, height: 120)
        let request=URLRequest(url:getURL[row])
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            if error != nil{
                print(error.debugDescription)
            }else{
                //将图片数据赋予UIImage
                DispatchQueue.main.async{
                let img = UIImage(data:data!)
                rowImgView.image=img?.reSizeImage(reSize: reSize)
                }
            }
        }) as URLSessionTask
        
        //使用resume方法启动任务
        dataTask.resume()
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
