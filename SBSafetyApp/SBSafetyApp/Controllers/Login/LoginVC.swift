//
//  LoginVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/14.
//
// 【登录】登录页面

import Foundation
import UIKit

class LoginVC: TopViewController {
    let loginV = LoginView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()

        reloadData()
    }

    // MARK: - Actions

    @objc func forgotTapped() {
        let forgot_vc = ForgotVC()
        navigationController?.pushViewController(forgot_vc, animated: true)
    }

    @objc func submitTapped() {
        API.login(withParam: loginV.loginM) { responseModel in
            if responseModel.errorCode == .Success {
                BSUser.currentUser.modifyUser(_phone: self.loginV.loginM.username, _password: self.loginV.loginM.password)
                let token = responseModel.model?.token
                let role = responseModel.model?.role
                let user = responseModel.model?.user

                UserDefaults.standard.set(token, forKey: SafetyToken)
                UserDefaults.standard.set(role, forKey: SafetyUserRole)
                print("test" + (role ?? "") + (user?.toJSONString() ?? ""));
                Utils.app.setupMain()
            } else {
                self.view.showToast(witMsg: responseModel.errorMessage)
                self.loginV.isimgCodeHidden = false
            }
        }
    }

    func reloadData() {
        loginV.reloadData()
    }

    // MARK: - Setup

    func setupUI() {
        loginV.loginBtn.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        loginV.forgotBtn.addTarget(self, action: #selector(forgotTapped), for: .touchUpInside)
        view.addSubview(loginV)
        loginV.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}
