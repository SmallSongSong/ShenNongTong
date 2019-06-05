//
//  LogOutClient.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/7/3.
//  Copyright © 2018年 OS. All rights reserved.
//  Copyright @ NWAFU

import Foundation
import UIKit
import Alamofire

class LogOutClient{
    class var instance:LogOutClient{
        struct Instance {
            static let instance=LogOutClient()
        }
        return Instance.instance
    }
    let myBaseURL=MainNetModel.instance.myBaseUrl2
    let LogOutSignal:Int=999
    
    func requestForLogOut(_ UserEmail:String)->DataRequest{
        //print(myBaseURL+"logout.php")
        print(UserEmail)
        return Alamofire.request(myBaseURL+"logout.php",parameters:["Email":UserEmail])
    }
}
