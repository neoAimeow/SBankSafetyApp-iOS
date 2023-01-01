//
//  InfraredArmVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/15.
//
// 【首页-电子台账】红外线布、撤防记录

import Foundation
import UIKit

class InfraredArmVC: BaseFormVC {
    let listV = InfraredArmView()
    
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
        valPam.tjrq = Date.dateToUp(listV.val0TF.value ?? "")
        valPam.attrValue0 = Date.dateToUp(listV.val0TF.value ?? "")
        valPam.attrValue2 = Date.dateToUp(listV.val2TF.value ?? "")
        valPam.attrValue4 = listV.val4TV.value

        let v1Path = FilesManager.shared.saveImage(img: listV.val1TF.img!)
        if v1Path != nil {
            API.postStandingBookUpload(withImage: v1Path!) { responseModel in
                valPam.attrValue1 = responseModel.model?.imgUrl
                let v2Path = FilesManager.shared.saveImage(img: self.listV.val3TF.img!)
                if v2Path != nil {
                    API.postStandingBookUpload(withImage: v2Path!) { responseModel in
                        valPam.attrValue3 = responseModel.model?.imgUrl
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
