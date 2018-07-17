//
//  registerClient.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/4/25.
//  Copyright © 2018年 OS. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class registerClient{
    class var instance:registerClient{
        struct Instance {
            static let instance=registerClient()
        }
        return Instance.instance
    }
    let myBaseURL=MainNetModel.instance.myBaseUrl2
    func requestForRegister(_ userName:String,MailAndPD:String)->DataRequest{
        return Alamofire.request(myBaseURL+"register.php",parameters:["userName":userName,"MailAndPD":MailAndPD])
    }
}

