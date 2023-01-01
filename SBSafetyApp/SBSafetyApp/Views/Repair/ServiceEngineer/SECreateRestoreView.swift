//
//  SECreateRestoreView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/29.
//

import Foundation
import UIKit

class SECreateRestoreView: UIScrollView {
    
    // 报修故障
    let basicBV = UIView.createBase()
    let gzppItem = LabelPickerEffect(withPlaceholder: "故障品牌")   // 故障品牌
    let gzlxItem = LabelPickerEffect(withPlaceholder: "故障类型")   // 故障类型
    let gzsbItem = LabelPickerEffect(withPlaceholder: "故障设备")   // 故障设备
    let gzxxItem = LabelPickerEffect(withPlaceholder: "故障现象")   // 故障现象
    let gzyyItem = LabelPickerEffect(withPlaceholder: "故障原因")   // 故障原因
    let wzxxItem = LabelPickerEffect(withPlaceholder: "位置信息", _style: .loction) // 位置信息
    let wxmsItem = TextViewEditEffect(withPlaceholder: "维修描述")  // 维修描述
    let xfcgItem = LabelPickerEffect(withPlaceholder: "修复成功")   // 修复成功
    let ghsbItem = LabelPickerEffect(withPlaceholder: "更换设备")   // 更换设备
    let wxdjItem = TextFieldEditEffect(withPlaceholder: "维修单价（元）") // 维修单价

    // 其他故障
    let otherBV = UIView.createBase()
    let fwlxItem = LabelPickerEffect(withPlaceholder: "服务类型")   // 服务类型
    let fwmsItem = TextViewEditEffect(withPlaceholder: "服务描述")  // 服务描述
    let fwdjItem = TextFieldEditEffect(withPlaceholder: "维修单价（元）") // 维修单价
    
    // 维修报价
    let quotationVC = UIView.createBase()
    let wxbjItem = TextFieldEditEffect(withPlaceholder: "本次维修总费用（元）") // 本次维修总费用

    let submitBtn = UIButton.createPrimaryLarge("提交")

    override init(frame: CGRect) {
        super.init(frame: frame)
        keyboardDismissMode = .interactive
        showsVerticalScrollIndicator = false
        bounces = true
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(withDicts dicts: [[YjwxRestoreDictModal]]) {
        
        if dicts.count > 0 {
            gzppItem.dataSource = dicts[0]
            gzppItem.value = dicts[0][0].dictLabel
        }
        
        if dicts.count > 1 {
            gzlxItem.dataSource = dicts[1]
            gzlxItem.value = dicts[1][0].dictLabel
        }
        if dicts.count > 2 {
            gzsbItem.dataSource = dicts[2]
            gzsbItem.value = dicts[2][0].dictLabel
        }
        if dicts.count > 3 {
            gzxxItem.dataSource = dicts[3]
            gzxxItem.value = dicts[3][0].dictLabel
        }
        if dicts.count > 4 {
            gzyyItem.dataSource = dicts[4]
            gzyyItem.value = dicts[4][0].dictLabel
        }
        
        if dicts.count > 5 {
            fwlxItem.dataSource = dicts[5]
        }

    }
    
    func setupBasicView() {
        addSubview(basicBV)
        basicBV.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth - 20)
        }
        
        let basicTV = TitleItemView(withTitle: "报修故障", hasIcon: false)
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
        
        basicBV.addSubview(gzppItem)
        gzppItem.snp.makeConstraints { make in
            make.left.equalTo(line.snp.left)
            make.right.equalTo(line.snp.right)
            make.top.equalTo(line.snp.top).offset(10)
            make.height.equalTo(45)
        }
        
        basicBV.addSubview(gzlxItem)
        gzlxItem.snp.makeConstraints { make in
            make.left.equalTo(line.snp.left)
            make.right.equalTo(line.snp.right)
            make.top.equalTo(gzppItem.snp.bottom).offset(10)
            make.height.equalTo(45)
        }
        
        basicBV.addSubview(gzsbItem)
        gzsbItem.snp.makeConstraints { make in
            make.left.equalTo(line.snp.left)
            make.right.equalTo(line.snp.right)
            make.top.equalTo(gzlxItem.snp.bottom).offset(10)
            make.height.equalTo(45)
        }
        
        basicBV.addSubview(gzyyItem)
        gzyyItem.snp.makeConstraints { make in
            make.left.equalTo(line.snp.left)
            make.right.equalTo(line.snp.right)
            make.top.equalTo(gzsbItem.snp.bottom).offset(10)
            make.height.equalTo(45)
        }
        
        basicBV.addSubview(gzxxItem)
        gzxxItem.snp.makeConstraints { make in
            make.left.equalTo(line.snp.left)
            make.right.equalTo(line.snp.right)
            make.top.equalTo(gzyyItem.snp.bottom).offset(10)
            make.height.equalTo(45)
        }
        
        basicBV.addSubview(wzxxItem)
        wzxxItem.snp.makeConstraints { make in
            make.left.equalTo(line.snp.left)
            make.right.equalTo(line.snp.right)
            make.top.equalTo(gzxxItem.snp.bottom).offset(10)
            make.height.equalTo(45)
        }
        
