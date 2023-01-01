//
//  CreateOrderVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/5.
//
// 【首页-工单及反馈】新建工单

import Foundation
import UIKit

class CreateOrderVC: SubLevelViewController {
    let createV = CreateOrderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "在线工单"
        view.backgroundColor = .bg
        
        setupUI()
    }
    
    // MARK: - Setup
    
    func setupUI() {
        view.addSubview(createV)
        createV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
}
