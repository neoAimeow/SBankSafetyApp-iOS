//
//  SEHomeTodayView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/11.
//

import Foundation
import UIKit

class SEHomeTodayView: UIView {
    let taskV = HomeTodayCard()
    let repairV = HomeTodayCard()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData(withModal modal : HomeStasticModal?) {
        taskV.update(withModal: HomeTodayModal(type: .seTask, value: "\(modal?.alarmCount ?? 0)"))
        repairV.update(withModal: HomeTodayModal(type: .seRepair, value: "\(modal?.repairCount ?? 0)"))
    }
    
    func setupUI() {
        backgroundColor = .white
        layer.masksToBounds = true
        layer.cornerRadius = 10
            
        let itemW = (ScreenWidth - 28) / 2.0
        
        taskV.update(withModal: HomeTodayModal(type: .seTask, value: "0", subValue: "0", subValue2: "0"))
        addSubview(taskV)
        taskV.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(itemW)
        }
        
        let vLine1 = UIView()
        vLine1.backgroundColor = .hex("#F3F3F3")
        addSubview(vLine1)
        vLine1.snp.makeConstraints { make in
            make.left.equalTo(taskV.snp.right)
            make.top.equalTo(self.snp.top).offset(17.5)
            make.bottom.equalTo(self.snp.bottom).offset(-17.5)
            make.width.equalTo(0.5)
        }
        
        repairV.update(withModal: HomeTodayModal(type: .seRepair, value: "0", subValue: "0", subValue2: "0"))
        addSubview(repairV)
        repairV.snp.makeConstraints { make in
            make.left.equalTo(taskV.snp.right)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(itemW)
        }
    }
}
