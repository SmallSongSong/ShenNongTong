//
//  NewsModel.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/3/20.
//  Copyright © 2018年 OS. All rights reserved.
//

import Foundation

class NewsModel {
    class var instance: NewsModel {
        struct Instance {
            static let instance = NewsModel()
        }
        return Instance.instance
    }
    var NewsImageNames=Array<String>()      //存储标题图
    //var imageLengths=Array<Int>()         //图片集长度
    var NewsTitles=Array<String>()          //新闻名称
    var NewsDetails=Array<String>()         //新闻介绍
    var urllists=Array<String>()
    var newsID=Array<String>()
    var selectedRow:Int = 0
    var DiscussNumber=Array<Int>()
    var DianZanNumber:Int=0
    func Clear(){
        self.DianZanNumber=0
        self.DiscussNumber.removeAll()
        self.NewsDetails.removeAll()
        self.newsID.removeAll()
        self.NewsImageNames.removeAll()
        self.NewsTitles.removeAll()
        self.urllists.removeAll()
    }
    deinit{
        print("NewsModel被释放")
    }
    
}
