//
//  MonthPickupPopView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/25.
//

import Foundation
import UIKit
import JFPopup

protocol MonthPickupPopViewDelegate: AnyObject {
    func handleConfirm(_ picker: BSDatePicker)
    func handleClose(_ picker: BSDatePicker)
}

class MonthPickupPopView: UIView {
    weak var delegate: MonthPickupPopViewDelegate?

    let titleL = UILabel()
    let picker = BSDatePicker()
    let saveBtn = UIButton.createPrimaryLarge("确定")

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func closeToggle() {
        (self.getFirstViewController() as! JFPopupController).dismiss(animated: true)
        self.delegate?.handleClose(picker)
    }
    
    @objc private func confirmToggle() {
        (self.getFirstViewController() as! JFPopupController).dismiss(animated: true)
        self.delegate?.handleConfirm(picker)
    }
    
    func setupUI() {
        let closeBtn = UIButton(type: .custom)
        closeBtn.setTitle("✕", for: .normal)
        closeBtn.setTitleColor(.black, for: .normal)
        closeBtn.setTitleColor(.gray, for: .highlighted)
        closeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 26)
        closeBtn.addTarget(self, action: #selector(closeToggle), for: .touchUpInside)
        addSubview(closeBtn)
        closeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.width.height.equalTo(48)
        }
        
        titleL.text = "选择日期"
        titleL.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleL.textColor = .black
        addSubview(titleL)
        titleL.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.snp.top).offset(20)
        }
        
        picker.dateFormatType = .yearMonth
        picker.minimumDate = Date().addingRmoving(years: -10)
//        picker.maximumDate = Date()
        addSubview(picker)
        picker.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(titleL.snp.bottom).offset(16)
            make.width.equalTo(ScreenWidth - 80)
            make.height.equalTo(200)
        }
        
        addSubview(picker)
        picker.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(40)
            make.right.equalTo(self.snp.right).offset(-40)
            make.top.equalTo(titleL.snp.bottom).offset(16)
            make.height.equalTo(200)
        }
        
        saveBtn.addTarget(self, action: #selector(confirmToggle), for: .touchUpInside)
        addSubview(saveBtn)
        saveBtn.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(picker.snp.bottom).offset(36)
            make.left.equalTo(self.snp.left).offset(32)
            make.right.equalTo(self.snp.right).offset(-32)
            make.height.equalTo(50)
        }
    }
}
