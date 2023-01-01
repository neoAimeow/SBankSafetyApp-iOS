//
//  SecurityCheckVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/16.
//
// 【首页-电子台账】营业网点安全防范检查表

import Foundation
import UIKit

class SecurityCheckVC: BaseFormVC {
    let listV = SecurityCheckView()
    
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
        let valPam = ElecParam(bookType: modal.typeValue)
        valPam.tjrq = Date.dateToUp(listV.val33TF.value ?? "")
        valPam.attrValue0 = listV.val0TF.isCheck! ? "1" : "0"
        valPam.attrValue1 = listV.val1TF.isCheck! ? "1" : "0"
        valPam.attrValue2 = listV.val2TF.isCheck! ? "1" : "0"
        valPam.attrValue3 = listV.val3TF.isCheck! ? "1" : "0"
        valPam.attrValue4 = listV.val4TF.isCheck! ? "1" : "0"
        valPam.attrValue5 = listV.val5TF.isCheck! ? "1" : "0"
        valPam.attrValue6 = listV.val6TF.isCheck! ? "1" : "0"
        valPam.attrValue7 = listV.val7TF.isCheck! ? "1" : "0"
        valPam.attrValue8 = listV.val8TF.isCheck! ? "1" : "0"
        valPam.attrValue9 = listV.val9TF.isCheck! ? "1" : "0"
        valPam.attrValue10 = listV.val10TF.isCheck! ? "1" : "0"
        valPam.attrValue11 = listV.val11TF.isCheck! ? "1" : "0"
        valPam.attrValue12 = listV.val12TF.isCheck! ? "1" : "0"
        valPam.attrValue13 = listV.val13TF.isCheck! ? "1" : "0"
        valPam.attrValue14 = listV.val14TF.isCheck! ? "1" : "0"
        valPam.attrValue15 = listV.val15TF.isCheck! ? "1" : "0"
        valPam.attrValue16 = listV.val16TF.isCheck! ? "1" : "0"
        valPam.attrValue17 = listV.val17TF.isCheck! ? "1" : "0"
        valPam.attrValue18 = listV.val18TF.isCheck! ? "1" : "0"
        valPam.attrValue19 = listV.val19TF.isCheck! ? "1" : "0"
        valPam.attrValue20 = listV.val20TF.isCheck! ? "1" : "0"
        valPam.attrValue21 = listV.val21TF.isCheck! ? "1" : "0"
        valPam.attrValue22 = listV.val22TF.isCheck! ? "1" : "0"
        valPam.attrValue23 = listV.val23TF.isCheck! ? "1" : "0"
        valPam.attrValue24 = listV.val24TF.isCheck! ? "1" : "0"
        valPam.attrValue25 = listV.val25TF.isCheck! ? "1" : "0"
        valPam.attrValue26 = listV.val26TF.isCheck! ? "1" : "0"
        valPam.attrValue27 = listV.val27TF.isCheck! ? "1" : "0"
        valPam.attrValue28 = listV.val28TF.isCheck! ? "1" : "0"
        valPam.attrValue29 = listV.val29TF.isCheck! ? "1" : "0"
        valPam.attrValue30 = listV.val30TF.isCheck! ? "1" : "0"
        valPam.attrValue31 = listV.val31TV.value
        valPam.attrValue32 = listV.val32TV.value
        valPam.attrValue33 = Date.dateToUp(listV.val33TF.value ?? "")
        valPam.attrValue34 = listV.val34TF.value
        
        do {
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
            print("InfraredArmVC didValidated error", error)
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
