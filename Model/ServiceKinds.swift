//
//  ServiceKinds.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/3/21.
//  Copyright © 2018年 OS. All rights reserved.
//

import Foundation

class ServiceKinds {
    class var instance: ServiceKinds {
        struct Instance {
            static let instance = ServiceKinds()
        }
        return Instance.instance
}

var kindPictures=Array<String>()
var KindTitles=Array<String>()
var kindDetails=Array<String>()
var selectedRow:Int = 0
var GetURLS=Array<String>()
    
    func Clear(){
        self.KindTitles.removeAll()
        self.GetURLS.removeAll()
        self.kindDetails.removeAll()
        self.kindPictures.removeAll()
        selectedRow=0
    }
    func myInit(){
        
        
        GetURLS=[""]
        //注意：这里从后台接受到的图片大小一定要统一规格
        kindPictures.append("1")
        kindPictures.append("2")
        kindPictures.append("3")
        kindPictures.append("4")
        kindPictures.append("5")
        kindPictures.append("6")
        kindPictures.append("7")
        kindPictures.append("8")
        
        KindTitles.append("苹果相关")
        KindTitles.append("猕猴桃相关")
        KindTitles.append("核桃相关")
        KindTitles.append("葡萄相关")
        KindTitles.append("茶叶相关")
        KindTitles.append("水产相关")
        KindTitles.append("蔬菜相关")
        KindTitles.append("苹粮油相关")
        
        kindDetails.append("苹果相关的种植，选苗，防虫害，采摘，管理相关文章")
        kindDetails.append("猕猴桃相关的种植，选苗，防虫害，采摘，管理相关文章")
        kindDetails.append("核桃相关的种植，选苗，防虫害，采摘，管理相关文章")
        kindDetails.append("葡萄相关的种植，选苗，防虫害，采摘，管理相关文章")
        kindDetails.append("茶叶相关的种植，选苗，防虫害，采摘，管理相关文章")
        kindDetails.append("水产相关的种植，选苗，防虫害，采摘，管理相关文章")
        kindDetails.append("蔬菜相关的种植，选苗，防虫害，收获，管理相关文章")
        kindDetails.append("粮油相关的种植，选苗，防虫害，收获，管理相关文章")
        
}
    deinit {
        print("ServiceKinds被释放")
    }
}
