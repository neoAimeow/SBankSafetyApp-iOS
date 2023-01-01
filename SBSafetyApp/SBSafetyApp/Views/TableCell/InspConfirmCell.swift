//
//  InspConfirmCell.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/28.
//

import Foundation
import UIKit

class InspConfirmCell: InspListCell {
    override func setupUI() {
        super.setupUI()
        statusL.isHidden = true
        
        baseV.addSubview(confirmBtn)
        confirmBtn.snp.makeConstraints { make in
            make.centerY.equalTo(branchL.snp.centerY)
            make.right.equalTo(baseV.snp.right).offset(-13)
            make.height.equalTo(20)
            make.width.equalTo(60)
        }
    }
    
    lazy var confirmBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("巡检确认", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 12)
        btn.setBGColor(.primary, for: .normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 10
        return btn
    }()
}
