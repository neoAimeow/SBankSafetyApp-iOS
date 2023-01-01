//
//  ElecPrintCell.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/24.
//

import Foundation
import UIKit

class ElecPrintCell: UITableViewCell {
    let selectIV = UIImageView()
    let dateL = UILabel()
    let numL = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reload(withModal modal: ElecPrintModal) {
        dateL.text = modal.date
        numL.text = "\(modal.num)条记录"
        if modal.isSelected {
            selectIV.image = UIImage(systemName: "checkmark.square.fill")
            selectIV.tintColor = .primary
        } else {
            selectIV.image = UIImage(systemName: "square.fill")
            selectIV.tintColor = .hex("#EDEDED")
        }
    }
    
    func setupUI() {        
        selectIV.image = UIImage(systemName: "square.fill")
        addSubview(selectIV)
        selectIV.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.snp.left).offset(10)
        }
        
        dateL.font = UIFont.systemFont(ofSize: 15)
        dateL.textColor = .hex("#0A0A0A")
        addSubview(dateL)
        dateL.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(selectIV.snp.right).offset(11)
        }
        
        numL.font = UIFont.systemFont(ofSize: 14)
        numL.textColor = .hex("#909090")
        addSubview(numL)
        numL.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-11)
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
