//
//  ShowVC.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/3/24.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit

class ShowVC: UIViewController {
    
    var showvm : ShowVM = ShowVM()
    var titleView : TitleView?
    
    
    lazy var ContentGameVC : ContentView = {
        var childVCs = [UIViewController]()
        var index = 0

        for titles in self.showvm.titles {
            switch index {
            case 0:
                let xmxxVC = ShowTypeCycleVC()
                xmxxVC.showTypeName = titles.ename
                childVCs.append(xmxxVC)
            case 1:
                let showhotvc = ShowHotVC()
                childVCs.append(showhotvc)
            case 2:
                let xmxyVC = ShowXYanVC()
                childVCs.append(xmxyVC)
            case 3:
                let xmxxVC = ShowTypeCycleVC()
                xmxxVC.showTypeName = titles.ename
                childVCs.append(xmxxVC)
            default:
                let showtypevc = ShowTypeVC()
                showtypevc.showTypeName = titles.ename
                childVCs.append(showtypevc)
            }
            index+=1
        }
        
        let contentChildVC = ContentView(frame: CGRect(x: 0, y: titleViewH, width: screenW, height: screenH - titleViewH - tabBarH), views: childVCs)
        
        contentChildVC.delegate = self
        
        return contentChildVC
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        
        view.backgroundColor = UIColor.white
        
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

// MARK: - UI设置
extension ShowVC {
    func setUI() {
        titleView = TitleView(frame: CGRect(x: 0, y: 0, width: screenW, height: titleViewH), titleArr: showvm.titles)
        titleView?.delegate = self
        view.addSubview(titleView!)
        
        view.addSubview(ContentGameVC)
    }
}

// MARK: - 数据请求
extension ShowVC {
    func loadData() {
        showvm.loadTitleType {
            let title = TitleItem(dict: ["cname":"热门","ename":"yule_hot"])
            self.showvm.titles.insert(title, at: 1)
            self.setUI()
        }
    }
}

extension ShowVC : ContentViewDelegate {
    func contentViewScrollTo(index: Int) {
        titleView?.scrollToTitle(index: index)
    }
}

extension ShowVC : TitleViewDelegate {
    internal func titleViewScrollTo(index: Int) {
         ContentGameVC.scrollToView(index: index)
    }
}
