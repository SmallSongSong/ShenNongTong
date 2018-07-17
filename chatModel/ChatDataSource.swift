//
//  ChatDataSource.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/3/29.
//  Copyright © 2018年 OS. All rights reserved.
//

import Foundation
import UIKit
protocol ChatDataSource{
    /*返回对话记录中的全部行数*/
    func rowsForChatTable( _ tabelView:TableView)->Int
    func chatTableView(_ tableView:TableView,dataForRow:Int)->MessageItem
}
