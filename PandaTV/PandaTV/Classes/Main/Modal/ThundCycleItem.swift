//
//  CommentItem.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/3/25.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit

class ThundCycleItem: NSObject {
    //轮播图片模型
    var cycleItems : [CycleItem] = [CycleItem]()
    //热门游戏模型
    var thundimages : [ThundImageItem] = [ThundImageItem]()
  
    var banners : [[String : Any]]? {
        didSet {
            guard let banners = banners else {return}
            for banner in banners {
                cycleItems.append(CycleItem(dict: banner))
            }
        }
    }
    
    var navs : [[String : Any]]? {
        didSet {
            guard let navs = navs else {return}
            for navs in navs {
                thundimages.append(ThundImageItem(dict: navs))
            }
        }
    }
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
