//
//  SettingViewController.swift
//  ShenNongTong
//
//  Created by OS on 2018/7/20.
//  Copyright © 2018年 OS. All rights reserved.
//

import UIKit
import CoreData

class SettingViewController: UIViewController {
    
    let clearButton=UIButton()
    
    override func viewDidLoad() {
        
        self.title="设置"
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(title:"返回",style:UIBarButtonItemStyle.plain,target:self,action: #selector(returnToHomePage))
        
        
        
        super.viewDidLoad()
        
        
        let ScreenRect=UIScreen.main.bounds
        let ScreenWidth=ScreenRect.size.width
        let ScreenHeight=ScreenRect.size.height
        
        
        clearButton.backgroundColor = UIColor.green
        clearButton.setTitle("清除网络数据缓存",for:UIControlState.normal)
        clearButton.layer.cornerRadius = 10
        clearButton.layer.masksToBounds = true
        clearButton.titleLabel?.adjustsFontSizeToFitWidth=true
        //clearButton.titleLabel?.font=UIFont.boldSystemFont(ofSize: ScreenWidth*0.6*0.5)
        clearButton.titleLabel?.font=UIFont.boldSystemFont(ofSize: 20)
        clearButton.frame=CGRect(x:ScreenWidth*0.2,y:ScreenHeight/4*2.3,width:ScreenWidth*0.6,height:ScreenHeight/25*3.3)
        
        clearButton.addTarget(self, action: #selector(clearCache), for: UIControlEvents.touchUpInside)
        self.view.backgroundColor=UIColor.white
        let reSize = CGSize(width: ScreenWidth, height: ScreenHeight)
        self.view.backgroundColor=UIColor.init(patternImage:UIImage(named: "主页背景.png")!.reSizeImage(reSize: reSize))
        self.view.addSubview(clearButton)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func clearCache(){
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        //不设置fetchRequest的predicate就是默认所有的查询结果
        //设置查询条件
        
        //let predicate = NSPredicate(format: "mimeType= 'png' ", "","")//这只是举例，一定要匹配好格式
        //fetchRequest.predicate=predicate
        let fetchRequest = NSFetchRequest<CachedURLResponse>(entityName:"CachedURLResponse")
        do{
            let fetchedAllObjetcs=try context.fetch(fetchRequest)
            for items in fetchedAllObjetcs{
                context.delete(items)
            }
            try! context.save()
        }
        catch{
            print("---清空缓存出了问题！---")
            alert("清空缓存失败!")
            return
        }
        alert("成功清除缓存")
    }
    
    @objc func returnToHomePage()
    {
        self.navigationController?.popViewController(animated: true)
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
