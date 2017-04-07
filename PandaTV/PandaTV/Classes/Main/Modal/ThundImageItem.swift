//
//  ThundImageItem.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/3/25.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit

class ThundImageItem: NSObject {
    var title : String?
    var img : String?
    var cname : String?
    
    
    init(dict : [String : Any]) {
        super.init()
        
        
        setValuesForKeys(dict)
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
