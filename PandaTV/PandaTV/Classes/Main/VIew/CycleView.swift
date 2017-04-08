//
//  CycleView.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/3/25.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit

private let cycleCell = "cycleCell"

class CycleView: UIView {

    @IBOutlet weak var scrollView: UICollectionView!

    @IBOutlet weak var pageCon: UIPageControl!
    
    var items : [CycleItem]? {
        didSet {
            guard let image = items else {return}
            if image.count == 0 {return}
            
            pageCon.numberOfPages = image.count
            scrollView.reloadData()

            //默认滚动到中间
            let indexpath = IndexPath(item: image.count * 20, section: 0)
            scrollView.scrollToItem(at: indexpath, at: .left, animated: false)
            
            removeToScroll()
            if image.count > 1 {
                pageCon.isHidden = false
                addTimeToScroll()
            }else{
                pageCon.isHidden = true
            }
        }
    }
    
    var time : Timer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = UIViewAutoresizing()
        
        scrollView.register(UINib(nibName: "CycleCell", bundle: nil), forCellWithReuseIdentifier: cycleCell)
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 设置collectionView的layout
        let layout = scrollView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = scrollView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
    }
    
    
    static func  getView() -> CycleView {
        return Bundle.main.loadNibNamed("CycleView", owner: nil, options: nil)?.first as!CycleView
    }
}

// MARK: - 事件处理
extension CycleView {
    func addTimeToScroll() {
        time = Timer(timeInterval: 3, target: self, selector: #selector(timeToScroll), userInfo: nil, repeats: true)
        RunLoop.main.add(time!, forMode: RunLoopMode.commonModes)
    }
    
    func removeToScroll() {
        time?.invalidate()
        time = nil
    }
    
    @objc fileprivate func timeToScroll(){
       var x = scrollView.contentOffset.x
        x += scrollView.bounds.width
        scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
}

// MARK: - collectionView 数据源和代理
extension CycleView : UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (items?.count ?? 0) * 2000
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cycleCell, for: indexPath) as! CycleCell
        
        cell.item = items?[indexPath.item%(items?.count)!]
        
        return cell
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        // 2.计算pageControl的currentIndex
        pageCon.currentPage = Int(offsetX / scrollView.bounds.width) % (items?.count ?? 1)

    }
    
    //手动拖拽时停止定时器
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeToScroll()
    }
    
    //滚动结束开启定时器
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimeToScroll()
    }
    
}
