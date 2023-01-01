//
//  InspCreateTemplateCell.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/22.
//

import Foundation
import UIKit

class InspCreateTemplateCell: UITableViewCell {
    let baseV = UIView()
    let nameL = UILabel()
    let iconIV = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .bg
        setupUI()
    }
    
    func reload(withModal modal: InspTemplateModal) {
        iconIV.image = UIImage(named: modal.icon)
        nameL.text = modal.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        baseV.backgroundColor = .white
        baseV.layer.cornerRadius = 10
        baseV.layer.masksToBounds = true
        contentView.addSubview(baseV)
        baseV.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
        }

        baseV.addSubview(iconIV)
        iconIV.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(baseV.snp.left).offset(22)
            make.centerY.equalTo(baseV.snp.centerY)
            make.height.width.equalTo(30)
        }
        
        nameL.textColor = .hex("#333333")
        nameL.font = .systemFont(ofSize: 15)
        baseV.addSubview(nameL)
        nameL.snp.makeConstraints { make in
            make.centerY.equalTo(baseV.snp.centerY)
            make.left.equalTo(iconIV.snp.right).offset(18)
            make.right.equalTo(baseV.snp.right).offset(-10)
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            baseV.backgroundColor = .hex("#ECECEC")
        } else {
            baseV.backgroundColor = .white
        }
    }
}

