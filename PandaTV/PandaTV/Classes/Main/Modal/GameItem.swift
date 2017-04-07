//
//  GameItem.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/3/24.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit

class GameItem: NSObject {
    
    var display_type : String?
    var name : String?
    var person_num : Int = 0
    var pictures : [String : Any]?
    var img : String?
    var title : String?
    var cname : String?
    var userItem : UserItem?
    var gameType : String?
    var card_type : String?

    var avatar : String?
    var city : String?
    var nickName : String?
    var personnum : Int = 0
    
    var classification : Any? {
        didSet {
            guard let fication = classification as? [String : Any]? else {return}
            gameType = fication?["cname"] as! String?
        }
    }
    
    var userinfo : [String : Any]?{
        didSet {
            guard let info = userinfo else {return}
            userItem = UserItem(dict: info)
        }
    }
  
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
