//
//  BSDateRangeControl.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/11.
//

import Foundation
import UIKit

class BSDateRangeControl: UIView {
    let nameL = UILabel()
    let dateL = UILabel()
    let iconL = UIImageView(image: UIImage(systemName: "chevron.down"))
    
    open var didSelectRangeWith:((_ start: Date, _ end: Date) -> ())?

    var dateMode: BSDateFormatType = .default
    var startDate: Date?
    var endDate: Date?
    
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
            let rPopV = DateRangePickupPopView()
            rPopV.delegate = self
            rPopV.dateMode = dateMode
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
        
        nameL.text = "时间"
        nameL.font = .systemFont(ofSize: 15)
        nameL.textColor = .hex("#666666")
        baseV.addSubview(nameL)
        nameL.snp.makeConstraints { make in
            make.centerY.left.equalToSuperview()
        }
        
        dateL.text = "(全部)"
        dateL.font = .systemFont(ofSize: 15)
        dateL.textColor = .hex("#666666")
        dateL.numberOfLines = 0
        baseV.addSubview(dateL)
        dateL.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(nameL.snp.right).offset(6)
        }
        
        iconL.contentMode = .scaleAspectFit
        iconL.tintColor = .hex("#D2D2D2")
        baseV.addSubview(iconL)
        iconL.snp.makeConstraints { make in
            make.centerY.right.equalToSuperview()
            make.left.equalTo(dateL.snp.right).offset(6)
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

extension BSDateRangeControl: DateRangePickupPopViewDelegate {
    func handleConfirm(start: Date?, end: Date?) {
        let fmt = DateFormatter()
        if dateMode == .default {
            fmt.dateFormat = "yyyy年MM月dd日"
        } else if dateMode == .yearMonth {
            fmt.dateFormat = "yyy年MM月"
        }
        let startStr = fmt.string(from: start!)
        let endStr = fmt.string(from: end!)
        dateL.text = "\(startStr)\n\(endStr)"
        
        didSelectRangeWith?(start!, end!)
    }
    
    func handleClose() {
        
    }
}
