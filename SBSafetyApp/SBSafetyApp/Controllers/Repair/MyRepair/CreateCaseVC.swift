//
//  CreateCaseVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/26.
//
// 【首页-一键报修】创建案例

import Foundation
import UIKit

class CreateCaseVC: SubLevelViewController {
    let validator = Validator()

    let caseV = CreateCaseView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "创建案例"
        view.backgroundColor = .white
        setupUI()
        
        reloadData()
    }
    
    @objc func submitTapped() {
        validator.validate(self)
    }
    
    func didValidated() {
        navigationController?.popViewController(animated: true)
    }
    
    func reloadData() {}
    // MARK: - Setup
    
    func setupUI() {
        caseV.registerField(withValidator: validator)
        caseV.submitBtn.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        view.addSubview(caseV)
        caseV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension CreateCaseVC: ValidationDelegate {
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        for (index, (v, error)) in errors.enumerated() {
//            print("errors", v, error.errorMessage)
            if index == 0 {
                if v is CheckEffect {
                    view.showToast(witMsg: "请判断「\(error.errorMessage)」")
                } else {
                    view.showToast(witMsg: "请输入「\(error.errorMessage)」")
                }
            }
        }
    }
    
    func validationSuccessful() {
        didValidated()
    }
}
