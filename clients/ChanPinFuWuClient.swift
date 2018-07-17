//
//  ChanPinFuWuClient.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/4/8.
//  Copyright © 2018年 OS. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class ChanPinFuWuClient{
    class var instance: ChanPinFuWuClient{
        struct Instance{
            static let instance=ChanPinFuWuClient()
        }
        return Instance.instance
    }
    
    let myBaseURL=MainNetModel.instance.myBaseUrl
    
    func requestForChanPinView(_ signal:Int,type:Int)->DataRequest{
        print("注意:\n")
        print("\(myBaseURL)")
        print("sendList.php")
        
        return Alamofire.request(myBaseURL+"sendUrl.php",parameters:["signal":signal,"type":type])
    }
    
    
}
