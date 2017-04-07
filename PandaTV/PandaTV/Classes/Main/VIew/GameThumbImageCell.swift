//
//  GameThumbImageCell.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/3/31.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit
import Kingfisher

class GameThumbImageCell: UICollectionViewCell {
    @IBOutlet weak var gameImage: UIImageView!
    
    @IBOutlet weak var gameName: UILabel!
    var item : ThundImageItem? {
        didSet {
            guard let item = item else {return}
            guard let img = item.img else {return}
            
            let url = URL(string: img)
            gameImage.kf.setImage(with: ImageResource(downloadURL: url!))
            
            gameName.text = item.title ?? item.cname
        }
    }
}
