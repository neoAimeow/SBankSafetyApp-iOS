//
//  InspListResultVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/23.
//
// 【首页-维保服务】巡检项目详情

import Foundation
import UIKit

class InspListResultVC: SubLevelViewController {
    let detailV = InspListResultView()
    
    var modal: PatrolRecordModal?

    init(withModal _modal: PatrolRecordModal) {
        super.init(nibName: nil, bundle: nil)
        self.modal = _modal
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "巡检项目详情"
        view.backgroundColor = .bg
        setupUI()
        reloadData()
    }
    
    func reloadData() {
        detailV.updateUI(withModal: modal)
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
