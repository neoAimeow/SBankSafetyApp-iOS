//
//  HomeDateView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/16.
//

import Foundation
import UIKit

class HomeDateView: UIView {
    var date: Date = Date().yesterday() {
        didSet {
            updateEntry()
        }
    }

    var didSelectDateWith:((_ date: Date) -> ())?
    
    var dateMode: UIDatePicker.Mode = .date
    
    let keyL = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateEntry() {
        let value1 = date.elTodayDateCN()
        let text = "\(value1)完成情况"
        let attri = NSMutableAttributedString(string: text, attributes: [.font:  UIFont.systemFont(ofSize: 15), .foregroundColor: UIColor.hex("#444444")])
        let v1Range = NSMakeRange(text.distance(from: text.startIndex, to:text.range(of: value1)!.lowerBound), value1.count)
        attri.addAttribute(.foregroundColor, value: UIColor.hex("#306EC8"), range: v1Range)
        keyL.attributedText = attri
    }
    
    @objc func actionTapped() {
        self.getFirstViewController()?.popup.bottomSheet(bgColor: .black.withAlphaComponent(0.65)) {
            let v = CornerView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 386))
            v.corners = SBRectCorner(topLeft: 12, topRight: 12, bottomLeft: 0, bottomRight: 0)
            v.backgroundColor = .white
            let rPopV = PickupPopView()
            rPopV.delegate = self
            rPopV.dateMode = dateMode
            rPopV.maximumDate = Date()
            rPopV.date = date
            v.addSubview(rPopV)
            rPopV.snp.makeConstraints { (make) -> Void in
                make.top.right.left.bottom.equalToSuperview()
            }
            return v
        }
    }
    
    // MARK: - Setup
    
    func setupUI() {
        keyL.font = UIFont.systemFont(ofSize: 15)
        addSubview(keyL)
        keyL.snp.makeConstraints { make in
            make.top.bottom.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        
        let nameL = UILabel()
        nameL.text = "选择日期"
        nameL.font = .systemFont(ofSize: 15)
        nameL.textColor = .hex("#666666")
        addSubview(nameL)
        nameL.snp.makeConstraints { make in
            make.top.bottom.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
        }

        let iconL = UIImageView(image: UIImage(named: "ic_day"))
        iconL.contentMode = .scaleAspectFit
        iconL.tintColor = .hex("#666666")
        addSubview(iconL)
        iconL.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(nameL.snp.left).offset(-4)
            make.width.equalTo(12)
        }
        
        let ctl = UIControl()
        ctl.addTarget(self, action: #selector(actionTapped), for: .touchUpInside)
        addSubview(ctl)
        ctl.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview()
            make.left.equalTo(iconL.snp.left)
        }
        
        updateEntry()
    }
}

extension HomeDateView: PickupPopViewDelegate {
    func handleClose(_ picker: UIDatePicker) {}
    
    func handleConfirm(_ picker: UIDatePicker) {
        self.date = picker.date
        didSelectDateWith?(picker.date)
    }
}
