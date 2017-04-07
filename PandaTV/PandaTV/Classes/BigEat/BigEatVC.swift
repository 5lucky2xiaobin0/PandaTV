//
//  BigEatVC.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/4/5.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit
import WebKit

class BigEatVC: UIViewController {
    
    lazy var eatView : WKWebView = {
        let webview = WKWebView(frame: CGRect(x: 0, y: titleViewH, width: screenW, height: screenH - titleViewH - tabBarH))
        return webview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false

        //设置UI
        setUI()
        
        //加载数据
        loadData()
    }

}

// MARK: - 设置UI
extension BigEatVC {
    func setUI() {
        view.addSubview(eatView)
    }
}
// MARK: - 加载数据
extension BigEatVC {
    func loadData(){
        let request = URLRequest(url: URL(string: "http://daweiwang.pgc.panda.tv/h5?__version=3.0.3.3076&__plat=ios&__channel=appstore")!)
        eatView.load(request)
    }
}
