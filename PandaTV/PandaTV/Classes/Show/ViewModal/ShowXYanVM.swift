//
//  ShowXYanVM.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/4/6.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit

class ShowXYanVM: NSObject {
    
    var showArr : [ShowItem] = [ShowItem]()
    var cycleImageArr : [CycleItem] = [CycleItem]()
    
    func requestShowData(finish : @escaping ()->()) {
        
        let urlString = "http://m.api.xingyan.panda.tv/room/list?guid=5E67C26FA96E4148B6567DFD153F718E&pagenum=200&pageno=1&banner=1&__version=3.0.4.3078&__plat=ios&__channel=appstore"
        
        NetworkTools.requestData(url: urlString) { (result) in
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataDict = resultDict["data"] as? [String : Any] else {return}
            guard let items = dataDict["items"] as? [[String : Any]] else {return}
            
            for item in items {
                self.showArr.append(ShowItem(dict: item))
            }
            
            guard let images = dataDict["banners"] as? [[String : Any]] else {return}
            self.cycleImageArr.removeAll()
            for image in images {
                self.cycleImageArr.append(CycleItem(dict: image))
            }
            
            finish()
        }
    }
}
