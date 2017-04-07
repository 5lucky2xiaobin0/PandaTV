//
//  ShowXYanVC.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/4/5.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit
import MJRefresh

class ShowXYanVC: ShowBasicVC {
    
    var showxyanvm : ShowXYanVM = ShowXYanVM()

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        showCollectionView.contentInset = UIEdgeInsets(top: cycleViewH, left: 0, bottom: 0, right: 0)
    }
}

extension ShowXYanVC {
    override func setUI(){
        showCollectionView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadData))
        
        showCollectionView.mj_header.ignoredScrollViewContentInsetTop = cycleViewH
        
        view.addSubview(showCollectionView)
        
        showCollectionView.addSubview(scrollImageView)
    }

}

extension ShowXYanVC {
    override func loadData() {
        showxyanvm.requestShowData { _ in
            self.showCollectionView.mj_header.endRefreshing()
            self.scrollImageView.items = self.showxyanvm.cycleImageArr
            self.showCollectionView.reloadData()
            self.removeLoadImage()
        }
    }
}


extension ShowXYanVC {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: gameItemW, height: showItemH)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.showxyanvm.showArr.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: showCell, for: indexPath) as! ShowCell
        
        cell.showItem = showxyanvm.showArr[indexPath.item]
        
        return cell
    }
}
