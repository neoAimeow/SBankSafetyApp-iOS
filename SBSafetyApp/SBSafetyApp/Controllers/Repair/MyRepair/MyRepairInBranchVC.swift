//
//  MyRepairInBranchVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/25.
//
// 【首页-一键报修】我的维修-支行列表

import Foundation
import UIKit

class MyRepairInBranchVC: SubLevelViewController {
    
    let myRepairV = MyRepairInBranchView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "鞍山支行"
        view.backgroundColor = .bg
        setupUI()
        
        reloadData()
    }
    
    func reloadData() {
//        myRepairV.reloadData()
    }
    // MARK: - Setup
    
    func setupUI() {
        view.addSubview(myRepairV)
        myRepairV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
