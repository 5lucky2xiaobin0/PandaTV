//
//  NetworkTools.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/3/24.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit
import Alamofire

class NetworkTools: NSObject {

    static func requestData(url : String, finish : @escaping (_ result : Any)->()){
        Alamofire.request(url).responseJSON { (response) in
            guard let result = response.result.value else {return}
            finish(result)
        }
    }
}
