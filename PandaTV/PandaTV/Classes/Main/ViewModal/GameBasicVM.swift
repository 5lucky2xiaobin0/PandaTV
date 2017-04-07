//
//  GameBasicVM.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/3/25.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit

class GameBasicVM: NSObject {
    
    //轮播--热门游戏数据  只有一组
    var thundcycleitem : ThundCycleItem?
    
    //首页直播推荐数据  一共13组
    var liveItems : [LiveItem] = [LiveItem]()
    
    //首页熊猫星颜数据
    var showItems : [ShowItem] = [ShowItem]()
    
    //首页所有游戏
    var allGames : [GameItem] = [GameItem]()
    
    //请求轮播数据
    func requestCommendCycle(searchPath : String?, finish : @escaping () -> ()) {
        var urlString : String
        
        //首页的轮播数据和其他页面的url不同,判断是否有传入页面标识
        if let path = searchPath {
            urlString = "http://api.m.panda.tv/index.php?method=slider.cate&cate=\(path)&__plat=ios&__version=3.0.4.3078&__plat=ios&__channel=appstore"
        }else {
           urlString = "http://api.m.panda.tv/?method=slider.cate&cate=index&__version=3.0.4.3078&__plat=ios&__channel=appstore"
        }
        
        NetworkTools.requestData(url: urlString) { (result) in
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataDict = resultDict["data"] as? [String : Any] else {return}
            
            self.thundcycleitem = ThundCycleItem(dict: dataDict)
            
            finish()
        }
    }
    
    //请求首页推荐游戏数据
    func requestCommendGame(finish : @escaping () -> ()) {
        self.liveItems.removeAll()
        self.showItems.removeAll()
        
        let gameUrl = "http://api.m.panda.tv/?method=card.list&cate=index&__version=3.0.4.3078&__plat=ios&__channel=appstore"
        

        let group = DispatchGroup()
        
        group.enter()
        NetworkTools.requestData(url: gameUrl) { (result) in
            guard let resultDict = result as? [String : Any] else {return}
            guard var dataArr = resultDict["data"] as? [[String : Any]] else {return}
            
            //删除(猜你喜欢)项
            dataArr.remove(at: 1)
            for dataDict in dataArr {
               self.liveItems.append(LiveItem(dict: dataDict))
            }
            group.leave()
        }
    
        let showUrl = "http://m.api.xingyan.panda.tv/room/index?guid=5E67C26FA96E4148B6567DFD153F718E&__version=3.0.4.3078&__plat=ios&__channel=appstore"

        group.enter()
        NetworkTools.requestData(url: showUrl) { (result) in
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataArrDict = resultDict["data"] as? [String : Any] else {return}
            guard let dataDict = dataArrDict["items"] as? [[String : Any]] else {return}
            for data in dataDict {
                self.showItems.append(ShowItem(dict: data))
            }
            group.leave()
        }
       
        group.notify(queue: DispatchQueue.main) {
            self.liveItems[1].showItem += self.showItems
            finish()
        }
    }
    
    //请求首页所有游戏数据
    func requestAllGame(index : Int,finish : @escaping (_ haveData : Bool) -> ()) {
        let urlString = "http://api.m.panda.tv/ajax_live_lists?pageno=\(index)&pagenum=10&order=person_num&status=2&banner=1&__version=3.0.1.3025&__plat=ios&__channel=appstore"
        
        NetworkTools.requestData(url: urlString) { (result) in
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataDict = resultDict["data"] as? [String : Any] else {return}
            guard let itemArr = dataDict["items"] as? [[String : Any]] else {return}
            
            //没有请求到数据
            if itemArr.count == 0 {
                finish(false)
                return
            }
            
            var tempArr = [GameItem]()
            for item in itemArr {
                tempArr.append(GameItem(dict: item))
            }
            if index == 1 {
                self.allGames = tempArr
            }else {
                self.allGames += tempArr
            }
            
            finish(true)
            
        }
    }
  
    //请求游戏数据
    func requestGameData(searchPath : String, finish : @escaping () -> ()) {
        
        let urlString = "http://api.m.panda.tv/index.php?method=card.list&cate=\(searchPath)&__version=3.0.2.3045&__plat=ios&__channel=appstore"
        
        NetworkTools.requestData(url: urlString) { (result) in
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataArr = resultDict["data"] as? [[String : Any]] else {return}
            
            for dataDict in dataArr {
                let itemArr = (dataDict["items"]) as! [[String : Any]]
                if itemArr.count == 0 {
                    continue
                }
                self.liveItems.append(LiveItem(dict: dataDict))
            }
            
            finish()
        }
        
    }
    
    

}
