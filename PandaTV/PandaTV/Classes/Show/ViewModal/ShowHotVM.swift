//
//  ShowHotVM.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/4/6.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit

class ShowHotVM: NSObject {
    //轮播图片
    var cycleItem : [CycleItem] = [CycleItem]()
    
    //娱乐热门数据
    var liveItems : [LiveItem] = [LiveItem]()
    
    //娱乐热门第二组数据
    var tempArr : [LiveItem] = [LiveItem]()
    
    //首页熊猫星颜数据
    var showItems : [ShowItem] = [ShowItem]()
    
    //首页所有游戏
    var allGames : [GameItem] = [GameItem]()

     /*  yule_hot
     https://api.m.panda.tv/index.php?method=card.list&cate=yule_hot&__version=3.0.4.3078&__plat=ios&__channel=appstore
     
     
     https://m.api.xingyan.panda.tv/room/hotlist?guid=5E67C26FA96E4148B6567DFD153F718E&__plat=ios&__version=3.0.4.3078&__channel=appstore&__version=3.0.4.3078&__plat=ios&__channel=appstore
     */

    
    func requestHotData(finish : @escaping ()->()) {
        var urlString = "http://m.api.xingyan.panda.tv/room/hotlist?guid=5E67C26FA96E4148B6567DFD153F718E&__plat=ios&__version=3.0.4.3078&__channel=appstore&__version=3.0.4.3078&__plat=ios&__channel=appstore"
        
        let group = DispatchGroup()
        
        group.enter()
        NetworkTools.requestData(url: urlString) { (result) in
            guard let resultDict = result as? [String : Any] else {return}
            guard var dataArr = resultDict["data"] as? [[String : Any]] else {return}
            
            dataArr.remove(at: 1)
            for data in dataArr {
                self.liveItems.append(LiveItem(dict: data))
            }
            group.leave()
        }
        
        urlString = "http://api.m.panda.tv/index.php?method=card.list&cate=yule_hot&__version=3.0.4.3078&__plat=ios&__channel=appstore"
        
        group.enter()
        NetworkTools.requestData(url: urlString) { (result) in
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataArr = resultDict["data"] as? [[String : Any]] else {return}
       
            for data in dataArr {
                self.tempArr.append(LiveItem(dict: data))
            }
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            self.liveItems += self.tempArr
            finish()
        }
    }
    
    //加载轮播数据
    func requestCycleData(finish : @escaping ()->()) {
        var urlString = "http://m.api.xingyan.panda.tv/room/list?guid=5E67C26FA96E4148B6567DFD153F718E&pagenum=200&pageno=1&banner=1&__version=3.0.4.3078&__plat=ios&__channel=appstore"
        
        let group = DispatchGroup()
        
        group.enter()
        NetworkTools.requestData(url: urlString) { (result) in
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataDict = resultDict["data"] as? [String : Any] else {return}
            guard let items = dataDict["banners"] as? [[String : Any]] else {return}
            
            for item in items {
                self.cycleItem.append(CycleItem(dict: item))
            }
            group.leave()
        }
        
        urlString = "http://m.api.xingyan.panda.tv/room/hotbanner?guid=5E67C26FA96E4148B6567DFD153F718E&__plat=ios&__version=3.0.4.3078&__channel=appstore&__version=3.0.4.3078&__plat=ios&__channel=appstore"
        
        group.enter()
        NetworkTools.requestData(url: urlString) { (result) in
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataDict = resultDict["data"] as? [String : Any] else {return}
            guard let items = dataDict["banners"] as? [[String : Any]] else {return}
            
            for item in items {
                self.cycleItem.append(CycleItem(dict: item))
            }
            group.leave()

        }
        
        group.notify(queue: DispatchQueue.main) {
            finish()
        }
    }
}
