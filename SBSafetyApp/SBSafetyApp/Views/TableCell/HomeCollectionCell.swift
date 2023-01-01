//
//  HomeCollectionCell.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/21.
//

import Foundation
import UIKit

class HomeCollectionCell: UICollectionViewCell {
    let nameL = UILabel()
    let iconIV = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(iconIV)
        iconIV.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.snp.top)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        nameL.textColor = .unTint
        nameL.font = UIFont.systemFont(ofSize: 14)
        nameL.textAlignment = .center
        addSubview(nameL)
        nameL.snp.makeConstraints { make in
            make.top.equalTo(iconIV.snp.bottom).offset(9)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
        }
    }
}

