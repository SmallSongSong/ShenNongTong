//
//  PositionModel.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/3/26.
//  Copyright © 2018年 OS. All rights reserved.
//

import Foundation

class Position {
    class var instance: Position {
        struct Instance {
            static let instance = Position()
        }
        return Instance.instance
}

    var StationName=Array<String>()
    var PositionJingDu=Array<String>()
    var PositionWeiDu=Array<String>()
    var StationDetails=Array<String>()
    var selectedStation:Int = 0
    
    var PositionDescription=Array<String>()
    var StationImage=Array<String>()
    func MyInit(){
        selectedStation=0
        StationName.append("未知地点1")
        StationName.append("未知地点2")
        
        PositionJingDu.append("39.915352")
        PositionJingDu.append("39.123456")
        
        PositionWeiDu.append("116.397105")
        PositionWeiDu.append("116.123456")
        
        StationDetails.append("这是未知地点一")
        StationDetails.append("这是未知地点二")
        
        PositionDescription.append("这是坐落于未知地点一的试验站")
        PositionDescription.append("这是坐落于未知地点二的试验站")
        
        StationImage.append("1")
        StationImage.append("2")
    }
}
