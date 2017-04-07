//
//  showItem.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/3/31.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit

class ShowItem: NSObject {
    var name : String?
    var avatar : String?
    var city : String?
    var nickName : String?
    var personnum : Int = 0
 
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { return }
}
