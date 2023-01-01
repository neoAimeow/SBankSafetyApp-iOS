//
//  CheckVideoView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/15.
//

import Foundation
import UIKit

class CheckVideoView: ElecCreateScrollView {
    let val0TF = TextFieldEffect()
    let val1TF = DateEffect()
    let val2TF = TextFieldEffect()
    let val3TF = DateEffect()
    let val4TF = TextFieldEffect()
    let val5TF = DateEffect()
    let val6TF = TextFieldEffect()
    let val7TF = TextFieldEffect()
    let val8TF = TextFieldEffect()
    
    func registerField(withValidator validator: Validator) {
        validator.registerField(val0TF.valueTF, rules: [RequiredRule(message: val0TF.placeholder)])
        validator.registerField(val1TF.valueL, rules: [RequiredRule(message: val1TF.placeholder)])
        validator.registerField(val2TF.valueTF, rules: [RequiredRule(message: val2TF.placeholder)])
        validator.registerField(val3TF.valueL, rules: [RequiredRule(message: val3TF.placeholder)])
        validator.registerField(val4TF.valueTF, rules: [RequiredRule(message: val4TF.placeholder)])
        validator.registerField(val5TF.valueL, rules: [RequiredRule(message: val5TF.placeholder)])
        validator.registerField(val6TF.valueTF, rules: [RequiredRule(message: val6TF.placeholder)])
        validator.registerField(val7TF.valueTF, rules: [RequiredRule(message: val7TF.placeholder)])
        validator.registerField(val8TF.valueTF, rules: [RequiredRule(message: val8TF.placeholder)])
    }
    
    override func setupUI() {
        super.setupUI()
        
        titleL.text = "检查数码监控录像情况记录"
        subTitleL.text = "情况记录"
        
        val0TF.placeholder = "机型"
        addSubview(val0TF)
        val0TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(subTitleL.snp.bottom).offset(18)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val1TF.placeholder = "回放日期"
        val1TF.value = Date.todayDateCN()
        val1TF.maximumDate = Date()
        addSubview(val1TF)
        val1TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val0TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val2TF.placeholder = "回放发现问题"
        addSubview(val2TF)
        val2TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val1TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        let tipsL = UILabel()
        tipsL.font = UIFont.systemFont(ofSize: 14)
        tipsL.textColor = .hex("#E76142")
        tipsL.text = "注："
        addSubview(tipsL)
        tipsL.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val2TF.snp.bottom).offset(10)
            make.left.equalTo(val2TF.snp.left).offset(10)
            make.width.equalTo(25)
        }
        
        let remindL = UILabel()
        remindL.numberOfLines = 0
        remindL.font = UIFont.systemFont(ofSize: 14)
        remindL.textColor = .hex("#E76142")
        remindL.text = "回放发现问题指图像是否清晰、稳定，时间是否准确，客户人像和取钞过程是否完整。"
        addSubview(remindL)
        remindL.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(tipsL.snp.top)
            make.left.equalTo(tipsL.snp.right)
            make.right.equalTo(val2TF.snp.right).offset(-10)
        }
        
        val3TF.placeholder = "报修时间"
        addSubview(val3TF)
        val3TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(remindL.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val4TF.placeholder = "报修人"
        addSubview(val4TF)
        val4TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val3TF.snp.bottom).offset(18)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val5TF.placeholder = "维修保养时间"
        addSubview(val5TF)
        val5TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val4TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val6TF.placeholder = "维修保养单位"
        addSubview(val6TF)
        val6TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val5TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val7TF.placeholder = "维修保养责任人"
        addSubview(val7TF)
        val7TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val6TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val8TF.placeholder = "检查操作人"
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
