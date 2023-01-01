//
//  InspQualityStatisticsCell.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/24.
//

import Foundation
import UIKit

class InspQualityStatisticsCell: UITableViewCell {
    let branchL = UILabel()
    let orderNumL = UILabel()
    let nameL = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .bg
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reload(withModal modal: InspQualitySModal) {
        branchL.text = modal.branch
        orderNumL.text = "巡检单号：\(modal.orderNum)"
        nameL.text = modal.name
    }
    
    func reload(withTimeModal modal: RRTimeDetailModal) {
        branchL.text = modal.branch
        orderNumL.text = "报修单号：\(modal.orderNum)"
        nameL.text = modal.date
    }
    
    func setupUI() {
        nameL.textColor = .hex("#B6B6B6")
        nameL.font = .systemFont(ofSize: 14)
        nameL.textAlignment = .right
        addSubview(nameL)
        nameL.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom).offset(-16)
            make.right.equalTo(self.snp.right).offset(-12)
            make.width.equalTo(100)
        }
        
        branchL.font = .systemFont(ofSize: 16)
        branchL.textColor = .hex("#333333")
        branchL.numberOfLines = 0
        addSubview(branchL)
        branchL.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(16)
            make.left.equalTo(self.snp.left).offset(12)
            make.right.equalTo(self.snp.right).offset(-12)
        }
        
        orderNumL.font = .systemFont(ofSize: 14)
        orderNumL.textColor = .hex("#306EC8")
        addSubview(orderNumL)
        orderNumL.snp.makeConstraints { make in
            make.top.equalTo(branchL.snp.bottom).offset(6)
            make.left.equalTo(branchL.snp.left)
            make.bottom.equalTo(self.snp.bottom).offset(-16)
        }
        
        let line = UIView()
        line.backgroundColor = .hex("#F3F3F3")
        addSubview(line)
        line.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(self.snp.left).offset(12)
            make.right.equalTo(self.snp.right).offset(-12)
            make.height.equalTo(0.5)
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            self.backgroundColor = .hex("#ECECEC")
        } else {
            self.backgroundColor = .white
        }
    }
}
