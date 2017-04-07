//
//  UIView_extension.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/4/2.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit


extension UIView {
    func getX() -> CGFloat {
        return self.frame.origin.x
    }
    
    func x(NewX : CGFloat) {
        var frame = self.frame
        frame.origin.x = NewX
        self.frame = frame
    }
    
    
    func getY() -> CGFloat {
        return self.frame.origin.y
    }
    
    func y(NewY : CGFloat) {
        var frame = self.frame
        frame.origin.y = NewY
        self.frame = frame
    }
    
    func getWidth() -> CGFloat {
        return self.frame.size.width
    }
    
    func width(NewWidth : CGFloat) {
        var frame = self.frame
        frame.size.width = NewWidth
        self.frame = frame
    }
    
    func getHeight() -> CGFloat {
        return self.frame.size.height
    }
    
    func height(NewHeight : CGFloat) {
        var frame = self.frame
        frame.size.height = NewHeight
        self.frame = frame
    }
    
    func getCenterX() -> CGFloat {
        return self.center.x
    }
    
    func centerX(NewCenterX : CGFloat) {
        var center = self.center
        center.x = NewCenterX
        self.center = center
    }
    
    func getCenterY() -> CGFloat {
        return self.center.y
    }
    
    func centerY(NewCenterY : CGFloat) {
        var center = self.center
        center.y = NewCenterY
        self.center = center
    }
    
    
    
    
    
}
