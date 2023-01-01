//
//  NotiDetailVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/5.
//
// 【首页-通知】通知详情

import Foundation
import UIKit

class NotiDetailVC: SubLevelViewController {
    let detailV = NotiDetailView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "通知详情"
        view.backgroundColor = .white
        
        setupUI()
        
        reloadData()
    }
    
    func reloadData() {
        detailV.reloadData(withModal: [])
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
