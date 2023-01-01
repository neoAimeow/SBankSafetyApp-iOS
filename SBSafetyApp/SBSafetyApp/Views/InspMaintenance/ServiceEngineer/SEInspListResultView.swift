//
//  SEInspListResultView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/11.
//

import Foundation
import UIKit

class SEInspListResultView: UIScrollView {
    let titleBV = UIView.createBase()
    let nameL = UILabel()
    
    // 巡检结果
    let basicBV = UIView.createBase()
    let xjztItem = LabelPickerEffect(withPlaceholder: "巡检状态")   // 巡检状态
    let ycqksmItem = TextViewEditEffect(withPlaceholder: "异常情况说明")  // 异常情况说明

    let locationBV = UIView.createBase()
    let locationL = PaddingLabel()
    
    let submitBtn = UIButton.createPrimaryLarge("提交")

    override init(frame: CGRect) {
        super.init(frame: frame)
        keyboardDismissMode = .interactive
        showsVerticalScrollIndicator = false
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    func setupTitleView() {
        addSubview(titleBV)
        titleBV.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth - 20)
        }
        
        nameL.text = "自动喷水系统"
        nameL.font = .systemFont(ofSize: 17)
        titleBV.addSubview(nameL)
        nameL.snp.makeConstraints { make in
            make.top.equalTo(titleBV.snp.top).offset(18)
            make.centerX.equalToSuperview()
        }
        
        let desL = UILabel()
        desL.text = "检查消防泵、管网、控制柜、报警阀"
        desL.textColor = .hex("#306EC8")
        desL.font = .systemFont(ofSize: 16)
        titleBV.addSubview(desL)
        desL.snp.makeConstraints { make in
            make.top.equalTo(nameL.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    func setupBasicView() {
        addSubview(basicBV)
        basicBV.snp.makeConstraints { make in
            make.top.equalTo(titleBV.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth - 20)
        }
        
        let basicTV = TitleItemView(withTitle: "巡检结果", hasIcon: false)
        basicBV.addSubview(basicTV)
        basicTV.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(46)
        }
        
        let line = UIView()
        line.backgroundColor = .hex("#ECECEC")
        basicBV.addSubview(line)
        line.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(basicTV.snp.bottom)
            make.left.equalToSuperview().offset(13)
            make.right.equalToSuperview().offset(-13)
            make.height.equalTo(0.5)
        }
        
        xjztItem.dataSource = [
            YjwxRestoreDictModal(type: "991", dictLabel: "正常", dictValue: "1"),
            YjwxRestoreDictModal(type: "992", dictLabel: "异常", dictValue: "0")
        ]
        xjztItem.value = "正常"
        basicBV.addSubview(xjztItem)
        xjztItem.snp.makeConstraints { make in
            make.left.equalTo(line.snp.left)
            make.right.equalTo(line.snp.right)
            make.top.equalTo(line.snp.bottom).offset(15)
            make.height.equalTo(45)
        }
        
        basicBV.addSubview(ycqksmItem)
        ycqksmItem.snp.makeConstraints { make in
            make.left.equalTo(line.snp.left)
            make.right.equalTo(line.snp.right)
            make.top.equalTo(xjztItem.snp.bottom).offset(10)
            make.height.equalTo(116)
        }
        
        imgPickerView.itemHeight = 70
        imgPickerView.rowCount = 4
        basicBV.addSubview(imgPickerView)
        imgPickerView.snp.makeConstraints { make in
            make.top.equalTo(ycqksmItem.snp.bottom).offset(10)
            make.left.equalTo(self.snp.left).offset(13)
            make.right.equalTo(self.snp.right).offset(-13)
            make.width.equalTo(ScreenWidth - 46)
            make.bottom.equalToSuperview().offset(-14)
        }
    }
    
    func setupUI() {
        setupTitleView()
        
        // 巡检结果
        setupBasicView()
        
        // 提交按钮
        self.addSubview(submitBtn)
        submitBtn.snp.makeConstraints { make in
            make.top.equalTo(basicBV.snp.bottom).offset(48)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth - 20)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    lazy var imgPickerView: BSImagePickerView = {
        let picker = BSImagePickerView()
        picker.key = "设备照片"
        picker.maxCount = 6
        picker.rowCount = 4
        return picker
    }()
}
