//
//  RepairMaintenanceView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/15.
//

import Foundation
import UIKit

class RepairMaintenanceView: ElecCreateScrollView {
    let val0TF = DateEffect()
    let val1TF = TextFieldEffect()
    let val2TF = TextFieldEffect()
    let val3TF = TextFieldEffect()
    let val4TF = TextFieldEffect()
    let val5TF = TextFieldEffect()
    
    func registerField(withValidator validator: Validator) {
        validator.registerField(val0TF.valueL, rules: [RequiredRule(message: val0TF.placeholder)])
        validator.registerField(val1TF.valueTF, rules: [RequiredRule(message: val1TF.placeholder)])
        validator.registerField(val2TF.valueTF, rules: [RequiredRule(message: val2TF.placeholder)])
        validator.registerField(val3TF.valueTF, rules: [RequiredRule(message: val3TF.placeholder)])
        validator.registerField(val4TF.valueTF, rules: [RequiredRule(message: val4TF.placeholder)])
        validator.registerField(val5TF.valueTF, rules: [RequiredRule(message: val5TF.placeholder)])
    }
    
    override func setupUI() {
        super.setupUI()
        
        titleL.text = "技防、物防设施维修、保养记录"
        subTitleL.text = "维修、保养记录"
        
        val0TF.placeholder = "日期"
        val0TF.value = Date.todayDateCN()
        val0TF.maximumDate = Date()
        addSubview(val0TF)
        val0TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(subTitleL.snp.bottom).offset(18)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val1TF.placeholder = "维修保养项目"
        addSubview(val1TF)
        val1TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val0TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val2TF.placeholder = "维修保养结果"
        addSubview(val2TF)
        val2TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val1TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val3TF.placeholder = "维修保养单位"
        addSubview(val3TF)
        val3TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val2TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val4TF.placeholder = "维修保养人"
        addSubview(val4TF)
        val4TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val3TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val5TF.placeholder = "接待人"
        addSubview(val5TF)
        val5TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val4TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        addSubview(submitBtn)
        submitBtn.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val5TF.snp.bottom).offset(102)
            make.height.equalTo(50)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        let bottomIV = UIImageView(image: UIImage(named: "elec_bottom"))
        addSubview(bottomIV)
        bottomIV.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(submitBtn.snp.bottom).offset(20)
            make.bottom.equalTo(self.snp.bottom).offset(-16)
            make.height.equalTo(24)
        }
    }
}
