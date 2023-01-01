//
//  BSLabelValueView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/27.
//

import Foundation
import UIKit

class BSLabelValueView: UIView {
    let keyL = UILabel()
    let valueL = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.borderColor = UIColor.hex("#E0E0E0").cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 4
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(withKey key: String, value: String?) {
        keyL.text = key
        valueL.text = value
    }

    func setupUI() {
        keyL.textColor = .hex("#999999")
        keyL.font = UIFont.systemFont(ofSize: 15)
        addSubview(keyL)
        keyL.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(6)
            make.left.equalTo(self.snp.left).offset(11)
        }
        
        valueL.font = UIFont.systemFont(ofSize: 16)
        valueL.numberOfLines = 0
        addSubview(valueL)
        valueL.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(keyL.snp.bottom).offset(2)
            make.left.equalTo(self.snp.left).offset(12)
            make.right.equalTo(self.snp.right).offset(-12)
            make.bottom.equalToSuperview().offset(-6)
        }
    }
}
