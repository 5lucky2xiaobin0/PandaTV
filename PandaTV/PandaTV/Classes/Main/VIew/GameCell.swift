//
//  GameCell.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/3/24.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit
import Kingfisher

class GameCell: UICollectionViewCell {

    @IBOutlet weak var nowImage: UIImageView!
    
    @IBOutlet weak var gameTitle: UILabel!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var personNumber: UIButton!
    
    @IBOutlet weak var gamename: UIButton!
    
    var card_type : String?
    
    var gameItem : GameItem? {
        didSet {
            if let item = gameItem {
                var url : URL?
                
                if let urlString = item.img {
                    url = URL(string: urlString)
                }else {
                    let urlString = item.pictures?["img"] as! String
                    url = URL(string: urlString)
                }
                nowImage.kf.setImage(with: ImageResource(downloadURL: url!))
                
                gameTitle.text = item.title ?? item.name
                
                username.text = item.userItem?.nickName
                if item.person_num > 10000 {
                    let number = CGFloat(item.person_num) / 10000.0
                    personNumber.setTitle(String(format: "%.1f", number) + "万", for: .normal)
                }else {
                    personNumber.setTitle("\(item.person_num)", for: .normal)
                }
                
                //1  首页      card_type = cateroomlist       不显示
                //2  全部游戏   cart_type = nil                不显示
                //3  游戏界面   cart_type = cateroomlist       不显示
                //4  娱乐界面   cart_type = cateroomlist       不显示
                
                
                if card_type == "cateroomlist" || card_type == nil {
                    gamename.isHidden = true
                }else {
                    gamename.isHidden = false
                    gamename.setTitle(item.gameType, for: .normal)
                }
            }

        }
    }
}
