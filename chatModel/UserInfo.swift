//
//  UserInfo.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/3/29.
//  Copyright © 2018年 OS. All rights reserved.
//

import Foundation

class UserInfo:NSObject{
    var username:String=""
    var avatar:String=""
    init(name:String,logo:String){
        self.username=name
        self.avatar=logo
    }
}
