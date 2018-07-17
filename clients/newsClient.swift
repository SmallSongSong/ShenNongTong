//
//  newsClient.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/4/9.
//  Copyright © 2018年 OS. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class newsClient{
    class var instance: newsClient{
        struct Instance{
            static let instance=newsClient()
        }
        return Instance.instance
    }
    
    let myBaseURL=MainNetModel.instance.myBaseUrl
    
    func requestForNews(_ signal:Int,type:Int)->DataRequest{
        print("注意:\n")
        print("\(myBaseURL)")
        
        return Alamofire.request(myBaseURL+"sendNews.php",parameters:["signal":signal,"type":type])
    }
    
    
}
