//
//  UserModel.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/3/21.
//  Copyright © 2018年 OS. All rights reserved.
//

import Foundation
class UserModel {
    class var instance: UserModel {
        struct Instance {
            static let instance = UserModel()
        }
        return Instance.instance
    }
    var UserLoaded = false
    var UserName:String="无名氏"
    var UserEmail:String=""
    var UserIdentify=1//1为农民使用者,2为专家使用者
    
    
}
