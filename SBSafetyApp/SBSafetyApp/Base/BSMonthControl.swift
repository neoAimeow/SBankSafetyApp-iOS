//
//  BSMonthControl.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/28.
//

import Foundation
import UIKit

class BSMonthControl: UIView {
    let nameL = UILabel()
    let iconL = UIImageView(image: UIImage(systemName: "chevron.down"))
    
    var year = Calendar.current.component(.year, from: Date())
    var month = Calendar.current.component(.month, from: Date())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func actionTapped() {
        getFirstViewController()?.popup.bottomSheet(bgColor: .black.withAlphaComponent(0.65)) {
            let v = CornerView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 386))
            v.corners = SBRectCorner(topLeft: 12, topRight: 12, bottomLeft: 0, bottomRight: 0)
            v.backgroundColor = .white
            let rPopV = MonthPickupPopView()
//            rPopV.picker.month = month
//            rPopV.picker.year = year
            rPopV.picker.date = Calendar.current.date(from: DateComponents(year: year, month: month))!
            rPopV.delegate = self
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
        
        nameL.text = "\(year)年\(month)月"
        nameL.font = .systemFont(ofSize: 15)
        baseV.addSubview(nameL)
        nameL.snp.makeConstraints { make in
            make.centerY.left.equalToSuperview()
        }

        iconL.contentMode = .scaleAspectFit
        iconL.tintColor = .hex("#868484")
        baseV.addSubview(iconL)
        iconL.snp.makeConstraints { make in
            make.centerY.right.equalToSuperview()
            make.left.equalTo(nameL.snp.right).offset(12)
            make.right.equalTo(baseV.snp.right)
            make.width.equalTo(12)
        }
        
        let ctl = UIControl()
        ctl.addTarget(self, action: #selector(actionTapped), for: .touchUpInside)
        addSubview(ctl)
        ctl.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}

extension BSMonthControl: MonthPickupPopViewDelegate {
    func handleConfirm(_ picker: BSDatePicker) {
        year = Calendar.current.component(.year, from: picker.date)
        month = Calendar.current.component(.month, from: picker.date)
        nameL.text = "\(year)年\(month)月"
    }
    
    func handleClose(_ picker: BSDatePicker) {
        
    }
}
