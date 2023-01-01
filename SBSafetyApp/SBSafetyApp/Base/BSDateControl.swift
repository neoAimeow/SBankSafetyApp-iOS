//
//  BSDateControl.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/23.
//

import Foundation
import UIKit

class BSDateControl: UIView {
    let nameL = UILabel()
    let iconL = UIImageView(image: UIImage(systemName: "chevron.down"))
    
    var dateMode: UIDatePicker.Mode = .date
    var maximumDate: Date?
    
    open var didSelectDateWith:((_ date: Date) -> ())?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func actionTapped() {
        self.getFirstViewController()?.popup.bottomSheet(bgColor: .black.withAlphaComponent(0.65)) {
            let v = CornerView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 386))
            v.corners = SBRectCorner(topLeft: 12, topRight: 12, bottomLeft: 0, bottomRight: 0)
            v.backgroundColor = .white
            let rPopV = PickupPopView()
            rPopV.delegate = self
            rPopV.dateMode = dateMode
            rPopV.maximumDate = maximumDate
            v.addSubview(rPopV)
            rPopV.snp.makeConstraints { (make) -> Void in
                make.top.right.left.bottom.equalToSuperview()
            }
            return v
        }
    }
    
    // MARK: - Setup
    
    func setupUI() {
        backgroundColor = .white
        
        let baseV = UIView()
        addSubview(baseV)
        baseV.snp.makeConstraints { make in
            make.height.centerX.centerY.equalToSuperview()
        }
        
        nameL.text = "时间（全部）"
        nameL.font = .systemFont(ofSize: 15)
        nameL.textColor = .hex("#666666")
        baseV.addSubview(nameL)
        nameL.snp.makeConstraints { make in
            make.centerY.left.equalToSuperview()
        }

        iconL.contentMode = .scaleAspectFit
        iconL.tintColor = .hex("#D2D2D2")
        baseV.addSubview(iconL)
        iconL.snp.makeConstraints { make in
            make.centerY.right.equalToSuperview()
            make.left.equalTo(nameL.snp.right).offset(12)
            make.right.equalTo(baseV.snp.right)
            make.width.equalTo(10)
        }
        
        let ctl = UIControl()
        ctl.addTarget(self, action: #selector(actionTapped), for: .touchUpInside)
        addSubview(ctl)
        ctl.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}

extension BSDateControl: PickupPopViewDelegate {
    func handleConfirm(_ picker: UIDatePicker) {
        let fmt = DateFormatter()
        if dateMode == .date {
            fmt.dateFormat = "yyyy年MM月dd日"
        } else if dateMode == .time {
            fmt.dateFormat = "hh:mm"
        }
        let dateStr = fmt.string(from: picker.date)
        nameL.text = dateStr
        
        didSelectDateWith?(picker.date)
    }
    
    func handleClose(_ picker: UIDatePicker) {
//        isEdited = (nameL.text == nil || nameL.text == "") ? false : true
    }
}
