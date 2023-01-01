//
//  RepairReportErrorVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/28.
//
// 【首页-一键报修】一键报修-故障信息统计

import Foundation
import UIKit

class RepairReportErrorVC: SubLevelViewController {
    let detailV = RepairReportErrorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "故障信息统计"
        view.backgroundColor = .white
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
            make.width.equalTo(ScreenWidth)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
