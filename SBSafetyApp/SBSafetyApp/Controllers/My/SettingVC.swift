//
//  SettingVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/24.
//
// 【我的】设置页面

import Foundation
import UIKit

class SettingVC: SubLevelViewController {
    let settingV = SettingView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .bg
        title = "设置"
        setupUI()
    }
    
    // MARK: - Actions
    
    @objc func modifyPswTapped() {
        
    }
    
    @objc func unlockTapped() {
        
    }
    
    @objc func exitTapped() {
        Utils.exitApp()
    }
    
    // MARK: - Setup
    
    func setupUI() {
        settingV.modifyPswItem.addTarget(self, action: #selector(modifyPswTapped), for: .touchUpInside)
        settingV.unlockItem.addTarget(self, action: #selector(unlockTapped), for: .touchUpInside)
        settingV.exitBtn.addTarget(self, action: #selector(exitTapped), for: .touchUpInside)
        view.addSubview(settingV)
        settingV.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
