//
//  Message.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/3/28.
//  Copyright © 2018年 OS. All rights reserved.
//

import Foundation

class message{
    var type:String!             //1:text 2:Image
    var text:String!
    var isMe:String!
    
    init(_ type:String, _ text:String,_ isMe:String){
        self.type=type
        self.text=text
        self.isMe=isMe
    }
}
