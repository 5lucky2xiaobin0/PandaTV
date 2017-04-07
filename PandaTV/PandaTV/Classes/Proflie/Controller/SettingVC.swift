//
//  SettingVC.swift
//  PandaTV
//
//  Created by 钟斌 on 2017/3/31.
//  Copyright © 2017年 xiaobin. All rights reserved.
//

import UIKit

private let cellID = "cellID"

class SettingVC: UITableViewController {
    var size : Float = 0
    var cell : UITableViewCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "设置"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getCache()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        cell = tableView.dequeueReusableCell(withIdentifier: cellID)

        
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: cellID)
        }
       
        cell?.textLabel?.text = "清除缓存"
        
        if self.size == 0 {
            cell?.detailTextLabel?.text = "计算中"
        }else {
            cell?.detailTextLabel?.text = String(format: "%.2f", size) + "MB"
        }
        
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        removeCache()
    }
    
    
    //清楚缓存
    func removeCache() {
        DispatchQueue.global().async {
            let fmanager = FileManager()
            //获取缓存文件夹
            let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory , FileManager.SearchPathDomainMask.userDomainMask, true).first
            
            guard let cache = cachePath else { return }
            
            let pathArr = fmanager.subpaths(atPath: cache)
            
            for path in pathArr! {
                //拼接地址
                let filePath = "\(cache)/\(path)"
                
                if fmanager.fileExists(atPath: filePath) {
                    try? fmanager.removeItem(atPath: filePath)
                }
            }
            //重新计算一次缓存
            self.getCache()
        }
    }
    
    
    func getCache(){
        DispatchQueue.global().async {
            let fmanager = FileManager()
            //获取缓存文件夹
            let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory , FileManager.SearchPathDomainMask.userDomainMask, true).first
            
            guard let cache = cachePath else { return }
            
            let pathArr = fmanager.subpaths(atPath: cache)

            for path in pathArr! {
                //拼接地址
                let filePath = "\(cache)/\(path)"
                
                let attr = try? fmanager.attributesOfItem(atPath: filePath)
                self.size += attr?[FileAttributeKey.size] as! Float
            }
            
            DispatchQueue.main.sync {
                self.size = self.size / 1024 / 1024
                
                self.tableView.reloadData()
            }
        }
        
    }
    
    
}
