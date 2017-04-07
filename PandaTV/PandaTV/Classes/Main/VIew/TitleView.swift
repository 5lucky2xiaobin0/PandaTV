//
//  TitleView.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/4/1.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit

private let GameTitleCellID = "GameTitleCellID"
private let lineH : CGFloat = 2

protocol TitleViewDelegate : class {
    func titleViewScrollTo(index : Int)
}

class TitleView: UIView {
    
    weak var delegate : TitleViewDelegate?
 
    var lineOfSetX : CGFloat = 0
    
    var titleArr : [TitleItem]
    
    var selectorBtn : UIButton?
    
    var titleBtnS : [UIButton] = [UIButton]()
    
    lazy var titleContentView : UIScrollView = UIScrollView()
    
    lazy var titleLineView : UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.getGreenColor()
        return lineView
    }()
    
    init(frame: CGRect, titleArr : [TitleItem]) {
        
        self.titleArr = titleArr
        
        super.init(frame: frame)
        
        setUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TitleView {
    func setUI() {
        //添加内部控件
        setTitleContentView()
        
        //添加底部划线
        setTitleLineView()
    }
    
    func setTitleContentView() {
        addSubview(titleContentView)
        
        var index = 0
        var x = 0
        var width = 0
        for title in titleArr {
            let length = title.cname?.lengthOfBytes(using: String.Encoding.utf8)
            
            x += width
            
            width = length! * 5 + 20
            
            //创建button
            let btn = UIButton()
            btn.setTitle(title.cname, for: .normal)
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.setTitleColor(UIColor.getGreenColor(), for: .selected)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btn.addTarget(self, action: #selector(titleClick(btn:)), for: .touchUpInside)
            btn.sizeToFit()
            btn.frame = CGRect(x: x, y: Int(self.bounds.height - 34), width: width, height: 32)
            titleContentView.addSubview(btn)
            btn.tag = index
            
            if index == 1 {
                titleClick(btn: btn)
            }
            
            titleBtnS.append(btn)
            index += 1
        }
        
        titleContentView.delegate = self
        titleContentView.isPagingEnabled = true
        titleContentView.showsVerticalScrollIndicator = false
        titleContentView.showsHorizontalScrollIndicator = false
        titleContentView.frame = self.bounds
        titleContentView.contentSize = CGSize(width: x + width, height: 0)
    }
    
    func setTitleLineView() {
        addSubview(titleLineView)
        //得到当前选中的按钮
        if titleBtnS.count > 1 {
            let sButton = titleBtnS[1]

            sButton.titleLabel?.sizeToFit()
            let x = sButton.getX() + (sButton.getWidth() - (sButton.titleLabel?.getWidth())!)/2
            titleLineView.frame = CGRect(x: x, y: bounds.height - lineH, width: (sButton.titleLabel?.getWidth())!, height: 2)
        }
    }
}

// MARK: - 事件处理
extension TitleView {
    func titleClick(btn : UIButton) {
        selectorBtn?.isSelected = false
        btn.isSelected = true
        selectorBtn = btn
        
        //选中按钮滑动到中间
        var offsetX = btn.getCenterX() - screenW / 2;
        
        if offsetX < 0 {
            offsetX = 0;
        }else if offsetX > self.titleContentView.contentSize.width - screenW{
            offsetX =  self.titleContentView.contentSize.width - screenW;
        }
        
        titleContentView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        
        let Lasttag = selectorBtn?.tag ?? 0
        let time = (CGFloat)(btn.tag - Lasttag + 1) * 0.2
        UIView.animate(withDuration: TimeInterval(time)) {
            self.titleLineView.width(NewWidth: (btn.titleLabel?.getWidth())!)
            self.titleLineView.centerX(NewCenterX: btn.getCenterX() - offsetX)
        }
        
        //通知代理滑动内容界面
        delegate?.titleViewScrollTo(index: btn.tag)
    }
    
    
    func scrollToTitle(index : Int) {
        let btn = self.titleBtnS[index]
        titleClick(btn: btn)
    }
}


// MARK: - 标题栏滑动监听UICollectionViewDelegate
extension TitleView : UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.titleLineView.centerX(NewCenterX: (selectorBtn?.getCenterX())! - scrollView.contentOffset.x)
    }
}
