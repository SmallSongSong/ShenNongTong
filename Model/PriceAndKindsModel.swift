//
//  PriceAndKindsModel.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/3/22.
//  Copyright © 2018年 OS. All rights reserved.
//

import Foundation
class PAK {
    class var instance: PAK {
        struct Instance {
            static let instance = PAK()
        }
        return Instance.instance
    }
    var MonthPriceChange=Array<Double>()
    var DayPriceChange=Array<Double>()
    var SevenDaysPrice=Array<Double>()
    
    
    func MyInit(){
        for _ in 0..<7{
            SevenDaysPrice.append(0.0)
            DayPriceChange.append(0.0)
            MonthPriceChange.append(0.0)
        }
        
    }
    func Clear(){
        self.SevenDaysPrice.removeAll()
        self.DayPriceChange.removeAll()
        self.MonthPriceChange.removeAll()
    }
}
