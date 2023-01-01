//
//  OneClickRepairView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/27.
//

import Foundation
import UIKit

class OneClickRepairView: UIScrollView {
    let submitBtn = UIButton.createPrimaryLarge("提交")
    
    let branchTF = LabelEffect()
    let personTF = BSLabelValueView()
    let liableTF = BSLabelValueView()
    let failureTF = LabelEffect()
    let locationTF = LabelEffect()
    let moreLocTF = TextFieldEffect()
    let despTF = TextViewEffect()
    let appointTimeTF = LabelEffect(withEnable: false)
    
    var moreLoc: String?
    var moreLocHidden: Bool = true {
        didSet {
            updateLocView()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        keyboardDismissMode = .interactive
        showsVerticalScrollIndicator = false

        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(param: YjwxCreateOrderParam, yysj: String? = nil) {
        branchTF.value = param.wdmc
        personTF.update(withKey: "报修人", value: param.bxrmc)
        liableTF.update(withKey: "网点责任人", value: param.wdzrr)
        failureTF.value = param.bxgzmc
        locationTF.value = param.fswz
        appointTimeTF.value = yysj
    }
    
    func updateLocView() {
        if moreLocHidden {
            moreLocTF.isHidden = true
            moreLocTF.snp.remakeConstraints { (make) -> Void in
                make.top.equalTo(locationTF.snp.bottom)
                make.centerX.equalTo(self.snp.centerX)
                make.height.equalTo(0)
                make.width.equalTo(ScreenWidth - 20)
            }
        } else {
            moreLocTF.value = ""
            moreLocTF.isHidden = false
            moreLocTF.snp.remakeConstraints { (make) -> Void in
                make.top.equalTo(locationTF.snp.bottom).offset(10)
                make.centerX.equalTo(self.snp.centerX)
                make.height.equalTo(50)
                make.width.equalTo(ScreenWidth - 20)
            }
        }
    }
    
    func setupUI() {
        branchTF.placeholder = "网点名称"
        addSubview(branchTF)
        branchTF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(ScreenWidth - 20)
//            make.height.equalTo(50)
        }
        
        addSubview(personTF)
        personTF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(branchTF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(ScreenWidth - 20)
        }

        addSubview(liableTF)
        liableTF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(personTF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        failureTF.placeholder = "报修故障"
        addSubview(failureTF)
        failureTF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(liableTF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(ScreenWidth - 20)
//            make.height.equalTo(50)
        }
        
        locationTF.placeholder = "发生位置（非必填）"
        addSubview(locationTF)
        locationTF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(failureTF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
//            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        moreLocTF.isHidden = true
        moreLocTF.placeholder = "自定义位置（非必填）"
        addSubview(moreLocTF)
        moreLocTF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(locationTF.snp.bottom)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(0)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        despTF.placeholder = "故障描述（非必填）"
        addSubview(despTF)
        despTF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(moreLocTF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(100)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        appointTimeTF.placeholder = "预约时间（非必选）"
        addSubview(appointTimeTF)
        appointTimeTF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(despTF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
//            make.height.greaterThanOrEqualTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        addSubview(imgPickerView)
        imgPickerView.snp.makeConstraints { make in
            make.top.equalTo(appointTimeTF.snp.bottom).offset(10)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.width.equalTo(ScreenWidth)
        }
        
        addSubview(submitBtn)
        submitBtn.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(imgPickerView.snp.bottom).offset(24)
            make.height.equalTo(50)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(ScreenWidth - 20)
            make.bottom.equalTo(self.snp.bottom).offset(-20)
        }
    }
    
    lazy var imgPickerView: BSImagePickerView = {
        let picker = BSImagePickerView()
        picker.key = "添加附件"
        picker.maxCount = 9
        picker.rowCount = 4
        return picker
    }()
}
