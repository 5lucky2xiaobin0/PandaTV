//
//  GameLisetItem.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/4/7.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit

class GameLisetItem: NSObject {
    var cname : String?
    var thundImageItems : [ThundImageItem] = [ThundImageItem]()
    
    var child_data : [[String : Any]]? {
        didSet {
            guard let dataArr = child_data else {return}
            for data in dataArr {
                self.thundImageItems.append(ThundImageItem(dict: data))
            }
        }
    }
    
 
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

}
