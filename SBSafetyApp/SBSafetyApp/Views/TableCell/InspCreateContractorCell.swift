//
//  InspCreateContractorCell.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/30.
//

import Foundation
import UIKit

class InspCreateContractorCell: UITableViewCell {
    let nameL = UILabel()
    let arrowIV = UIImageView()
    let line = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .white
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        nameL.font = UIFont.systemFont(ofSize: 15)
        nameL.textColor = .hex("#333333")
        addSubview(nameL)
        nameL.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.snp.left).offset(13)
        }
        
        arrowIV.image = UIImage(systemName: "chevron.right")
        arrowIV.tintColor = .hex("#A5A5A5")
        arrowIV.contentMode = .scaleAspectFit
        addSubview(arrowIV)
        arrowIV.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-14)
            make.width.equalTo(8)
        }
        
        line.backgroundColor = .hex("#F3F3F3")
        addSubview(line)
        line.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(self.snp.left).offset(13)
            make.right.equalTo(self.snp.right).offset(-14)
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
}
