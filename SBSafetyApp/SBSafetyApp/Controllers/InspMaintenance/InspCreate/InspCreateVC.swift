//
//  InspCreateVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/22.
//
// 【首页-维保服务】新建巡检

import Foundation
import UIKit

class InspCreateModal: NSObject {
//    var netName: String? = "滴水湖皇冠假日酒店（18000648）"
    var dept: DeptModal?
    var template: InspTemplateModal?
    var contractor: InspContractorModal?
    var sponsor: String? = "张三"
    var personLiable: String? = "上行监控中心"
}

class InspCreateVC: SubLevelViewController {
    var modal: InspCreateModal!
    
    let createV = InspCreateView()
    
    init(withModal _modal: InspCreateModal) {
        super.init(nibName: nil, bundle: nil)
        self.modal = _modal
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "新建巡检单"
        view.backgroundColor = .bg
        navigationController?.navBarStyle(.white)
        setupUI()
        
        reloadData()
    }
    
    func reloadData() {
        createV.update(withModal: modal)
    }
    
    // MARK: - Actions
    @objc func submitTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Setup
    func setupUI() {
        createV.submitBtn.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        view.addSubview(createV)
        createV.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
