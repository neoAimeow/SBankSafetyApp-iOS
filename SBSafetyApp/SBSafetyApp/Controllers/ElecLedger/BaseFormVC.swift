//
//  BaseFormVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/16.
//

import Foundation
import UIKit

enum ElecType: String {
    case ATM = "A" // ATM机补钞间人员出入登记簿
    case SecurityLegal = "B" // 安全保卫法制宣传教育记录簿
    case InfraredArm = "C" // 红外线布、撤防记录簿
    case Repair = "D" // 机防、物防设施维修、保养记录簿
    case OutMonitor = "E" // 监控室外来人员登记簿
    case VideoMonitor = "F" // 监控室外来人员借、调阅录像资料登记簿
    case CheckVideo = "G" // 检查数码录像监控记录簿
    case SimpleWarehouse = "H" // 简易库人员出入登记簿
    case CashBox = "I" // 接、送库款箱记录簿
    case OutBusiness = "J" // 进入营业室外来人员登记簿
    case SelfCheck = "K" // 营业结束安全保卫自查表
    case SecurityCheck = "L" // 营业网点安全防范检查表
}

class BaseFormVC: SubLevelViewController {
    var modal: StandingBookTypeModal!
    let validator = Validator()

    init(withModal _modal: StandingBookTypeModal) {
        super.init(nibName: nil, bundle: nil)
        self.modal = _modal
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "电子台账"
        if deptName == nil {
            deptName = BSUser.currentUser.deptName
            deptId = BSUser.currentUser.deptId
        }
        setupUI()
        reloadData()
    }
    
    @objc func submitTapped() {
        validator.validate(self)
    }
    
    func didValidated() {}
    
    func reloadData() {}
    
    // MARK: - Setup
    func setupUI() {}
}

extension BaseFormVC: ValidationDelegate {
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
