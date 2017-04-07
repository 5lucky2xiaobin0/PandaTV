//
//  GameBasicVC.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/4/1.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit
import MJRefresh

class GameBasicVC: UIViewController{
    
    var gameBasicItem : GameBasicVM = GameBasicVM()
    
    var index = 0
    
    lazy var loadImageView : LoadImageView = {
        let vc = LoadImageView.getView()
        vc.frame = self.view.bounds
        
        return vc
    }()

    
    lazy var commendView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = gameItemMargin
        layout.minimumInteritemSpacing = gameItemMargin
        layout.sectionInset = UIEdgeInsetsMake(0, gameItemMargin, 0, gameItemMargin)
        
        let gameView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        gameView.register(UINib(nibName: "HeaderCell", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCell)
        gameView.register(UINib(nibName: "FooterCell", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerCell)
        gameView.register(UINib(nibName: "GameCell", bundle: nil), forCellWithReuseIdentifier: gameCell)
        gameView.register(UINib(nibName: "ShowCell", bundle: nil), forCellWithReuseIdentifier: showCell)
        gameView.backgroundColor = UIColor.white
        gameView.showsVerticalScrollIndicator = false
        gameView.showsHorizontalScrollIndicator = false
        
        gameView.dataSource = self
        gameView.delegate = self
        
        return gameView
    }()
    
    //懒加载轮播控件
    lazy var scrollImageView : CycleView = {
        let cycleVC = CycleView.getView()
        cycleVC.frame = CGRect(x: 0, y: -(thundViewH+cycleViewH), width: screenW, height: cycleViewH)
        return cycleVC
    }()
    
    //懒加载推荐游戏控件
    lazy var gameView : GameHotView = {
        let gameVC = GameHotView.getView()
        gameVC.frame  = CGRect(x: 0, y: -thundViewH, width: screenW, height: thundViewH)
        return gameVC
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置ui
        setUI()
        //设置加载图片
        setLoadImage()
        //手动加载数据  第一次直接使用MJRefresh会有个非常别扭的视觉效果
        loadData()
    }
    
    override func viewDidLayoutSubviews() {
        let layout = commendView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: gameItemW, height: gameItemH)
        
        commendView.frame = self.view.bounds
        commendView.contentInset = UIEdgeInsets(top: cycleViewH + thundViewH, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - 设置UI
extension GameBasicVC {
    func setUI(){
        //推荐游戏界面
        view.addSubview(commendView)
        //轮播图片
        commendView.addSubview(scrollImageView)
        //热门游戏
        commendView.addSubview(gameView)
        
        commendView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadData))

        commendView.mj_header.ignoredScrollViewContentInsetTop = cycleViewH + thundViewH
    }
    
    func setLoadImage() {
        view.addSubview(loadImageView)
        loadImageView.startAnimation()
    }
    
    func removeLoadImage() {
        self.loadImageView.stopAnimation()
        self.loadImageView.removeFromSuperview()
    }
}

// MARK: - 请求数据
extension GameBasicVC {
    func loadData() {}
}

extension GameBasicVC : UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameCell, for: indexPath)
        
        
        return cell
    }
}

