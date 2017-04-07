//
//  ShowCell.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/3/31.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit
import Kingfisher

class ShowCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UIButton!
    @IBOutlet weak var person: UIButton!
    @IBOutlet weak var title: UILabel!
    var showItem : ShowItem? {
        didSet {
            guard let item = showItem else {return}
            
            if item.avatar != nil {
                let url = URL(string: item.avatar!)
                iconImage.kf.setImage(with: ImageResource(downloadURL: url!))
            }
            name.text = item.nickName
            title.text = item.name
            
            if item.personnum > 10000 {
                let number = CGFloat(item.personnum) / 10000.0
                person.setTitle(String(format: "%.1f", number) + "万", for: .normal)
            }else {
                person.setTitle("\(item.personnum)", for: .normal)
            }
            
            if item.city == "" {
                address.isHidden = true
            }else{
                address.isHidden = false
                address.setTitle(item.city, for: .normal)
            }
            
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
