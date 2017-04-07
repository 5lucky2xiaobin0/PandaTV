//
//  CommendGameView.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/3/31.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit

class GameHotView: UIView {
    
    @IBOutlet weak var gameView: UICollectionView!
    var items : [ThundImageItem]? {
        didSet {
            gameView.reloadData()
        }
    }
    
    static func getView() -> GameHotView{
        return Bundle.main.loadNibNamed("GameHotView", owner: nil, options: nil)?.first as!GameHotView
    }
 
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = UIViewAutoresizing()
        //注册cell
        gameView.register(UINib(nibName: "GameThumbImageCell", bundle: nil) , forCellWithReuseIdentifier: thundimageCell)
        
        gameView.showsVerticalScrollIndicator = false
        gameView.showsHorizontalScrollIndicator = false
        gameView.bounces = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //设置cell大小以及布局
        let layout = gameView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: thundViewW, height: self.bounds.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
    }
}

extension GameHotView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: thundimageCell, for: indexPath) as! GameThumbImageCell
        
        cell.item = items?[indexPath.item]
        
        return cell
    }
}
