//
//  VisitorListCell.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/15.
//

import Foundation
import UIKit

class VisitorListCell: BaseTableCell {
    let typeL = UILabel()
    let nameL = UILabel()
    let compL = UILabel()
    let dateL = UILabel()
    let clockIV = UIImageView()

    let statusL = UILabel()

    func reload(withData modal: StandingBookModal?, typeDatas: [StandingBookTypeModal?]) {
        let type = typeDatas.filter({$0?.typeValue == modal?.bookType })[0]
        typeL.text = type?.typeLabel
        
        nameL.text = "\(modal?.attrValue2 ?? "")（\(modal?.attrValue3 ?? "")人）"
        compL.text = modal?.attrValue1
        dateL.text = Date.momentTime(modal?.attrValue6 ?? "")
        statusL.text = modal?.status == "0" ? "未离开" : "已离开"
        
        if modal?.bookType == ElecType.VideoMonitor.rawValue {
            dateL.text = Date.momentTime(modal?.attrValue7 ?? "")
        }
        
    }
    
    override func setupUI() {
        super.setupUI()
        
        typeL.font = UIFont.systemFont(ofSize: 16, weight: .thin)
        typeL.textColor = .hex("#666666")
        addSubview(typeL)
        typeL.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(15)
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
        
        dateL.font = UIFont.systemFont(ofSize: 14)
        dateL.textColor = .hex("#ACACAC")
        addSubview(dateL)
        dateL.snp.makeConstraints { make in
            make.top.equalTo(typeL.snp.bottom).offset(6)
            make.right.equalTo(self.snp.right).offset(-31)
        }
        
        clockIV.image = UIImage(named: "ic_clock")
        addSubview(clockIV)
        clockIV.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(dateL.snp.centerY)
            make.right.equalTo(dateL.snp.left).offset(-6)
        }
        
        statusL.font = UIFont.systemFont(ofSize: 15)
        statusL.textColor = .hex("#306EC8")
        addSubview(statusL)
        statusL.snp.makeConstraints { make in
            make.top.equalTo(dateL.snp.bottom).offset(6)
            make.right.equalTo(dateL.snp.right)
        }
    }
}
