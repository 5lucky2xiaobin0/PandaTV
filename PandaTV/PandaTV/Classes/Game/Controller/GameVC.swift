//
//  GameVC.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/3/24.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit

class GameVC: UIViewController {
    
    let gamevm : GameVM = GameVM()
    var titles : [TitleItem] = [TitleItem]()
    var titleView : TitleView?
    lazy var ContentGameVC : ContentView = {
        let typeVC = GameListVC()
        var childVCs = [UIViewController]()
        childVCs.append(typeVC)
        var index = 0
        for titles in self.titles {
            if index > 0 {
                let vc = GameTypeVC()
                vc.searchPath = titles.ename
                childVCs.append(vc)
            }
            index += 1
        }
      
        let contentChildVC = ContentView(frame: CGRect(x: 0, y: titleViewH, width: screenW, height: screenH - titleViewH - tabBarH), views: childVCs)
        
        contentChildVC.delegate = self
        
        return contentChildVC
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = UIColor.white
        
        automaticallyAdjustsScrollViewInsets = false
        
        //先设置2组固定数据
        let categoryDict: [String : Any] = ["cname" : "分类", "ename" : ""]
        let hotDict: [String : Any] = ["cname" : "热门", "ename" : "game_hot"]
        titles.append(TitleItem(dict: categoryDict))
        titles.append(TitleItem(dict: hotDict))

        //加载数据
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

extension GameVC {
    func setUI() {
        //添加顶部选择界面
        titleView = TitleView(frame: CGRect(x: 0, y: 0, width: screenW, height: titleViewH), titleArr: self.titles)
        titleView?.delegate = self
        view.addSubview(titleView!)
        //添加内容界面
        view.addSubview(ContentGameVC)
    }
}

extension GameVC {
    func loadData() {
        gamevm.requestTitleData {
            self.titles += self.gamevm.titles
            self.setUI()
        }
    }
}

extension GameVC : ContentViewDelegate {
    func contentViewScrollTo(index: Int) {
        titleView?.scrollToTitle(index: index)
    }
}

extension GameVC : TitleViewDelegate {
    func titleViewScrollTo(index: Int) {
        ContentGameVC.scrollToView(index: index)
    }
}
