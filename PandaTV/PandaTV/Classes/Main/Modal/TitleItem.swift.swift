//
//  TitleItem.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/4/1.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit

 /*
 游戏,娱乐界面的标题模型
 */

class TitleItem: NSObject {
    var cname : String?
    var ename : String?
    
    init(dict : [String : Any]) {
        super.init()
        
        
        setValuesForKeys(dict)
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }

}
