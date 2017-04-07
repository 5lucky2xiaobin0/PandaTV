//
//  IndexTitleView.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/3/24.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit

private let titleVCW : CGFloat = 240
private let titleVCH : CGFloat = 40
private let titleButtonW : CGFloat = 55
private let titleButtonH : CGFloat = 32

protocol IndexTitleViewDetegate : class {
    func indexTitleView(index : Int)
}

class IndexTitleView: UIView {
    weak var delegate : IndexTitleViewDetegate?
    var selected : UIButton?
    var titles : [String]?
    var line : UIView = UIView()
    var titleVC : UIView = UIView()
    var titleBtns : [UIButton] = [UIButton]()
    lazy var searchBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named : "search_new"), for: .normal)
        
        return btn
    }()
    
    init(frame: CGRect, titles : [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        //界面设置
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension IndexTitleView {
    fileprivate func setUI(){
        //添加查询按钮
        self.addSubview(searchBtn)
        
        //添加标题框
        setTitleChooseView()
    }
    
    func setTitleChooseView(){
        let x = (self.bounds.width - titleVCW)/2
        let y = self.bounds.height - titleVCH
        
        titleVC.frame = CGRect(x: x, y: y, width: titleVCW, height: titleVCH)
        
        self.addSubview(titleVC)
   
        //添加底部线段
        line.frame = CGRect(x: 0, y: titleVC.bounds.height - 2, width: titleButtonW, height: 2)
        line.backgroundColor = UIColor.getGreenColor()
        titleVC.addSubview(line)
        
        var titleX : CGFloat = 0
        
        var i : CGFloat = 0

        
        //添加标题按钮
        for title in titles! {
            
            titleX = i * titleButtonW + (i+1) * 15
            
            let titleButton = UIButton(frame: CGRect(x: titleX, y: 4, width: titleButtonW, height: titleButtonH))
            titleButton.setTitle(title, for: .normal)
            titleButton.setTitleColor(UIColor.black, for: .normal)
            titleButton.setTitleColor(UIColor.getGreenColor(), for: .selected)
            titleButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            titleButton.tag = Int(i)
            titleButton.addTarget(self, action: #selector(titleClick(btn:)), for: .touchUpInside)
            
            if i == 1 {
                titleClick(btn: titleButton)
            }
            
            titleBtns.append(titleButton)
            
            titleVC.addSubview(titleButton)
            
            i+=1
        }
    }
    
    override func layoutSubviews() {
        let x = self.bounds.width - 52
        let y = self.bounds.height - 35
            
        searchBtn.frame = CGRect(x: x, y: y, width: 32, height: 32)
    }
}

// MARK: - 事件处理
extension IndexTitleView {
    @objc fileprivate func titleClick(btn : UIButton) {
        self.selected?.isSelected = false
        btn.isSelected = true
        self.selected = btn
        
        UIView.animate(withDuration: 0.2) {
            self.line.frame = CGRect(x: btn.frame.origin.x, y: self.titleVC.bounds.height - 2, width: titleButtonW, height: 2)
        }
    
        delegate?.indexTitleView(index: btn.tag)
    }
    
    
    func scrollToTitle(index : Int) {
        let btn = titleBtns[index]
        titleClick(btn: btn)
    }
}
