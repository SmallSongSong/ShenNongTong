//
//  PostLiuYanClient.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/5/2.
//  Copyright © 2018年 OS. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class PostLiuYanClient{
    class var instance:PostLiuYanClient{
        struct Instance {
            static let instance=PostLiuYanClient()
        }
        return Instance.instance
    }
    let myBaseURL=MainNetModel.instance.myBaseUrl
    func requestForPostLiuYan(_ newsIDAndEmail:String,postLY:String)->DataRequest{
        return Alamofire.request(myBaseURL+"liuyan.php",parameters:["newsIDAndEmail":newsIDAndEmail,"postLY":postLY])
    }
}


