//
//  NotificationCell.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/5.
//

import Foundation
import UIKit

class NotificationCell: UITableViewCell {
    let titleL = UILabel()
    let contentL = UILabel()
    let dateL = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reload(withModal modal: Any) {
        titleL.text = "2022年国庆节放假通知"
        contentL.text = "保卫部全体员工于下周一（8月15日）上午9:00在会保卫部全体员工于下周一（8月15日）上午9:00在会"
        dateL.text = "2021年07月05日 10:12"
    }
    
    func setupUI() {
        titleL.textColor = .hex("#333333")
        titleL.font = .systemFont(ofSize: 17)
        addSubview(titleL)
        titleL.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-40)
        }
        
        contentL.font = .systemFont(ofSize: 15)
        contentL.textColor = .hex("#999999")
        addSubview(contentL)
        contentL.snp.makeConstraints { make in
            make.top.equalTo(titleL.snp.bottom).offset(10)
            make.left.equalTo(titleL.snp.left)
            make.right.equalTo(titleL.snp.right)
        }
        
        dateL.textColor = .hex("#BDBDBD")
        dateL.font = .systemFont(ofSize: 14)
        addSubview(dateL)
        dateL.snp.makeConstraints { make in
            make.top.equalTo(contentL.snp.bottom).offset(12)
            make.left.equalTo(titleL.snp.left)
            make.right.equalTo(titleL.snp.right)
        }
        
        arrowIV.image = UIImage(systemName: "chevron.right")
        arrowIV.tintColor = .hex("#A5A5A5")
        arrowIV.contentMode = .scaleAspectFit
        addSubview(arrowIV)
        arrowIV.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(contentL.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-10)
            make.width.equalTo(8)
        }
        
        addSubview(line)
        line.snp.makeConstraints { (make) -> Void in
            make.bottom.equalToSuperview()
            make.left.equalTo(contentL.snp.left)
            make.right.equalTo(contentL.snp.right)
            make.height.equalTo(0.5)
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            backgroundColor = .hex("#ECECEC")
        } else {
            backgroundColor = .white
        }
    }
    
    lazy var arrowIV: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "chevron.right"))
        iv.tintColor = .hex("#A5A5A5")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var line: UIView = {
        let li = UIView()
        li.backgroundColor = .hex("#F3F3F3")
        return li
    }()
}


