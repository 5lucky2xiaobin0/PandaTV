//
//  GameListVM.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/4/7.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit

class GameListVM: NSObject {
    
    var listItems : [GameLisetItem] = [GameLisetItem]()
    
    func requestListData(finish : @escaping () -> ()) {
        
        self.listItems.removeAll()
        
        let url = "http://api.m.panda.tv/index.php?method=category.gamelist&__version=3.0.4.3078&__plat=ios&__channel=appstore"
        
        NetworkTools.requestData(url: url) { (result) in
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataArr = resultDict["data"] as? [[String : Any]] else {return}
            
            for dict in dataArr {
                self.listItems.append(GameLisetItem(dict: dict))
            }
            
            finish()
        }
    }
}
