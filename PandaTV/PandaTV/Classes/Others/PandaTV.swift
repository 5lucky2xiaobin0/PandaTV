//
//  PandaTV.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/4/5.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import Foundation
import UIKit

/*标题栏高度*/
let titleViewH : CGFloat = 64
/*手机界面宽度*/
let screenW : CGFloat = UIScreen.main.bounds.width
/*手机界面高度*/
let screenH : CGFloat = UIScreen.main.bounds.height
/*游戏cell之间间距*/
let gameItemMargin : CGFloat = 12
/*游戏cell宽度*/
let gameItemW : CGFloat = (screenW - 3*gameItemMargin) * 0.5
/*游戏cell高度*/
let gameItemH : CGFloat = gameItemW * 4/5
/*轮播图片view高度*/
let cycleViewH = screenW * 3/8
/*热门游戏view高度*/
let thundViewH : CGFloat = 90
/*热门游戏view宽度*/
let thundViewW : CGFloat = screenW / 4
/*熊猫星颜cell高度*/
let showItemH : CGFloat = gameItemW * 5/4
/*组头\尾高度*/
let HeaderFooterViewH : CGFloat = 40
/*TabBar高度*/
let tabBarH : CGFloat = 49


/*cellID*/
let headerCell = "headerCell"
let footerCell = "footerCell"
let gameCell = "gameCell"
let showCell = "showCell"
let thundimageCell = "thundimageCell"
