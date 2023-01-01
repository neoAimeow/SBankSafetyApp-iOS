//
//  RepairReportCell.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/28.
//

import Foundation
import UIKit

class RepairReportCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .white
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reload(withModal modal: RepairReportModal) {
        iconIV.image = UIImage(named: modal.icon!)
        nameL.text = modal.name
    }
    
    func setupUI() {
        addSubview(iconIV)
        iconIV.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(30)
        }
        
        addSubview(nameL)
        nameL.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconIV.snp.right).offset(15)
        }
        
        addSubview(arrowIV)
        arrowIV.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
            make.width.equalTo(8)
        }
        
        addSubview(line)
        line.snp.makeConstraints { (make) -> Void in
            make.bottom.equalToSuperview()
            make.left.equalTo(nameL.snp.left)
            make.right.equalTo(arrowIV.snp.right)
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
    
    
    lazy var iconIV: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    lazy var nameL: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16)
        l.textColor = .hex("#333333")
        return l
    }()
    
    lazy var arrowIV: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "chevron.right"))
        iv.tintColor = .hex("#A5A5A5")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var line: UIView = {
        let li = UIView()
        li.backgroundColor = .hex("#F4F4F4")
        return li
    }()
}
