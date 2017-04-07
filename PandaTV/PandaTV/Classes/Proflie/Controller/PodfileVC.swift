//
//  PodfileVC.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/3/24.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit

class PodfileVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        tableView.contentInset = UIEdgeInsets(top: -40, left: 0, bottom: 0, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

extension PodfileVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

        //跳转设置页面
        if indexPath.section == 4 {
            if indexPath.row == 0 {
                //创建设置界面
                let setVC = SettingVC()
                
                navigationController?.pushViewController(setVC, animated: true)
            }
        }
    }
}
