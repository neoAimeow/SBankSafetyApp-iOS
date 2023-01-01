//
//  FeedbackDetailVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/5.
//
// 【首页-工单及反馈】反馈详情

import Foundation
import UIKit

class FeedbackDetailVC: SubLevelViewController {
    let detailV = FeedbackDetailView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "反馈详情"
        view.backgroundColor = .bg
        
        setupUI()
        
        reloadData()
    }
    
    func reloadData() {
        detailV.reloadData()
    }
    
    // MARK: - Setup
    
    func setupUI() {
        view.addSubview(detailV)
        detailV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
}
