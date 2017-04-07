//
//  ShowBasicVC.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/3/24.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit
import MJRefresh

let AcellID = "cellID"

class ShowBasicVC: UIViewController {
    
    var viewItem : ShowBasicVM = ShowBasicVM()
    
    var index = 0
    lazy var loadImageView : LoadImageView = {
        let vc = LoadImageView.getView()
        vc.frame = self.view.bounds
        
        return vc
    }()
    
    lazy var scrollImageView : CycleView = {
        let cycleVC = CycleView.getView()
        cycleVC.frame = CGRect(x: 0, y: -cycleViewH, width: screenW, height: cycleViewH)
        cycleVC.backgroundColor = UIColor.red
        return cycleVC
    }()
    
    lazy var showCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = gameItemMargin
        layout.minimumInteritemSpacing = gameItemMargin
        layout.headerReferenceSize = CGSize(width: screenW, height: gameItemMargin)
        layout.sectionInset = UIEdgeInsetsMake(0, gameItemMargin, 0, gameItemMargin)
        
        let allView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        allView.register(UINib(nibName: "GameCell", bundle: nil), forCellWithReuseIdentifier: gameCell)
        allView.register(UINib(nibName: "ShowCell", bundle: nil), forCellWithReuseIdentifier: showCell)
        allView.register(UINib(nibName: "HeaderCell", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCell)
        allView.register(UINib(nibName: "FooterCell", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerCell)
        allView.register(UINib(nibName: "GameThumbImageCell", bundle: nil) , forCellWithReuseIdentifier: thundimageCell)
        allView.backgroundColor = UIColor.white
        allView.showsVerticalScrollIndicator = false
        allView.showsHorizontalScrollIndicator = false
        
        
        allView.dataSource = self
        allView.delegate = self
      
        return allView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //添加子控件
        setUI()
        //设置加载图片
        setLoadImage()
        //手动加载数据  第一次直接使用MJRefresh会有个非常别扭的视觉效果
        loadData()
    }
    
    override func viewDidLayoutSubviews() {
        let layout = showCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: gameItemW, height: gameItemH)

        showCollectionView.frame = self.view.bounds
    }
}

// MARK: - UI设置
extension ShowBasicVC {
    func setUI(){
        showCollectionView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadData))
        
        showCollectionView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
        
        view.addSubview(showCollectionView)
    }
    
    func setLoadImage() {
        view.addSubview(loadImageView)
        loadImageView.startAnimation()
    }
    
    func removeLoadImage() {
        loadImageView.stopAnimation()
        loadImageView.removeFromSuperview()
    }
}

// MARK: - 加载数据
extension ShowBasicVC {
    func loadData(){

    }
    
    func loadMoreData(){

    }
}

extension ShowBasicVC : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewItem.itemArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameCell, for: indexPath) as! GameCell
        
        let item = viewItem.itemArr[indexPath.item]

        cell.gameItem = item
        
        return cell
    }
    
}
