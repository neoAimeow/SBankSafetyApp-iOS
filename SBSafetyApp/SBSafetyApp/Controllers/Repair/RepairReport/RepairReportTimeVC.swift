//
//  RepairReportTimeVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/28.
//
// 【首页-一键报修】一键报修-响应时间统计

import Foundation
import UIKit

class RepairReportTimeVC: SubLevelViewController {
    let detailV = RepairReportTimeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "响应时间统计"
        view.backgroundColor = .bg
        setupUI()
        
        reloadData()
    }
    
    func reloadData() {
        detailV.reloadData()
    }
    

    @objc func actionTapped() {
        
    }
    
    // MARK: - Setup
    
    func setupUI() {
        detailV.compCtl.addTarget(self, action: #selector(actionTapped), for: .touchUpInside)
        view.addSubview(detailV)
        detailV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.width.equalTo(ScreenWidth)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
