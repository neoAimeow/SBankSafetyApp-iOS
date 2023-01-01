//
//  ElecHistoryCell.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/17.
//

import Foundation
import UIKit

/**
 enum ElecType: String {
     case ATM = "A" // ATM机补钞间人员出入登记簿
     case SecurityLegal = "B" // 安全保卫法制宣传教育记录簿
     case InfraredArm = "C" // 红外线布、撤防记录簿
     case Repair = "D" // 机防、物防设施维修、保养记录簿
     case OutMonitor = "E" // 监控室外来人员登记簿
     case VideoMonitor = "F" // 监控室外来人员借、调阅录像资料登记簿
     case CheckVideo = "G" // 检查数码录像监控记录簿
     case SimpleWarehouse = "H" // 简易库人员出入登记簿
     case CashBox = "I" // 接、送库款箱记录簿
     case OutBusiness = "J" // 进入营业室外来人员登记簿
     case SelfCheck = "K" // 营业结束安全保卫自查表
     case SecurityCheck = "L" // 营业网点安全防范检查表
 }
 */
class ElecHistoryCell: BaseTableCell {
    let typeL = UILabel()
    let nameL = UILabel()
    let compL = UILabel()
    let msgL = UILabel()

    func reload(withData _data: StandingBookModal, isLast: Bool, typeDatas: [StandingBookTypeModal?]) {
        let type = typeDatas.filter({$0?.typeValue == _data.bookType })[0]
        typeL.text = type?.typeLabel
        
        line.isHidden = isLast

        nameL.text = "\(_data.attrValue2 ?? "")（\(_data.attrValue3 ?? "")人）"
        compL.text = _data.attrValue1
        msgL.text = _data.attrValue4
        
        let bookType: ElecType = ElecType(rawValue: _data.bookType!)!
        switch bookType {
        case .ATM, .SimpleWarehouse:
            nameL.text = "\(_data.attrValue2 ?? "")（\(_data.attrValue3 ?? "")人）"
            compL.text = _data.attrValue1
            msgL.text = _data.attrValue4
            break
        case .SecurityLegal, .VideoMonitor:
            nameL.text = _data.attrValue2
            compL.text = _data.attrValue3
            msgL.text = _data.attrValue5
            break
        case .InfraredArm:
            nameL.text = _data.attrValue0
            compL.text = _data.attrValue2
            msgL.text = _data.attrValue4
            break
        case .Repair:
            nameL.text = _data.attrValue4
            compL.text = _data.attrValue3
            msgL.text = _data.attrValue1
            break
        case .OutMonitor, .OutBusiness:
            nameL.text = "\(_data.attrValue2 ?? "")（\(_data.attrValue3 ?? "")人）"
            compL.text = _data.attrValue1
            msgL.text = _data.attrValue5
            break
        case .CheckVideo:
            nameL.text = _data.attrValue8
            compL.text = _data.attrValue6
            msgL.text = _data.attrValue2
            break
        case .CashBox:
            nameL.text = _data.attrValue3
            compL.text = _data.attrValue7
            msgL.text = _data.attrValue1
            break
        case .SelfCheck:
            nameL.text = "营业安全保卫自查"
            compL.text = _data.attrValue11
            msgL.text = _data.attrValue12
            break
        case .SecurityCheck:
            nameL.text = "网点安全防范检查"
            compL.text = _data.attrValue33
            msgL.text = _data.attrValue32
            break
        }
        
    }
    
    override func setupUI() {
        super.setupUI()
        backgroundColor = .white
        
        typeL.font = UIFont.systemFont(ofSize: 16, weight: .thin)
        typeL.textColor = .hex("#666666")
        addSubview(typeL)
        typeL.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(20)
            make.left.equalTo(self.snp.left).offset(10)
        }

        nameL.font = UIFont.systemFont(ofSize: 17)
        nameL.textColor = .hex("#333333")
        addSubview(nameL)
        nameL.snp.makeConstraints { make in
            make.top.equalTo(typeL.snp.bottom).offset(10)
            make.left.equalTo(self.snp.left).offset(10)
        }
        
        compL.font = UIFont.systemFont(ofSize: 14)
        compL.textColor = .hex("#BABABA")
        addSubview(compL)
        compL.snp.makeConstraints { make in
            make.top.equalTo(nameL.snp.bottom).offset(6)
            make.left.equalTo(nameL.snp.left)
        }
        
        msgL.font = UIFont.systemFont(ofSize: 14)
        msgL.textColor = .hex("#777777")
        msgL.textAlignment = .right
        addSubview(msgL)
        msgL.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-31)
            make.width.equalTo(150)
        }
    }
}
