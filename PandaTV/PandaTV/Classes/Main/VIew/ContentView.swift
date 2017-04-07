//
//  ContentView.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/3/24.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit

fileprivate let cellID = "cellID"

protocol ContentViewDelegate : class {
    func contentViewScrollTo(index : Int)
}


// MARK: - 系统回调
class ContentView: UIView {
    weak var delegate : ContentViewDelegate?
    var views : [UIViewController]
    lazy var gameContentView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal

        let contentView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        contentView.isPagingEnabled = true
        contentView.showsVerticalScrollIndicator = false
        contentView.showsHorizontalScrollIndicator = false
        contentView.bounces = false
        
        contentView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: cellID)
        
        contentView.dataSource = self
        contentView.delegate = self
        
        return contentView
    }()
    
    init(frame: CGRect, views : [UIViewController]) {
        self.views = views
        
        super.init(frame: frame)
        //设置界面
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        let indexpath = IndexPath(item: 1, section: 0)
        gameContentView.scrollToItem(at: indexpath, at: .left, animated: false)
    }
}

// MARK: - 界面设置
extension ContentView {
    fileprivate func setUI(){
        addSubview(gameContentView)
        gameContentView.frame = self.bounds
    }
}

// MARK: - 代理方法
extension ContentView : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return views.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVC = views[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / screenW
        delegate?.contentViewScrollTo(index: Int(index))
    }
    
    func scrollToView(index: Int) {
        let indexpath = IndexPath(item: index, section: 0)
        gameContentView.scrollToItem(at: indexpath, at: .left, animated: false)
    }
}
