//
//  loginClient.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/4/24.
//  Copyright © 2018年 OS. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class loginClient{
    class var instance:loginClient{
        struct Instance {
            static let instance=loginClient()
        }
        return Instance.instance
    }
    let myBaseURL=MainNetModel.instance.myBaseUrl2
    func requestForLogin(_ userName:String,PD:String)->DataRequest{
        print(myBaseURL+"login2.php")
        return Alamofire.request(myBaseURL+"login2.php",parameters:["Email":userName,"PD":PD])
    }
}
