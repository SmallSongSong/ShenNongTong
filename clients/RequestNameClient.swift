//
//  RequestNameClient.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/7/3.
//  Copyright © 2018年 OS. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


class RequestNameClient{
    class var instance:RequestNameClient{
        struct Instance {
            static let instance=RequestNameClient()
        }
        return Instance.instance
    }
    let myBaseURL=MainNetModel.instance.myBaseUrl2
    func requestForUserName(_ userEmail:String)->DataRequest{
        print(myBaseURL+"getUserName.php")
        return Alamofire.request(myBaseURL+"getUserName.php",parameters:["Email":userEmail])
    }
}
