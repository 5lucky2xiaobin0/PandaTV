//
//  ShowTypeCycleVC.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/4/5.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit
import MJRefresh

class ShowTypeCycleVC: ShowBasicVC {

    var showTypeName : String?
    var showtypecyclevm : ShowTypeCycleVM = ShowTypeCycleVM()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        showCollectionView.contentInset = UIEdgeInsets(top: cycleViewH, left: 0, bottom: 0, right: 0)
    }
}

extension ShowTypeCycleVC {
    override func setUI(){
        showCollectionView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadData))
        
        showCollectionView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
        
        showCollectionView.mj_header.ignoredScrollViewContentInsetTop = cycleViewH
        
        view.addSubview(showCollectionView)
        
        showCollectionView.addSubview(scrollImageView)
    }
}

extension ShowTypeCycleVC {
    override func loadData() {
        index = 1
        showtypecyclevm.requestData(searchPath: showTypeName!, index : index) { _ in
            self.showCollectionView.mj_header.endRefreshing()
            //判断是否有轮播图片
            if self.showtypecyclevm.cycleImageArr.count == 0 {
                self.scrollImageView.isHidden = true
                self.showCollectionView.contentInset = UIEdgeInsets.zero
                self.showCollectionView.mj_header.ignoredScrollViewContentInsetTop = 0
            }else {
                self.scrollImageView.isHidden = false
                self.showCollectionView.contentInset = UIEdgeInsets(top: cycleViewH, left: 0, bottom: 0, right: 0)
                self.showCollectionView.mj_header.ignoredScrollViewContentInsetTop = cycleViewH
                self.scrollImageView.items = self.showtypecyclevm.cycleImageArr
            }

            self.showCollectionView.reloadData()
            self.index+=1
            self.showCollectionView.mj_footer.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: {
                self.removeLoadImage()
            })
        }
    }
    
    override func loadMoreData() {
        showtypecyclevm.requestData(searchPath: showTypeName!, index : index) { (noData) in
            if noData {
                self.showCollectionView.mj_footer.endRefreshingWithNoMoreData()
                self.showCollectionView.mj_footer.isHidden = true
            }else {
                self.showCollectionView.mj_footer.endRefreshing()
                self.showCollectionView.reloadData()
                self.index+=1
            }
        }

    }
}

extension ShowTypeCycleVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return showtypecyclevm.gameArr.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameCell, for: indexPath) as! GameCell
        
        let item = showtypecyclevm.gameArr[indexPath.item]
        
        cell.gameItem = item
        
        return cell
    }

}
