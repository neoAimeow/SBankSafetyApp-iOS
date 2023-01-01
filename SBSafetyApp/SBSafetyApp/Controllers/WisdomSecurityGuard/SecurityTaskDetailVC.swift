//
//  SecurityTaskDetailVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/17.
//
// 【首页-保安管理】保安管理任务详情

import Foundation
import UIKit

class SecurityTaskDetailVC: SubLevelViewController {
    let listV = SecurityTaskDetailView()
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "任务详情"
        setupUI()
    }
    
    // MARK: - Actions
    @objc func submitTapped() {
        
    }
    
    // MARK: - Setup
    func setupUI() {
        listV.submitBtn.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        view.addSubview(listV)
        listV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
