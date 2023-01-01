//
//  DownloadVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/24.
//
// 【我的】下载页面

import Foundation
import UIKit

class DownloadVC: SubLevelViewController {
    let downloadIV = UIImageView(image: UIImage(named: "download"))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    // MARK: - Actions
    
    // MARK: - Setup
    
    func setupUI() {
        downloadIV.contentMode = .scaleAspectFill
        view.addSubview(downloadIV)
        downloadIV.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
}
