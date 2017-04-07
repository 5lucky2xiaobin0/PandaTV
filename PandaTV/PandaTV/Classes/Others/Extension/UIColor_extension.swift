//
//  UIColor_extension.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/3/24.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import Foundation
import UIKit



extension UIColor {
    static func createColor(r : CGFloat, g : CGFloat, b : CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
    }
    
    static func getGreenColor() -> UIColor {
        return UIColor(red: 41 / 255.0, green: 200 / 255.0, blue: 118 / 255.0, alpha: 1)
    }
    
    static func getArcColor() -> UIColor {
        return UIColor(red: (CGFloat(arc4random()%256))/255.0, green: (CGFloat(arc4random()%256))/255.0, blue: (CGFloat(arc4random()%256))/255.0, alpha: 1)
    }
}
