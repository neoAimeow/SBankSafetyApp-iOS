//
//  BSArrowControl.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/28.
//

import Foundation
import UIKit

class BSArrowControl: UIControl {
    let nameL = UILabel()
    let iconL = UIImageView(image: UIImage(systemName: "chevron.down"))
    
    var title: String? {
        didSet {
            nameL.text = title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    func setupUI() {
        backgroundColor = .white
        
        let baseV = UIView()
        addSubview(baseV)
        baseV.snp.makeConstraints { make in
            make.height.centerX.centerY.equalToSuperview()
        }
        
        nameL.font = .systemFont(ofSize: 15)
        baseV.addSubview(nameL)
        nameL.snp.makeConstraints { make in
            make.centerY.left.equalToSuperview()
        }

        iconL.contentMode = .scaleAspectFit
        iconL.tintColor = .hex("#868484")
        baseV.addSubview(iconL)
        iconL.snp.makeConstraints { make in
            make.centerY.right.equalToSuperview()
            make.left.equalTo(nameL.snp.right).offset(12)
            make.right.equalTo(baseV.snp.right)
            make.width.equalTo(12)
        }
    }
}
