//
//  LoadImageView.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/4/5.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit

class LoadImageView: UIView {

    @IBOutlet weak var animationView: UIImageView!
    
    lazy var loadImages : [UIImage] = [UIImage]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        var index = 1
        while index < 36 {
            let img = UIImage(named: "\(index)")
            loadImages.append(img!)
            index+=1
        }
        
        animationView.animationImages = loadImages
        animationView.animationRepeatCount = Int.max
        animationView.animationDuration = 2
    }
    
    static func getView() -> LoadImageView {
        return Bundle.main.loadNibNamed("LoadImageView", owner: nil, options: nil)?.first as! LoadImageView
    
    }
    
    func startAnimation() {
        animationView.startAnimating()
    }
    
    func stopAnimation() {
        animationView.stopAnimating()
    }
}
