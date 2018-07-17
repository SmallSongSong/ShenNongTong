//
//  MainNetModel.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/4/8.
//  Copyright © 2018年 OS. All rights reserved.
//

import Foundation

class MainNetModel{
    class var instance:MainNetModel{
        struct Instance{
            static let instance=MainNetModel()
        }
        return Instance.instance
    }
    let myBaseUrl="http://139.199.85.198:8080/app/Server/"
    let myBaseUrl2="http://139.199.85.198:8080/app/Mail/"
    let myBaseUrl3="http://139.199.85.198:8080/app/newPlace3/"
    //let videoFile="http://139.199.85.198/Server/src/MP4/"
    //let myAnyChatUrl="139.199.85.198"
    //let myAnyChatPort:Int32=8906
    
}
