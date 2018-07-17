//
//  LiuYanClient.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/5/2.
//  Copyright © 2018年 OS. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class LiuYanClient{
    class var instance:LiuYanClient{
        struct Instance {
            static let instance=LiuYanClient()
        }
        return Instance.instance
    }
    let myBaseURL=MainNetModel.instance.myBaseUrl
    func requestForLiuYan(_ signal:Int,postID:String)->DataRequest{
        return Alamofire.request(myBaseURL+"chakanliuyan.php",parameters:["signal":signal,"postID":postID])
    }
}


