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
        kindPictures.append("苹果")
        kindPictures.append("红薯和玉米")
        kindPictures.append("猕猴桃")
        kindPictures.append("大核桃")
        kindPictures.append("小麦")
        kindPictures.append("水稻")
        
        KindTitles.append("苹果相关")
        KindTitles.append("红薯玉米相关")
        KindTitles.append("猕猴桃相关")
        KindTitles.append("大核桃相关")
        KindTitles.append("小麦相关")
        KindTitles.append("水稻相关")
        
        kindDetails.append("苹果种植及防虫害等文章")
        kindDetails.append("红薯和玉米的文章")
        kindDetails.append("猕猴桃种植及防虫害等文章")
        kindDetails.append("大核桃桃种植及防虫害等文章")
        kindDetails.append("小麦桃种植及防虫害等文章")
        kindDetails.append("水稻桃种植及防虫害等文章")
        
    }
    deinit {
        print("ServiceKinds被释放")
    }
}
