//
//  DateEffect.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/15.
//

import Foundation
import UIKit
import JFPopup

public enum DateEffectEnum: Int {
    case normal = 0
    case range = 1
}

class DateEffect: BaseEffect {
    
    var value: String? {
        set {
            valueL.text = newValue
//            ctl.isHidden = value != nil
            isEdited = (newValue == nil || newValue == "") ? false : true
        }
        get {
            return valueL.text
        }
    }
    
    var dateMode: UIDatePicker.Mode = .date
    
    var didSelectDateWith:((_ dateStr: String) -> ())?

    var maximumDate: Date?

    var dateType: DateEffectEnum = .normal

    let valueL = UILabel()
    
    override func updateTextEntry() {
        if isEdited {
            UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: .beginFromCurrentState, animations: ({
                self.ctl.placeL.layer.opacity = 0.0
                self.ctl.backgroundColor = .clear
            }), completion: { _ in })
        } else {
            UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: .beginFromCurrentState, animations: ({
                self.ctl.placeL.layer.opacity = 1.0
                self.ctl.backgroundColor = .white
            }), completion: { _ in})
        }
    }

    override func editTapped() {
        self.isEdited = true
        
        if dateType == .normal {
            self.getFirstViewController()?.popup.bottomSheet(with: false, bgColor: .black.withAlphaComponent(0.65)) {
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
        
        if dateType == .range {
            self.getFirstViewController()?.popup.bottomSheet(with: false, bgColor: .black.withAlphaComponent(0.65)) {
                let v = CornerView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 386))
                v.corners = SBRectCorner(topLeft: 12, topRight: 12, bottomLeft: 0, bottomRight: 0)
                v.backgroundColor = .white
                let rPopV = TimeRangePickupPopView()
                rPopV.delegate = self
                rPopV.dateMode = dateMode
                v.addSubview(rPopV)
                rPopV.snp.makeConstraints { (make) -> Void in
                    make.top.right.left.bottom.equalToSuperview()
                }
                return v
            }
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        valueL.textColor = .black
        valueL.font = UIFont.systemFont(ofSize: 16)
        insertSubview(valueL, aboveSubview: keyL)
        valueL.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(33)
            make.top.equalTo(keyL.snp.bottom).offset(-2)
            make.left.equalTo(self.snp.left).offset(12)
            make.right.equalTo(self.snp.right).offset(-12)
        }
    }
}

extension DateEffect: PickupPopViewDelegate {
    func handleConfirm(_ picker: UIDatePicker) {
        let fmt = DateFormatter()
        if dateMode == .date {
            fmt.dateFormat = "yyyy年MM月dd日"
        } else if dateMode == .time {
            fmt.dateFormat = "hh:mm"
        }
        let dateStr = fmt.string(from: picker.date)
        valueL.text = dateStr
        didSelectDateWith?(dateStr)

    }
    
    func handleClose(_ picker: UIDatePicker) {
        isEdited = (valueL.text == nil || valueL.text == "") ? false : true
    }
}

extension DateEffect: TimeRangePickupPopViewDelegate {
    func handleConfirm(start: Date?, end: Date?) {
        let fmt = DateFormatter()
        if dateMode == .date {
            fmt.dateFormat = "yyyy年MM月dd日"
        } else if dateMode == .time {
            fmt.dateFormat = "hh:mm"
        }
        let startStr = fmt.string(from: start!)
        let endStr = fmt.string(from: end!)

        valueL.text = "\(startStr)-\(endStr)"
    }

    func handleClose() {
        isEdited = (valueL.text == nil || valueL.text == "") ? false : true
    }
}
