//
//  FinishInfoVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/24.
//
// 【【登录】完善信息

import Foundation
import UIKit

class FinishInfoVC: SubLevelViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    // MARK: - Actions
    @objc func confrimTapped() {
       
        navigationController?.popViewController(animated: true)
    }
    
    @objc func chooseNetTapped() {
        
    }
    
    // MARK: - Setup
    
    func setupUI() {
        let forgotV = FinishInfoView()
        forgotV.netTF.ctl.addTarget(self, action: #selector(chooseNetTapped), for: .touchUpInside)
        forgotV.confrimBtn.addTarget(self, action: #selector(confrimTapped), for: .touchUpInside)
        view.addSubview(forgotV)
        forgotV.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

