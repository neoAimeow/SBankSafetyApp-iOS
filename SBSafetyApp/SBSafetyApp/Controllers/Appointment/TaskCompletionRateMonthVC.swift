//
//  TaskCompletionRateMonthVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/24.
//
// 【首页-履职管理】巡检报告-任务完成率（月）

import Foundation
import UIKit

class TaskCompletionRateMonthVC: SubLevelViewController {
    
    let taskV = TaskCompletionRateMonthView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "任务完成率"
        view.backgroundColor = .bg
        setupUI()
        
        taskV.updateUI()
    }
    
    // MARK: - Setup
    
    func setupUI() {
        view.addSubview(taskV)
        taskV.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
