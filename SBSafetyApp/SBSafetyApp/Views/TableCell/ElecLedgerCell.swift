//
//  ElecLedgerCell.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/15.
//

import Foundation
import UIKit

class ElecLedgerCell: UITableViewCell {
    let baseV = CornerView()
    let nameL = UILabel()
    let arrowIV = UIImageView()
    let line = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .bg
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        baseV.backgroundColor = .white
//        baseV.layer.cornerRadius = 10
//        baseV.layer.masksToBounds = true
        contentView.addSubview(baseV)
        baseV.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
        }
        
        nameL.font = UIFont.systemFont(ofSize: 15)
        nameL.textColor = .hex("#333333")
        baseV.addSubview(nameL)
        nameL.snp.makeConstraints { make in
            make.centerY.equalTo(baseV.snp.centerY)
            make.left.equalTo(baseV.snp.left).offset(10)
        }
        
        arrowIV.image = UIImage(systemName: "chevron.right")
        arrowIV.tintColor = .hex("#A5A5A5")
        arrowIV.contentMode = .scaleAspectFit
        baseV.addSubview(arrowIV)
        arrowIV.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(baseV.snp.centerY)
            make.right.equalTo(baseV.snp.right).offset(-10)
            make.width.equalTo(8)
        }
        
        line.backgroundColor = .hex("#F3F3F3")
        baseV.addSubview(line)
        line.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(baseV.snp.bottom)
            make.left.equalTo(baseV.snp.left).offset(10)
            make.right.equalTo(baseV.snp.right).offset(-10)
            make.height.equalTo(0.5)
        }
    }
    
    func updateUI(withModal modal: StandingBookTypeModal?, isFirst: Bool, isLast: Bool) {
        nameL.text = modal?.typeLabel
        
        line.isHidden = false
        if isFirst {
            baseV.corners = SBRectCorner(topLeft: 10, topRight: 10)
        } else if isLast {
            line.isHidden = true
            baseV.corners = SBRectCorner(bottomLeft: 10, bottomRight: 10)
        } else {
            baseV.corners = SBRectCorner(all: 0)
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
