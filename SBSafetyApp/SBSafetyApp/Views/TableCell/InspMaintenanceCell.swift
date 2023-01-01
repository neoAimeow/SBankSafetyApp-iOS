//
//  InspMaintenanceCell.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/23.
//

import Foundation
import UIKit

class InspMaintenanceCell: UITableViewCell {
    let baseV = UIView()
    let nameL = UILabel()
    let iconIV = UIImageView()
    let ycL = PaddingLabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .bg
        setupUI()
    }
    
    func reload(withModal modal: ParTemplateModal?) {
        nameL.text = modal?.dictLabel
        
        switch modal?.isAbnormal {
        case 0:
            iconIV.image = UIImage(named: "ic_main_wrw")
            break
        case 1:
            iconIV.image = UIImage(named: "ic_main_wwc")
            break
        case 2:
            iconIV.image = UIImage(named: "ic_main_ywc")
            break
        default: break
        }
        
        ycL.isHidden = modal?.sfyc == 0
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
            make.height.width.equalTo(34)
        }
        
        nameL.textColor = .hex("#333333")
        nameL.font = .systemFont(ofSize: 15)
        baseV.addSubview(nameL)
        nameL.snp.makeConstraints { make in
            make.centerY.equalTo(baseV.snp.centerY)
            make.left.equalTo(iconIV.snp.right).offset(14)
        }
        
        ycL.text = "异常"
        ycL.font = .systemFont(ofSize: 14)
        ycL.textColor = .hex("#FF0000")
        ycL.layer.borderColor = UIColor.hex("#FF0000").cgColor
        ycL.layer.borderWidth = 0.5
        ycL.insets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        baseV.addSubview(ycL)
        ycL.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(nameL.snp.right).offset(8)
            make.centerY.equalTo(baseV.snp.centerY)
            make.height.equalTo(18)
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

