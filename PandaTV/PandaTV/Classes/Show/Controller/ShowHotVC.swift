//
//  ShowHotVC.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/4/6.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit
import MJRefresh

class ShowHotVC: ShowBasicVC {
    var showhotvm : ShowHotVM = ShowHotVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.red
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        showCollectionView.contentInset = UIEdgeInsets(top: cycleViewH, left: 0, bottom: 0, right: 0)
        
        let layout = showCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize(width: screenW, height: HeaderFooterViewH)
        layout.footerReferenceSize = CGSize(width: screenW, height: HeaderFooterViewH)
    }
    

}

extension ShowHotVC {
    override func setUI(){
        showCollectionView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadData))
        
        showCollectionView.mj_header.ignoredScrollViewContentInsetTop = cycleViewH
        
        view.addSubview(showCollectionView)
        
        showCollectionView.addSubview(scrollImageView)
    }
}

extension ShowHotVC {
    override func loadData() {
        let group = DispatchGroup()
        
        group.enter()
        showhotvm.requestCycleData { 
            self.scrollImageView.items = self.showhotvm.cycleItem
            group.leave()
        }
        
        group.enter()
        showhotvm.requestHotData { 
            self.showCollectionView.reloadData()
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            self.showCollectionView.mj_header.endRefreshing()
            self.removeLoadImage()
        }
    }
}

extension ShowHotVC {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return showhotvm.liveItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let liveItem = showhotvm.liveItems[indexPath.section]
        
        if liveItem.card_type == "xingyan" {
            return CGSize(width: gameItemW, height: showItemH)
        }else {
            return CGSize(width: gameItemW, height: gameItemH)
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let liveItem = showhotvm.liveItems[section]
        
        if liveItem.card_type == "xingyan" {
            return liveItem.showItem.count
        }else {
            return liveItem.gameItem.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let itemGroup = showhotvm.liveItems[indexPath.section]
        
        if itemGroup.card_type == "xingyan" {
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
    
    //设置头尾控件
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let item = showhotvm.liveItems[indexPath.section]
        
        if kind == UICollectionElementKindSectionHeader {
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCell, for: indexPath) as! HeaderCell
            
            cell.gameName.text = item.card_title
            
            return cell
            
        }else {
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerCell, for: indexPath) as! FooterCell
            
            if let total = item.total {
                cell.moreData.text = "全部\(total)个直播 >"
            }else {
                cell.moreData.text = "查看更多 >"
            }
            
            return cell
        }
        
    }

}
