//
//  CreateCaseView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/26.
//

import Foundation
import UIKit

class CreateCaseView: UIScrollView {
    let submitBtn = UIButton.createPrimaryLarge("提交")
    
    let nameTF = TextFieldEffect()
    let authorTF = TextFieldEffect()
    let categoryTF = LabelEffect()
    let deviceTF = TextFieldEffect()
    let despTF = TextViewEffect()
    let failureMethodTF = TextViewEffect()
    let queryTF = TextFieldEffect()
    
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
        validator.registerField(nameTF.valueTF, rules: [RequiredRule(message: nameTF.placeholder)])
        validator.registerField(despTF.valueTV, rules: [RequiredRule(message: despTF.placeholder)])
        validator.registerField(failureMethodTF.valueTV, rules: [RequiredRule(message: failureMethodTF.placeholder)])
        validator.registerField(queryTF.valueTF, rules: [RequiredRule(message: queryTF.placeholder)])
    }
    
    @objc func faultCategoryTapped() {
        let vc = FaultCategoryVC()
//        vc.delegate = categoryTF
        getFirstViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupUI() {
        nameTF.placeholder = "标题名称"
        nameTF.isRequired = true
        addSubview(nameTF)
        nameTF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        authorTF.placeholder = "撰写人"
        addSubview(authorTF)
        authorTF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(nameTF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        categoryTF.placeholder = "故障类别"
        categoryTF.ctl.addTarget(self, action: #selector(faultCategoryTapped), for: .touchUpInside)
        addSubview(categoryTF)
        categoryTF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(authorTF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
//            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        deviceTF.placeholder = "故障设备"
        addSubview(deviceTF)
        deviceTF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(categoryTF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        despTF.placeholder = "故障描述"
        despTF.isRequired = true
        addSubview(despTF)
        despTF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(deviceTF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(100)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        failureMethodTF.placeholder = "故障点分析及处理方法"
        failureMethodTF.isRequired = true
        addSubview(failureMethodTF)
        failureMethodTF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(despTF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(100)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        queryTF.placeholder = "查询标签"
        queryTF.isRequired = true
        addSubview(queryTF)
        queryTF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(failureMethodTF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        addSubview(submitBtn)
        submitBtn.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(queryTF.snp.bottom).offset(60)
            make.height.equalTo(50)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(ScreenWidth - 20)
            make.bottom.equalTo(self.snp.bottom).offset(-20)
        }
    }
}
