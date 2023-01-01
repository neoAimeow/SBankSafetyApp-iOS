//
//  AboutusVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/24.
//
// 【我的】关于页面

import Foundation
import UIKit

class AboutusVC: SubLevelViewController {
    let aboutV = AboutusView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .bg
        title = "关于我们"
        setupUI()
    }
    
    // MARK: - Actions
    
    @objc func downloadTapped() {
        navigationController?.pushViewController(DownloadVC(), animated: true)
    }
    
    @objc func serviceTapped() {
        navigationController?.pushViewController(PtsmVC(), animated: true)
    }
    
    // MARK: - Setup
    
    func setupUI() {
        aboutV.downloadItem.addTarget(self, action: #selector(downloadTapped), for: .touchUpInside)
        aboutV.serviceItem.addTarget(self, action: #selector(serviceTapped), for: .touchUpInside)
        view.addSubview(aboutV)
        aboutV.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
