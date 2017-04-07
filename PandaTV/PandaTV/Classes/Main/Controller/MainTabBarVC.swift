//
//  MainTabBarVC.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/3/24.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit

class MainTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVC(vc: HomeVC(), title: "首页", nImage: "menu_homepage", sImage: "menu_homepage_sel")
        
        addChildVC(vc: GameVC(), title: "游戏", nImage: "menu_youxi", sImage: "menu_youxi_sel")
        
        addChildVC(vc: ShowVC(), title: "娱乐", nImage: "menu_yule", sImage: "menu_yule_sel")
        
        let bigEatVc = UIStoryboard(name: "BigEatVC", bundle: nil).instantiateInitialViewController()
        addChildVC(vc: bigEatVc!, title: "大胃王", nImage: "menu_bigeat", sImage: "menu_bigeat_sel")
        
        let podFlieVc = UIStoryboard(name: "PodfileVC", bundle: nil).instantiateInitialViewController()
        addChildVC(vc: podFlieVc!, title: "我", nImage: "menu_mine", sImage: "menu_mine_sel")
        
        tabBar.backgroundColor = UIColor.white
    }
}


//界面设置
extension MainTabBarVC {
    fileprivate func addChildVC(vc : UIViewController, title : String, nImage : String, sImage : String){
      
        vc.tabBarItem.image = UIImage(named: nImage)
        vc.tabBarItem.selectedImage = UIImage(named: sImage)
        vc.title = title
        let navVC = MainNavVC(rootViewController: vc)
        addChildViewController(navVC)
    }
}