        basicBV.addSubview(wxmsItem)
        wxmsItem.snp.makeConstraints { make in
            make.left.equalTo(line.snp.left)
            make.right.equalTo(line.snp.right)
            make.top.equalTo(wzxxItem.snp.bottom).offset(10)
            make.height.equalTo(116)
        }
        
        xfcgItem.dataSource = [
            YjwxRestoreDictModal(type: "991", dictLabel: "是", dictValue: "1"),
            YjwxRestoreDictModal(type: "992", dictLabel: "否", dictValue: "0")
        ]
        xfcgItem.value = "是"
        basicBV.addSubview(xfcgItem)
        xfcgItem.snp.makeConstraints { make in
            make.left.equalTo(line.snp.left)
            make.right.equalTo(line.snp.right)
            make.top.equalTo(wxmsItem.snp.bottom).offset(10)
            make.height.equalTo(45)
        }
        
        ghsbItem.dataSource = [
            YjwxRestoreDictModal(type: "993", dictLabel: "否", dictValue: "0"),
            YjwxRestoreDictModal(type: "994", dictLabel: "是", dictValue: "1")
        ]
        ghsbItem.value = "否"
        basicBV.addSubview(ghsbItem)
        ghsbItem.snp.makeConstraints { make in
            make.left.equalTo(line.snp.left)
            make.right.equalTo(line.snp.right)
            make.top.equalTo(xfcgItem.snp.bottom).offset(10)
            make.height.equalTo(45)
        }
        
        wxdjItem.value = "0"
        wxdjItem.keyL.textColor = .primary
        wxdjItem.valueTF.textColor = .primary
        basicBV.addSubview(wxdjItem)
        wxdjItem.snp.makeConstraints { make in
            make.left.equalTo(line.snp.left)
            make.right.equalTo(line.snp.right)
            make.top.equalTo(ghsbItem.snp.bottom).offset(10)
            make.height.equalTo(45)
            make.bottom.equalToSuperview().offset(-14)
        }
    }
    
    func setupOtheriew() {
        addSubview(otherBV)
        otherBV.snp.makeConstraints { make in
            make.top.equalTo(basicBV.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth - 20)
        }
        
        let otherTV = TitleItemView(withTitle: "其他故障", hasIcon: false)
        otherBV.addSubview(otherTV)
        otherTV.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(46)
        }
        
        let line = UIView()
        line.backgroundColor = .hex("#ECECEC")
        otherBV.addSubview(line)
        line.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(otherTV.snp.bottom)
            make.left.equalToSuperview().offset(13)
            make.right.equalToSuperview().offset(-13)
            make.height.equalTo(0.5)
        }
        
        otherBV.addSubview(fwlxItem)
        fwlxItem.snp.makeConstraints { make in
            make.left.equalTo(line.snp.left)
            make.right.equalTo(line.snp.right)
            make.top.equalTo(line.snp.top).offset(10)
            make.height.equalTo(45)
        }
        
        otherBV.addSubview(fwmsItem)
        fwmsItem.snp.makeConstraints { make in
            make.left.equalTo(line.snp.left)
            make.right.equalTo(line.snp.right)
            make.top.equalTo(fwlxItem.snp.bottom).offset(10)
            make.height.equalTo(116)
        }
        
        fwdjItem.value = "0"
        fwdjItem.keyL.textColor = .primary
        fwdjItem.valueTF.textColor = .primary
        otherBV.addSubview(fwdjItem)
        fwdjItem.snp.makeConstraints { make in
            make.left.equalTo(line.snp.left)
            make.right.equalTo(line.snp.right)
            make.top.equalTo(fwmsItem.snp.bottom).offset(10)
            make.height.equalTo(45)
            make.bottom.equalToSuperview().offset(-14)
        }
    }
    
    func setupQuotationView() {
        addSubview(quotationVC)
        quotationVC.snp.makeConstraints { make in
            make.top.equalTo(otherBV.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth - 20)
//            make.bottom.equalToSuperview().offset(-40)
        }
        
        let quotationTV = TitleItemView(withTitle: "维修报价", hasIcon: false)
        quotationVC.addSubview(quotationTV)
        quotationTV.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(49)
        }
        
        let line = UIView()
        line.backgroundColor = .hex("#ECECEC")
        quotationVC.addSubview(line)
        line.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(quotationTV.snp.bottom)
            make.left.equalToSuperview().offset(13)
            make.right.equalToSuperview().offset(-13)
            make.height.equalTo(0.5)
        }
        
        wxbjItem.value = "0"
        wxbjItem.keyL.textColor = .primary
        wxbjItem.valueTF.textColor = .primary
        quotationVC.addSubview(wxbjItem)
        wxbjItem.snp.makeConstraints { make in
            make.left.equalTo(line.snp.left)
            make.right.equalTo(line.snp.right)
            make.top.equalTo(quotationTV.snp.bottom).offset(10)
            make.height.equalTo(45)
            make.bottom.equalToSuperview().offset(-14)
        }
    }
    
    func setupUI() {
        // 报修故障
        setupBasicView()

        // 其他故障
        setupOtheriew()
        
        // 维修报价
        setupQuotationView()
        
        addSubview(submitBtn)
        submitBtn.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(quotationVC.snp.bottom).offset(20)
            make.height.equalTo(50)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(ScreenWidth - 20)
            make.bottom.equalTo(self.snp.bottom).offset(-30)
        }
    }
}
