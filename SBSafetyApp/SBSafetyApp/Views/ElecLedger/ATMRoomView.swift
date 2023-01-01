//
//  ATMRoomView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/15.
//

import Foundation
import UIKit

class SimpleWarehouseView: ATMRoomView {
    override func setupUI() {
        super.setupUI()
        titleL.text = "简易库人员出入登记"
    }
}

class ATMRoomView: ElecCreateScrollView {
    let val0TF = DateEffect()
    let val1TF = TextFieldEffect()
    let val2TF = TextFieldEffect()
    let val3TF = TextFieldEffect()
    let val4TV = TextViewEffect()
    let val5TF = DateEffect()
    let val6TF = DateEffect()
    
    func registerField(withValidator validator: Validator) {
        validator.registerField(val0TF.valueL, rules: [RequiredRule(message: val0TF.placeholder)])
        validator.registerField(val1TF.valueTF, rules: [RequiredRule(message: val1TF.placeholder)])
        validator.registerField(val2TF.valueTF, rules: [RequiredRule(message: val2TF.placeholder)])
        validator.registerField(val3TF.valueTF, rules: [RequiredRule(message: val3TF.placeholder)])
        validator.registerField(val4TV.valueTV, rules: [RequiredRule(message: val4TV.placeholder)])
        validator.registerField(val5TF.valueL, rules: [RequiredRule(message: val5TF.placeholder)])
        validator.registerField(val6TF.valueL, rules: [RequiredRule(message: val6TF.placeholder)])
    }
    
    override func setupUI() {
        super.setupUI()
    
        titleL.text = "ATM机补钞间人员出入登记"
        subTitleL.text = "人员信息登记"

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
        
        val1TF.placeholder = "单位"
        addSubview(val1TF)
        val1TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val0TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val2TF.placeholder = "姓名"
        addSubview(val2TF)
        val2TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val1TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val3TF.placeholder = "人数"
        val3TF.valueTF.keyboardType = .phonePad
        addSubview(val3TF)
        val3TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val2TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val4TV.placeholder = "事由"
        addSubview(val4TV)
        val4TV.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val3TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(100)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val5TF.dateMode = .time
        val5TF.placeholder = "进入时间"
        val5TF.value = Date.nowCN()
        addSubview(val5TF)
        val5TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val4TV.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val6TF.dateMode = .time
        val6TF.placeholder = "离开时间"
        addSubview(val6TF)
        val6TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val5TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        addSubview(submitBtn)
        submitBtn.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val6TF.snp.bottom).offset(30)
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
