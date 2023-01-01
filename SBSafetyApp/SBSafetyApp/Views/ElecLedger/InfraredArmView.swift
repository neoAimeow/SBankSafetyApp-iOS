//
//  InfraredArmView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/15.
//

import Foundation
import UIKit

class InfraredArmView: ElecCreateScrollView {
    let val0TF = DateEffect()
    let val1TF = SignEffect()
    let val2TF = DateEffect()
    let val3TF = SignEffect()
    let val4TV = TextViewEffect()
    
    func registerField(withValidator validator: Validator) {
        validator.registerField(val0TF.valueL, rules: [RequiredRule(message: val0TF.placeholder)])
        validator.registerField(val1TF, rules: [RequiredRule(message: val1TF.placeholder)])
        validator.registerField(val2TF.valueL, rules: [RequiredRule(message: val2TF.placeholder)])
        validator.registerField(val3TF, rules: [RequiredRule(message: val3TF.placeholder)])
        validator.registerField(val4TV.valueTV, rules: [RequiredRule(message: val4TV.placeholder)])
    }
    
    override func setupUI() {
        super.setupUI()
        
        titleL.text = "红外线布、撤防记录"
        subTitleL.text = "布、撤防记录"
        
        val0TF.placeholder = "撤防时间"
        addSubview(val0TF)
        val0TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(subTitleL.snp.bottom).offset(18)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
                
        val1TF.placeholder = "撤防人签名"
        addSubview(val1TF)
        val1TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val0TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
                
        val2TF.placeholder = "布防时间"
        addSubview(val2TF)
        val2TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val1TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val3TF.placeholder = "布防人签名"
        addSubview(val3TF)
        val3TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val2TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val4TV.placeholder = "发现问题"
        addSubview(val4TV)
        val4TV.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val3TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(100)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        addSubview(submitBtn)
        submitBtn.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val4TV.snp.bottom).offset(112)
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
