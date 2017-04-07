//
//  ShowVM.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/4/3.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit

class ShowVM: NSObject {
    
    var titles : [TitleItem] = [TitleItem]()
    
    func loadTitleType(urlString : String = "http://api.m.panda.tv/index.php?method=category.list&type=yl&__plat=iOS&__vesion=3.0.2.3045&mixed=1&__version=3.0.2.3045&__plat=ios&__channel=appstore", finish : @escaping ()->()) {
        
        NetworkTools.requestData(url: urlString) { (result) in
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataArr = resultDict["data"] as? [[String : Any]] else {return}
            
            for dict in dataArr {
                self.titles.append(TitleItem(dict: dict))
            }
            
            finish()
        }

        
    }
}
