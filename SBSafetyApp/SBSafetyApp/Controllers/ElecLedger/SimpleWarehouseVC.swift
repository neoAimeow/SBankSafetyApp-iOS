//
//  SimpleWarehouseVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/15.
//
// 【首页-电子台账】简易库人员出入登记

import Foundation
import UIKit

class SimpleWarehouseVC: BaseFormVC {
    let listV = SimpleWarehouseView()
    
    override var keybordOffset: Double {
        didSet {
            listV.snp.updateConstraints { (make) in
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-keybordOffset)
            }
        }
    }

    // MARK: - Override
    override func reloadData() {
        listV.deptName = deptName ?? ""
        listV.registerField(withValidator: validator)
    }
   
    override func didValidated() {
        // 完成校验
        do {
            let valPam = ElecParam(bookType: modal.typeValue)
            valPam.tjrq = Date.dateToUp(listV.val0TF.value ?? "")
            valPam.attrValue0 = Date.dateToUp(listV.val0TF.value ?? "")
            valPam.attrValue1 = listV.val1TF.value
            valPam.attrValue2 = listV.val2TF.value
            valPam.attrValue3 = listV.val3TF.value
            valPam.attrValue4 = listV.val4TV.value
            valPam.attrValue5 = listV.val5TF.value
            valPam.attrValue6 = listV.val6TF.value

            let jsonParam = StandingBookJsonParam()
            let data: Data = try JSONEncoder().encode(valPam)
            let string = String(data: data, encoding: String.Encoding.utf8)
            jsonParam.jsonStr = string
            API.postStandingBookSave(withJson: jsonParam) { responseModel in
                if responseModel.errorCode == .Success {
                    self.view.showToast(witMsg: responseModel.errorMessage)
                    self.navigationController?.popViewController(animated: true)
                }
                
            }
        } catch {
            print("SimpleWarehouseVC didValidated error", error)
        }
    }
    
    override func setupUI() {
        listV.submitBtn.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        view.addSubview(listV)
        listV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-keybordOffset)
        }
    }
}
