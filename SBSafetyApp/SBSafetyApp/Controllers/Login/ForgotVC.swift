//
//  ForgotVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/14.
//
// 【登录】找回密码页面

import Foundation
import UIKit

class ForgotVC: SubLevelViewController {
    let forgotV = ForgotView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    // MARK: - Actions
    @objc func confrimTapped() {
       /// 重置密码
        API.postRetrievepwdReset(withParam: forgotV.loginM) { responseModel in
            if responseModel.errorCode == .Success {
                self.navigationController?.popViewController(animated: true)
            } else {
                self.view.showToast(witMsg: responseModel.errorMessage)
            }
        }
    }
    
    // MARK: - Setup
    
    func setupUI() {
        forgotV.confrimBtn.addTarget(self, action: #selector(confrimTapped), for: .touchUpInside)
        view.addSubview(forgotV)
        forgotV.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

