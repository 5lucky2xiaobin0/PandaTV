//
//  CommendVC.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/3/24.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit
import MJRefresh

class CommendVC: GameBasicVC {
    
    override func viewDidLayoutSubviews() {
        let layout = commendView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: gameItemW, height: gameItemH)
        
        commendView.frame = self.view.bounds
    }

}

// MARK: - 数据请求
extension CommendVC {
    override func loadData() {
        //加载数据
        gameBasicItem.requestCommendGame {
            if (self.gameBasicItem.thundcycleitem?.cycleItems.count)! == 0 {
                self.scrollImageView.isHidden = true
                self.commendView.contentInset = UIEdgeInsets(top: thundViewH, left: 0, bottom: 0, right: 0)
                self.commendView.mj_header.ignoredScrollViewContentInsetTop = thundViewH
            }else {
                self.scrollImageView.isHidden = false
                self.scrollImageView.items = self.gameBasicItem.thundcycleitem?.cycleItems
                self.commendView.contentInset = UIEdgeInsets(top: cycleViewH + thundViewH, left: 0, bottom: 0, right: 0)
                self.commendView.mj_header.ignoredScrollViewContentInsetTop = cycleViewH + thundViewH
            }
            //设置推荐游戏数据
            self.gameView.items = self.gameBasicItem.thundcycleitem?.thundimages
            self.commendView.reloadData()
            self.commendView.mj_header.endRefreshing()
            self.removeLoadImage()
        }
    }
}

// MARK: - 推荐页面游戏数据源,代理
extension CommendVC{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return gameBasicItem.liveItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let liveitem = gameBasicItem.liveItems[section]
        
        if section == 1 {
            return liveitem.showItem.count
        }else {
            return liveitem.gameItem.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: screenW, height: HeaderFooterViewH)
    }
    
    //控制组footer的size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: screenW, height: 15)
        }else {
            return CGSize(width: screenW, height: HeaderFooterViewH)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1{
            return CGSize(width: gameItemW, height: showItemH)
        }else {
            return CGSize(width: gameItemW, height: gameItemH)
        }
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
            
            if indexPath.section == 0 {
                cell.moreData.isHidden = true
            }else {
                cell.moreData.isHidden = false
            }
            
            if let total = item.total {
                cell.moreData.text = "全部\(total)个直播 >"
            }else {
                cell.moreData.text = "查看更多 >"
            }
            
            return cell
        }
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let itemGroup = gameBasicItem.liveItems[indexPath.section]
        
        if indexPath.section == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: showCell, for: indexPath) as! ShowCell
            
            cell.showItem = itemGroup.showItem[indexPath.item]
            
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameCell, for: indexPath) as! GameCell
            
            cell.card_type = itemGroup.card_type
            cell.gameItem = itemGroup.gameItem[indexPath.item]
            
            return cell
        }
    }
}
