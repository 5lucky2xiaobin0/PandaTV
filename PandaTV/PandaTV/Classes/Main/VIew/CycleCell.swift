//
//  CycleCell.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/3/25.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit
import Kingfisher

class CycleCell: UICollectionViewCell {
    @IBOutlet weak var comImage: UIImageView!
    
    var item : CycleItem? {
        didSet {
            guard let item = item else {return}
            var url : URL?
            if var img = item.img {
                if img.contains("https") {
                    img = img.replacingOccurrences(of: "https", with: "http")
                }
                url = URL(string: img)
            }else {
                url = URL(string: item.bigimg!)
            }
            
            comImage.kf.setImage(with: ImageResource(downloadURL: url!))
        }
    }
    
}
