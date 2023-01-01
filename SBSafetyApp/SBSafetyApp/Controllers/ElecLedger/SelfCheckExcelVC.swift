//
//  SelfCheckExcelVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/15.
//
// 【首页-电子台账】营业结束安全保卫自查表

import Foundation
import UIKit

class SelfCheckExcelVC: BaseFormVC {
    let listV = SelfCheckExcelView()
    
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
        valPam.tjrq = Date.dateToUp(listV.val11TF.value ?? "")
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
        valPam.attrValue11 = Date.dateToUp(listV.val11TF.value ?? "")
        valPam.attrValue12 = listV.val12TF.value
        
        let v1Path = FilesManager.shared.saveImage(img: listV.val13TF.img!)
        if v1Path != nil {
            API.postStandingBookUpload(withImage: v1Path!) { responseModel in
                valPam.attrValue13 = responseModel.model?.imgUrl
                let v2Path = FilesManager.shared.saveImage(img: self.listV.val14TF.img!)
                if v2Path != nil {
                    API.postStandingBookUpload(withImage: v2Path!) { responseModel in
                        valPam.attrValue14 = responseModel.model?.imgUrl
                        self.didUpload(withData: valPam)
                    }
                }
            }
        }
    }
    
    func didUpload(withData valPam: ElecParam) {
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
