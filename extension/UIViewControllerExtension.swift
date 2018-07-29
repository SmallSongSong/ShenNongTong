//
//  UIViewControllerExtension.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/4/8.
//  Copyright © 2018年 OS. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
extension UIViewController {
    
    func alert(_ message:String, handler: ((UIAlertAction) -> Void)? = nil) -> Void {
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "确定", style: .default, handler: handler)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func JudgeNetWork()->Bool{
        let statusClass=MyNetworkReachabilityManager()
        let status:NetworkReachabilityManager.NetworkReachabilityStatus = statusClass.networkReachabilityStatus()
        
        //var message="当前无网络连接!"
        var statusKind:Int=0
        
        
        switch status{
        case.notReachable:
            //message="当前无网络连接!"
            statusKind=0
            break
        case.reachable(NetworkReachabilityManager.ConnectionType.ethernetOrWiFi):
            //message="WIFI网络"
            statusKind=1
            break
        case.reachable(NetworkReachabilityManager.ConnectionType.wwan):
            //message="您正在使用3G/4流量!"
            statusKind=2
            break
        default:
            //message="当前无网络连接"
            statusKind=0
            break
        }
        if(statusKind==0){
            NoNetWorkAlet()
            return false
        }else{
            return true
        }
    }
    
    func NoNetWorkAlet(){
        let alert=UIAlertController(title:"提示",message:"当前无网络连接,    请联网后使用本功能",preferredStyle:UIAlertControllerStyle.alert)
        let OKAction=UIAlertAction(title:"好的",style:UIAlertActionStyle.default,handler:nil)
        alert.addAction(OKAction)
        self.present(alert,animated:true,completion:nil)
    }
}
