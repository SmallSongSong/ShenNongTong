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

    var BigAndSmallKinds=Dictionary<String,[String]>()
    var Areas=Array<String>()
    var MonthPriceChange=Array<Double>()
    var DayPriceChange=Array<Double>()
    var SevenDaysPrice=Array<Double>()
    
    let smallKinds=["红富士":"hongfushi","小苹果":"xiaopingguo","礼泉苹果":"liquanpingguo","大核桃":"dahetao","小核桃":"xiaohetao","小米":"xiaomi","大米":"dami","玉米":"yumi","红薯":"hongshu"]
    
    func MyInit(){
        BigAndSmallKinds["苹果"]=["红富士","小苹果","礼泉苹果"]
        BigAndSmallKinds["核桃"]=["大核桃","小核桃"]
        BigAndSmallKinds["粮食"]=["小米","大米","玉米","红薯"]
        Areas.append("杨凌")
        Areas.append("商洛")
        Areas.append("西安")
        Areas.append("黑龙江")
        Areas.append("广东")
        Areas.append("河南")
        Areas.append("辽宁")
        Areas.append("深圳")
        
        SevenDaysPrice.append(3.4)
        SevenDaysPrice.append(3.0)
        SevenDaysPrice.append(4.0)
        SevenDaysPrice.append(2.1)
        SevenDaysPrice.append(3.1)
        SevenDaysPrice.append(2.5)
        SevenDaysPrice.append(3.2)
        
        DayPriceChange.append(0.0)
        DayPriceChange.append(0.0)
        DayPriceChange.append(0.0)
        DayPriceChange.append(0.0)
        DayPriceChange.append(0.0)
        DayPriceChange.append(0.0)
        DayPriceChange.append(0.0)
        
        MonthPriceChange.append(0.0)
        MonthPriceChange.append(0.0)
        MonthPriceChange.append(0.0)
        MonthPriceChange.append(0.0)
        MonthPriceChange.append(0.0)
        MonthPriceChange.append(0.0)
        MonthPriceChange.append(0.0)
        
    }
    func Clear(){
        self.SevenDaysPrice.removeAll()
        self.DayPriceChange.removeAll()
        self.MonthPriceChange.removeAll()
    }
}
