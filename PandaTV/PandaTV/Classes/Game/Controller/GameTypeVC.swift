//
//  GameTypeVC.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/4/2.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit

class GameTypeVC: GameBasicVC {
    
    var searchPath : String?
}

extension GameTypeVC {
    override func loadData() {
        let group = DispatchGroup()
        if let path = searchPath {
          
            group.enter()
            gameBasicItem.requestCommendCycle(searchPath: path) {
                //设置轮播图片数据
                if (self.gameBasicItem.thundcycleitem?.cycleItems.count)! > 0 {
                    self.scrollImageView.isHidden = false
                    self.scrollImageView.items = self.gameBasicItem.thundcycleitem?.cycleItems
                }else {
                    self.scrollImageView.isHidden = true
                }
                
                //设置推荐游戏数据
                if (self.gameBasicItem.thundcycleitem?.thundimages.count)! > 0 {
                    self.gameView.isHidden = false
                    self.gameView.items = self.gameBasicItem.thundcycleitem?.thundimages
                }else {
                    self.gameView.isHidden = true
                }
                
                group.leave()
            }
            
            group.enter()
            gameBasicItem.requestGameData(searchPath: path, finish: {
                self.commendView.reloadData()
                group.leave()
            })
            
            group.notify(queue: DispatchQueue.main, execute: { 
                self.commendView.mj_header.endRefreshing()
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: {
                    self.removeLoadImage()
                })
            })
        }
    }
}


extension GameTypeVC {
    //控制组header的size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: screenW, height: HeaderFooterViewH)
    }
    
    //控制组footer的size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {

        return CGSize(width: screenW, height: HeaderFooterViewH)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: gameItemW, height: gameItemH)
    }
    
    //返回组数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return gameBasicItem.liveItems.count
    }
    
    //返回每组的行数
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let liveItem = gameBasicItem.liveItems[section]
        return liveItem.gameItem.count
    }
    
    //设置头尾控件
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let item = gameBasicItem.liveItems[indexPath.section]
        
        if kind == UICollectionElementKindSectionHeader {
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCell, for: indexPath) as! HeaderCell
            
            cell.gameName.text = item.card_title
            
            return cell
            
        }else {
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerCell, for: indexPath) as! FooterCell
    
            if item.total != nil {
                cell.moreData.text = "全部\(item.total!)个直播 >"
            }
            
            return cell
        }
    }
        
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let itemGroup = gameBasicItem.liveItems[indexPath.section]
 
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameCell, for: indexPath) as! GameCell
        
        cell.card_type = itemGroup.card_type
        cell.gameItem = itemGroup.gameItem[indexPath.item]
            
        return cell
    }
}

