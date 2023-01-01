//
//  VideoMonitorRView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/15.
//

import Foundation
import UIKit

class VideoMonitorRView: ElecCreateScrollView {
    let val0TF = DateEffect()
    let val1TF = TextFieldEffect()
    let val2TF = TextFieldEffect()
    let val3TF = TextFieldEffect()
    let val4TF = TextFieldEffect()
    let val5TV = TextViewEffect()
    let val6TF = DateEffect()
    let val7TF = DateEffect()
    let val8TF = DateEffect()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        keyboardDismissMode = .interactive
        showsVerticalScrollIndicator = false

        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func registerField(withValidator validator: Validator) {
        validator.registerField(val0TF.valueL, rules: [RequiredRule(message: val0TF.placeholder)])
        validator.registerField(val1TF.valueTF, rules: [RequiredRule(message: val1TF.placeholder)])
        validator.registerField(val2TF.valueTF, rules: [RequiredRule(message: val2TF.placeholder)])
        validator.registerField(val3TF.valueTF, rules: [RequiredRule(message: val3TF.placeholder)])
        validator.registerField(val4TF.valueTF, rules: [RequiredRule(message: val4TF.placeholder)])
        validator.registerField(val5TV.valueTV, rules: [RequiredRule(message: val5TV.placeholder)])
        validator.registerField(val6TF.valueL, rules: [RequiredRule(message: val6TF.placeholder)])
        validator.registerField(val7TF.valueL, rules: [RequiredRule(message: val7TF.placeholder)])
        validator.registerField(val8TF.valueL, rules: [RequiredRule(message: val8TF.placeholder)])
    }
    
    override func setupUI() {
        super.setupUI()
        
        titleL.text = "监控室外来人员借、调阅录像资料登记"
        subTitleL.text = "人员登记"
        
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
        
        val4TF.placeholder = "接待人"
        addSubview(val4TF)
        val4TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val3TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val5TV.placeholder = "借、调事由"
        addSubview(val5TV)
        val5TV.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val4TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(100)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val6TF.placeholder = "借、调阅录像时间段"
        val6TF.dateType = .range
        val6TF.dateMode = .time
        addSubview(val6TF)
        val6TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val5TV.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val7TF.dateMode = .time
        val7TF.placeholder = "进入时间"
        val7TF.value = Date.nowCN()
        addSubview(val7TF)
        val7TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val6TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val8TF.dateMode = .time
        val8TF.placeholder = "离开时间"
        addSubview(val8TF)
        val8TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val7TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        addSubview(submitBtn)
        submitBtn.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val8TF.snp.bottom).offset(30)
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
