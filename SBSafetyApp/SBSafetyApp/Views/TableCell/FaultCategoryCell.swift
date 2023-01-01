//
//  FaultCategoryCell.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/27.
//

import Foundation
import UIKit

class FaultCategoryCell: UITableViewCell {
    let selectIV = UIImageView()
    let nameL = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reload(withModal modal: YjwxGzModal, cur: YjwxGzModal?) {
        nameL.text = modal.fwfcmc
        if cur != nil && modal.fwfcid == cur!.fwfcid {
            selectIV.image = UIImage(systemName: "checkmark.circle.fill")
            selectIV.tintColor = .primary
        } else {
            selectIV.image = UIImage(systemName: "circle.fill")
            selectIV.tintColor = .hex("#EDEDED")
        }
    }
    
    func setupUI() {
        selectIV.image = UIImage(systemName: "circle.fill")
        addSubview(selectIV)
        selectIV.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.snp.left).offset(10)
        }
        
        nameL.font = UIFont.systemFont(ofSize: 15)
        nameL.textColor = .hex("#0A0A0A")
        addSubview(nameL)
        nameL.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(selectIV.snp.right).offset(11)
        }
        
        let line = UIView()
        line.backgroundColor = .hex("#F3F3F3")
        addSubview(line)
        line.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.height.equalTo(0.5)
        }
    }
}
