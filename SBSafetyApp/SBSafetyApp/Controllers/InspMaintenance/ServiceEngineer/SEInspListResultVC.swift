//
//  SEInspListResultVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/11.
//
// 【首页-维保服务】维修工程师-巡检结果

import Foundation
import UIKit

class SEInspListResultVC: SubLevelViewController {
    let detailV = SEInspListResultView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "巡检结果"
        view.backgroundColor = .bg
        setupUI()
        reloadData()
    }
    
    func reloadData() {

    }
    
    func setupUI() {
        view.addSubview(detailV)
        detailV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
