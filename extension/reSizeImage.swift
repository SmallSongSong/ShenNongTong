//
//  reSizeImage.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/4/3.
//  Copyright © 2018年 OS. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    //重设图片大小
    func reSizeImage(reSize:CGSize)->UIImage {
        //UIGraphicsBeginImageContext(reSize);
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale)
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: reSize)
        self.draw(in: rect)
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return reSizeImage
    }
    
}
