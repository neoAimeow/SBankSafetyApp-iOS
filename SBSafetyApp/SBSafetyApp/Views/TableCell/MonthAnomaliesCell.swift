//
//  MonthAnomaliesCell.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/22.
//

import Foundation
import UIKit

class MonthAnomaliesCell: UITableViewCell {
    let titleL = UILabel()
    let dateL = UILabel()
    let actionL = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .bg
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reload(withData: Any) {
        titleL.text = "网点每天晚上拍照上传门头招牌的照片门前区域网点每天晚上拍照上传门头招牌的照片门前区域"
        dateL.text = "发现时间：2022-09-26 07:00~08:30"
        actionL.text = "未整改"
    }
    
    func setupUI() {
        actionL.text = "未整改"
        actionL.textColor = .hex("#FF0000")
        actionL.font = .systemFont(ofSize: 14)
        addSubview(actionL)
        actionL.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(22)
            make.right.equalTo(self.snp.right).offset(-12)
            make.width.equalTo(40)
        }
        
        titleL.font = .systemFont(ofSize: 17)
        titleL.textColor = .hex("#333333")
        titleL.numberOfLines = 0
        addSubview(titleL)
        titleL.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(20)
            make.left.equalTo(self.snp.left).offset(12)
            make.right.equalTo(actionL.snp.left).offset(-12)
        }
        
        dateL.font = .systemFont(ofSize: 15)
        dateL.textColor = .hex("#CBCBCB")
        addSubview(dateL)
        dateL.snp.makeConstraints { make in
            make.top.equalTo(titleL.snp.bottom).offset(6)
            make.left.equalTo(self.snp.left).offset(12)
            make.bottom.equalTo(self.snp.bottom).offset(-18)
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
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            self.backgroundColor = .hex("#ECECEC")
        } else {
            self.backgroundColor = .white
        }
    }
}
