//
//  LiveItem.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/3/31.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit

class LiveItem: NSObject {
    var card_title : String?
    var card_type : String?
    var gameItem : [GameItem] = [GameItem]()
    var showItem : [ShowItem] = [ShowItem]()
    var total : String?
    var items : ([[String : Any]])? {
        didSet {
            guard let items = self.items else { return }
            for item in items {
                if item["display_type"] as? String == "2" {
                    showItem.append(ShowItem(dict: item))
                }else {
                    gameItem.append(GameItem(dict: item))
                }
            }
        }
    }
   
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
