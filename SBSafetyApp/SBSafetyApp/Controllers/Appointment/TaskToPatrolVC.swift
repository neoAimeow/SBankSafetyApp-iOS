//
//  TaskToPatrolVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/18.
//
// 【首页-履职管理】任务-去巡检

import Foundation
import UIKit

class TaskToPatrolVC: SubLevelViewController {
    let listV = SecurityTaskDetailView()
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "上海银行"
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
