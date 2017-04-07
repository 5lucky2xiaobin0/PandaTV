//
//  HomeVC.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/3/24.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    lazy var titleView : IndexTitleView = {
        let titles = ["订阅","推荐","全部"]

        let titleView = IndexTitleView(frame: CGRect(x: 0, y: 0, width: screenW, height: titleViewH), titles: titles)
        
        titleView.backgroundColor = UIColor.white
        titleView.delegate = self
        
        return titleView
    }()
    
    
    lazy var liveContentView : ContentView = {
        //创建子控制器----订阅.推荐.全部
        let takeVC = UIStoryboard(name: "TakeVC", bundle: nil).instantiateInitialViewController()
        let commendVC = CommendVC()
        let allGameVC = AllGameVC()
    
        let childs = [takeVC,commendVC,allGameVC]
        
        let liveVC = ContentView(frame: CGRect(x: 0, y: titleViewH, width: screenW, height: screenH - titleViewH - tabBarH), views: childs as! [UIViewController])
        
        liveVC.backgroundColor = UIColor.white
        liveVC.delegate = self
        
        return liveVC
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        setUI()
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

// MARK: - 界面设置
extension HomeVC {
    fileprivate func setUI(){
        view.addSubview(liveContentView)
        view.addSubview(titleView)
    }
}

// MARK: - ContentViewDelegate
extension HomeVC : ContentViewDelegate, IndexTitleViewDetegate {
    func contentViewScrollTo(index: Int) {
        titleView.scrollToTitle(index: index)
    }
    
    func indexTitleView(index: Int) {
        liveContentView.scrollToView(index: index)
    }
}
