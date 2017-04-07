//
//  GameVM.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/4/1.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit

class GameVM: NSObject {
    
    var titles : [TitleItem] = [TitleItem]()
    
    func requestTitleData(finish : @escaping () -> ()) {
        
        let url = "http://api.m.panda.tv/index.php?method=category.gamecate&__version=3.0.2.3045&__plat=ios&__channel=appstore"
        
        NetworkTools.requestData(url: url) { (result) in
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataArr = resultDict["data"] as? [[String : Any]] else {return}
            
            for dict in dataArr {
                self.titles.append(TitleItem(dict: dict))
            }
            
            
            finish()
        }
        
    }
}
