//
//  AllGameVC.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/4/6.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit
import MJRefresh

class AllGameVC: GameBasicVC {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
   
         commendView.contentInset = UIEdgeInsets.zero
    }
}

// MARK: - 设置UI
extension AllGameVC {
    override func setUI() {
        view.addSubview(commendView)
        
        commendView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadData))
        
        commendView.mj_footer = MJRefreshAutoFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
        
    }
}

// MARK: - 数据请求
extension AllGameVC {
    override func loadData(){
        index = 1
        gameBasicItem.requestAllGame(index : index) {_ in
            self.commendView.mj_header.endRefreshing()
            self.commendView.reloadData()
            self.removeLoadImage()

            self.index+=1
        }
    }
    
    func loadMoreData(){
        gameBasicItem.requestAllGame(index : index) {_ in
            self.commendView.mj_footer.endRefreshing()
            self.commendView.reloadData()
            self.index+=1
        }
    }

}

// MARK: - 代理方法,数据源
extension AllGameVC {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: screenW, height: gameItemMargin)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameBasicItem.allGames.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameCell, for: indexPath) as! GameCell
        
        let item = gameBasicItem.allGames[indexPath.item]
        
        cell.gameItem = item
        
        return cell
    }
}

