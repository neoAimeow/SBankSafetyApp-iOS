//
//  BranchSearchCell.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/29.
//

import Foundation
import UIKit

class BranchSearchCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .white
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reload(withModal modal: DeptModal) {
        iconL.text = "\(modal.deptName!.prefix(1))"
        nameL.text = modal.deptName
    }
    
    func setupUI() {
        addSubview(iconL)
        iconL.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(25)
            make.width.height.equalTo(40)
        }
        
        addSubview(nameL)
        nameL.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconL.snp.right).offset(18)
        }
        
        addSubview(line)
        line.snp.makeConstraints { (make) -> Void in
            make.bottom.equalToSuperview()
            make.left.equalTo(nameL.snp.left)
            make.right.equalTo(self.snp.right).offset(-24)
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
    
    
    lazy var iconL: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 18)
        l.backgroundColor = .randomLightColor
        l.textColor = .white
        l.textAlignment = .center
        l.layer.cornerRadius = 20
        l.layer.masksToBounds = true
        return l
    }()
    
    lazy var nameL: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16)
        l.textColor = .hex("#333333")
        return l
    }()
    
    lazy var line: UIView = {
        let li = UIView()
        li.backgroundColor = .hex("#E5E5E5")
        return li
    }()
}
