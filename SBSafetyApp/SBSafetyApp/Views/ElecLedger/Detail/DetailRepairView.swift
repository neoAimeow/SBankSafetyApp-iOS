//
//  DetailRepairView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/17.
//

import Foundation
import UIKit

class DetailRepairView: UIScrollView {
    let dateV = ElecItemView()
    let itemV = ElecItemView()
    let resultV = ElecItemView()
    let compV = ElecItemView()
    let repairV = ElecItemView()
    let receptionistV = ElecItemView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        showsVerticalScrollIndicator = false
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData(_ modal: StandingBookModal) {
        dateV.updateUI(withValue:Date.momentDate(modal.attrValue0 ?? ""))
        itemV.updateUI(withValue: modal.attrValue1)
        resultV.updateUI(withValue: modal.attrValue2)
        compV.updateUI(withValue: modal.attrValue3)
        repairV.updateUI(withValue: modal.attrValue4)
        receptionistV.updateUI(withValue: modal.attrValue5)
    }

    func setupUI() {
        let noteV = UIView()
        noteV.backgroundColor = .white
        noteV.layer.cornerRadius = 10
        addSubview(noteV)
        noteV.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        let userTV = TitleItemView(withTitle: "维修、保养记录")
        noteV.addSubview(userTV)
        userTV.snp.makeConstraints { make in
            make.top.equalTo(noteV.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(46)
        }
        
        dateV.key = "日期"
        noteV.addSubview(dateV)
        dateV.snp.makeConstraints { make in
            make.top.equalTo(userTV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        itemV.key = "维修保养项目"
        noteV.addSubview(itemV)
        itemV.snp.makeConstraints { make in
            make.top.equalTo(dateV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(dateV.snp.height)
        }
        
        resultV.key = "维修保养结果"
        noteV.addSubview(resultV)
        resultV.snp.makeConstraints { make in
            make.top.equalTo(itemV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(dateV.snp.height)
        }
        
        compV.key = "维修保养单位"
        noteV.addSubview(compV)
        compV.snp.makeConstraints { make in
            make.top.equalTo(resultV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(dateV.snp.height)
        }
        
        repairV.key = "维修保养人"
        noteV.addSubview(repairV)
        repairV.snp.makeConstraints { make in
            make.top.equalTo(compV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(dateV.snp.height)
        }
        
        receptionistV.key = "接待人"
        noteV.addSubview(receptionistV)
        receptionistV.snp.makeConstraints { make in
            make.top.equalTo(repairV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(dateV.snp.height)
            make.bottom.equalTo(noteV.snp.bottom).offset(-10)
        }
        
        let bottomIV = UIImageView(image: UIImage(named: "elec_bottom"))
        addSubview(bottomIV)
        bottomIV.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(noteV.snp.bottom).offset(40)
            make.bottom.equalTo(self.snp.bottom).offset(-16)
            make.height.equalTo(24)
        }
    }
}
