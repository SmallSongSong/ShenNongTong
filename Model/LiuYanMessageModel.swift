//
//  LiuYanMessageModel.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/5/3.
//  Copyright © 2018年 OS. All rights reserved.
//

import Foundation

class LiuYanMessageModel {
    class var instance: LiuYanMessageModel {
        struct Instance {
            static let instance = LiuYanMessageModel()
        }
        return Instance.instance
    }
    var userCatalog=Array<String>()
    var messageCatalog=Array<String>()
    var newsID:String = ""
    var LiuYanNumber:Int = 0
    func Clear(){
        LiuYanNumber=0
        newsID=""
        messageCatalog.removeAll()
        userCatalog.removeAll()
    }
}
