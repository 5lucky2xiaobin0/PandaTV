//
//  ShowTypeCycleVM.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/4/5.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit

class ShowTypeCycleVM: NSObject {
    var gameArr : [GameItem] = [GameItem]()
    var cycleImageArr : [CycleItem] = [CycleItem]()
    
    func requestData(searchPath : String, index : Int, finish : @escaping (_ noData : Bool) -> ()) {
        
        let urlString = "http://api.m.panda.tv/ajax_get_live_list_by_cate?cate=\(searchPath)&pageno=\(index)&pagenum=10&order=person_num&status=2&banner=1&slider=1&__version=3.0.3.3076&__plat=ios&__channel=appstore"
        
        NetworkTools.requestData(url: urlString) { (result) in
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataDict = resultDict["data"] as? [String : Any] else {return}
            guard let items = dataDict["items"] as? [[String : Any]] else {return}
            
            //没有请求到数据
            if items.count == 0 {
                finish(true)
                return
            }
       
            var tempArr = [GameItem]()
            for item in items {
                tempArr.append(GameItem(dict: item))
            }
            if index == 1 {
                self.gameArr = tempArr
                
                guard let images = dataDict["banners"] as? [[String : Any]] else {return}
                self.cycleImageArr.removeAll()
                for image in images {
                    self.cycleImageArr.append(CycleItem(dict: image))
                }
            }else {
                self.gameArr += tempArr
            }
            
            finish(false)
        }
        
    }
}
