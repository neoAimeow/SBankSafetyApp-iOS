//
//  EmptyView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/17.
//

import Foundation
import UIKit

class EmptyView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }   
    
    func setupUI() {
        let iv = UIImageView()
        iv.image = UIImage(named: "ic_empty")
        iv.contentMode = .scaleAspectFit
        addSubview(iv)
        iv.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.centerY.equalTo(self.snp.centerY).offset(-80)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        let titleL = UILabel()
        titleL.text = "暂无内容"
        titleL.textColor = .hex("#D5D9E2")
        titleL.font = UIFont.systemFont(ofSize: 17)
        titleL.textAlignment = .center
        titleL.numberOfLines = 0
        addSubview(titleL)
        titleL.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.top.equalTo(iv.snp.bottom).offset(29)
        }
    }
}
