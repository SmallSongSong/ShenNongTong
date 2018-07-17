//
//  priceClient.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/4/10.
//  Copyright © 2018年 OS. All rights reserved.
//


import Foundation
import Alamofire
import UIKit

class priceClient{
    class var instance: priceClient{
        struct Instance{
            static let instance=priceClient()
        }
        return Instance.instance
    }
    
    let myBaseURL=MainNetModel.instance.myBaseUrl
    
    func requestForPrice(_ row:Int,type:Array<String>)->DataRequest{
        return Alamofire.request(myBaseURL+"price.php",parameters:["row":row,"type":type])
    }
    
    
}

