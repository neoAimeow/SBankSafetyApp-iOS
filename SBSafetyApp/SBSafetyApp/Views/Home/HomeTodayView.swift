//
//  HomeTodayView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/21.
//

import Foundation
import UIKit

class HomeTodayView: UIView {
    let policeV = HomeTodayCard()
    let unarmedV = HomeTodayCard()
    let repairV = HomeTodayCard()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData(withModal modal : HomeStasticModal?) {
        policeV.update(withModal: HomeTodayModal(type: .police, value: "\(modal?.alarmCount ?? 0)"))
        unarmedV.update(withModal: HomeTodayModal(type: .unarmed, value: "\(modal?.uncbfTotal ?? 0)", subValue: "\(modal?.cbfTotal ?? 0)"))
        repairV.update(withModal: HomeTodayModal(type: .repair, value: "\(modal?.repairCount ?? 0)"))
    }
    
    func setupUI() {
        backgroundColor = .white
        layer.masksToBounds = true
        layer.cornerRadius = 10
            
        let itemW = (ScreenWidth - 20) / 3.0
        
        policeV.update(withModal: HomeTodayModal(type: .police, value: "0"))
        addSubview(policeV)
        policeV.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(itemW)
        }
        
        let vLine1 = UIView()
        vLine1.backgroundColor = .hex("#F3F3F3")
        addSubview(vLine1)
        vLine1.snp.makeConstraints { make in
            make.left.equalTo(policeV.snp.right)
            make.top.equalTo(self.snp.top).offset(17.5)
            make.bottom.equalTo(self.snp.bottom).offset(-17.5)
            make.width.equalTo(0.5)
        }
        
        unarmedV.update(withModal: HomeTodayModal(type: .unarmed, value: "0", subValue: "0"))
        addSubview(unarmedV)
        unarmedV.snp.makeConstraints { make in
            make.left.equalTo(policeV.snp.right)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(itemW)
        }
        
        let vLine2 = UIView()
        vLine2.backgroundColor = .hex("#F3F3F3")
        addSubview(vLine2)
        vLine2.snp.makeConstraints { make in
            make.left.equalTo(unarmedV.snp.right)
            make.top.equalTo(self.snp.top).offset(17.5)
            make.bottom.equalTo(self.snp.bottom).offset(-17.5)
            make.width.equalTo(0.5)
        }
        
        repairV.update(withModal: HomeTodayModal(type: .repair, value: "0"))
        addSubview(repairV)
        repairV.snp.makeConstraints { make in
            make.left.equalTo(unarmedV.snp.right)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(itemW)
        }
    }
}

public enum TodayEnum: Int {
    case police   = 0
    case unarmed  = 1
    case repair   = 2
    case seTask   = 3
    case seRepair = 4
}

class HomeTodayModal: NSObject {
    var type: TodayEnum = .police
    var value: String = ""
    var subValue: String?
    var subValue2: String?

    init(type: TodayEnum, value: String, subValue: String? = nil, subValue2: String? = nil) {
        self.type = type
        self.value = value
        self.subValue = subValue
        self.subValue2 = subValue2
    }
}

class HomeTodayCard: UIControl {
    let iconIV = UIImageView()
    let valueL = UILabel()
    let keyL = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(withModal modal: HomeTodayModal) {
        switch modal.type {
        case .police:
            iconIV.image = UIImage(named: "ic_today_police")
            keyL.text = "今日报警"
            valueL.textColor = .hex("#FF7201")
            valueL.text = modal.value
            break
        case .unarmed:
            iconIV.image = UIImage(named: "ic_today_unarmed")
            keyL.text = "今日未布防"
            let value = modal.value
            let text = "\(modal.value) / \(modal.subValue!)"
            let aAttri = NSMutableAttributedString(string: text, attributes: [.font:  UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.hex("#020202")])
            let aRange = NSMakeRange(text.distance(from: text.startIndex, to:text.range(of: value)!.lowerBound), value.count)
            aAttri.addAttribute(.font, value: UIFont.systemFont(ofSize: 17), range: aRange)
            aAttri.addAttribute(.foregroundColor, value: UIColor.hex("#EEAB50"), range: aRange)
            valueL.attributedText = aAttri
            break
        case .repair:
            iconIV.image = UIImage(named: "ic_today_repair")
            keyL.text = "今日报修"
            valueL.textColor = .hex("#2CA9FA")
            valueL.text = modal.value
            break
        case .seTask:
            iconIV.image = UIImage(named: "ic_today_setask")
            keyL.text = "今日巡检/完成/未完成"
            let value = modal.value
            let text = "\(modal.value) / \(modal.subValue!) / \(modal.subValue2!)"
            let aAttri = NSMutableAttributedString(string: text, attributes: [.font:  UIFont.systemFont(ofSize: 17), .foregroundColor: UIColor.hex("#FF7201")])
            let indices = text.enumerated().filter{ $0.element == "/" }.map{ $0.offset }
            for indice in indices {
                aAttri.addAttribute(.foregroundColor, value: UIColor.darkGray, range: NSMakeRange(indice, value.count))
            }
            valueL.attributedText = aAttri
            break
        case .seRepair:
            iconIV.image = UIImage(named: "ic_today_repair")
            keyL.text = "今日维修/完成/未完成"
            let value = "/"
            let text = "\(modal.value) / \(modal.subValue!) / \(modal.subValue2!)"
            let aAttri = NSMutableAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 17), .foregroundColor: UIColor.hex("#2CA9FA")])
            let indices = text.enumerated().filter{ $0.element == "/" }.map{ $0.offset }
            for indice in indices {
                aAttri.addAttribute(.foregroundColor, value: UIColor.darkGray, range: NSMakeRange(indice, value.count))
            }
            valueL.attributedText = aAttri
            break
        }
    }
    
    func setupUI() {
        addSubview(iconIV)
        iconIV.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(12)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(35)
        }
        
        valueL.font = .systemFont(ofSize: 17)
        addSubview(valueL)
        valueL.snp.makeConstraints { make in
            make.top.equalTo(iconIV.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        keyL.textColor = .hex("#ADADAD")
        keyL.font = .systemFont(ofSize: 15)
        addSubview(keyL)
        keyL.snp.makeConstraints { make in
            make.top.equalTo(valueL.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
    }
}
