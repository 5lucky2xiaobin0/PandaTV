//
//  ShowTypeVC.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/4/3.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit

class ShowTypeVC: ShowBasicVC {
    
    var showTypeName : String?
}

// MARK: - 数据请求
extension ShowTypeVC {
    override func loadData() {
        index = 1
        viewItem.requestShow(showTypeName: showTypeName!, index : index) { _ in
            self.showCollectionView.mj_header.endRefreshing()
            self.showCollectionView.reloadData()
            self.index+=1
            self.showCollectionView.mj_footer.isHidden = false
            self.removeLoadImage()
        }
    }
    
    override func loadMoreData() {
        viewItem.requestShow(showTypeName: showTypeName!, index : index) { (noData) in
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
