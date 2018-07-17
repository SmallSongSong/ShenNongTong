//
//  NetPingTest.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/3/22.
//  Copyright © 2018年 OS. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class MyNetworkReachabilityManager{
    private static let sharedInstance=MyNetworkReachabilityManager()
    var manager=NetworkReachabilityManager(host:"www.baidu.com")
    
    init() {
        manager?.listener={
            status in
            print("Network Status Changed:\(status)")
        }
        manager?.startListening()
    }
   
    class var sharedManager:MyNetworkReachabilityManager{
        let instance = self.sharedInstance
        return instance
    }
    
    func networkReachabilityStatus()-> Alamofire.NetworkReachabilityManager.NetworkReachabilityStatus{
        let status:Alamofire.NetworkReachabilityManager.NetworkReachabilityStatus=(manager?.networkReachabilityStatus)!
        print("当前网路状况:\(status)")
        return status
    }
    deinit {
        
    }
}
