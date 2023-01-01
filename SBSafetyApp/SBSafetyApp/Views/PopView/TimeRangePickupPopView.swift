//
//  TimeRangePickupPopView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/13.
//

import Foundation
import UIKit
import JFPopup

protocol TimeRangePickupPopViewDelegate: AnyObject {
    func handleConfirm(start: Date?, end: Date?)
    func handleClose()
}

class TimeRangePickupPopView: UIView {
    var dateMode: UIDatePicker.Mode = .date {
        didSet {
            startPicker.datePickerMode = dateMode
            endPicker.datePickerMode = dateMode
        }
    }
    
    weak var delegate: TimeRangePickupPopViewDelegate?

    let titleL = UILabel()
    let startPicker = UIDatePicker()
    let endPicker = UIDatePicker()

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
        self.delegate?.handleClose()
    }
    
    @objc private func confirmToggle() {
        (self.getFirstViewController() as! JFPopupController).dismiss(animated: true)
        self.delegate?.handleConfirm(start: startPicker.date, end: endPicker.date)
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
        
        titleL.text = "选择时间段"
        titleL.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleL.textColor = .black
        addSubview(titleL)
        titleL.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.snp.top).offset(20)
        }
        
        let itemWidth = (ScreenWidth - 50) / 2.0
        startPicker.date = Date()
        startPicker.locale = Locale(identifier: "zh")
        startPicker.preferredDatePickerStyle = .wheels
        addSubview(startPicker)
        startPicker.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(20)
            make.top.equalTo(titleL.snp.bottom).offset(16)
            make.width.equalTo(itemWidth)
            make.height.equalTo(200)
        }
        
        endPicker.date = Date()
        endPicker.locale = Locale(identifier: "zh")
        endPicker.preferredDatePickerStyle = .wheels
        addSubview(endPicker)
        endPicker.snp.makeConstraints { make in
            make.right.equalTo(self.snp.right).offset(-20)
            make.top.equalTo(startPicker.snp.top)
            make.width.equalTo(itemWidth)
            make.height.equalTo(200)
        }
        
        saveBtn.addTarget(self, action: #selector(confirmToggle), for: .touchUpInside)
        addSubview(saveBtn)
        saveBtn.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(startPicker.snp.bottom).offset(36)
            make.left.equalTo(self.snp.left).offset(32)
            make.right.equalTo(self.snp.right).offset(-32)
            make.height.equalTo(50)
        }
    }
}
