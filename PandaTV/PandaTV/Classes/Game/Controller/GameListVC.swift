//
//  GameCategoryVC.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/4/2.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit
import MJRefresh

private let itemSizeW = screenW / 4
private let itemSizeH = itemSizeW

class GameListVC: ShowBasicVC {
    
    var gamelistvm : GameListVM = GameListVM()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let layout = self.showCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets.zero
    }
}

extension GameListVC {
    override func setUI(){
        view.addSubview(showCollectionView)
    }
}

// MARK: - 数据请求
extension GameListVC {
    override func loadData() {
        gamelistvm.requestListData { 
            self.showCollectionView.reloadData()
            self.removeLoadImage()
        }
    }
}

extension GameListVC {
    //控制组header的size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: screenW, height: HeaderFooterViewH)
    }
    
    //控制组footer的size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: itemSizeW, height: itemSizeH)
    }
    
    //返回组数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return gamelistvm.listItems.count
    }
    
    //返回每组的行数
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let listItem = gamelistvm.listItems[section]
        return listItem.thundImageItems.count
    }
    
    //设置头尾控件
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let item = gamelistvm.listItems[indexPath.section]

        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCell, for: indexPath) as! HeaderCell
        
        cell.gameName.text = item.cname
        
        return cell

    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let itemGroup = gamelistvm.listItems[indexPath.section]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: thundimageCell, for: indexPath) as! GameThumbImageCell

        cell.item = itemGroup.thundImageItems[indexPath.item]
        
        return cell
    }
}

