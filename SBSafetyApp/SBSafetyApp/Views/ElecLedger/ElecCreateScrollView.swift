//
//  ElecCreateScrollView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/13.
//

import Foundation
import UIKit

class ElecCreateScrollView: UIScrollView {
    var deptName: String = "" {
        didSet {
            desL.text = deptName
        }
    }

    let titleL = UILabel()
    let desL = UILabel()
    let subTitleL = UILabel()

    let submitBtn = UIButton.createPrimaryLarge("提交")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        keyboardDismissMode = .interactive
        showsVerticalScrollIndicator = false

        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        titleL.font = UIFont.systemFont(ofSize: 18)
        titleL.textColor = .hex("#306EC8")
        addSubview(titleL)
        titleL.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(20)
            make.left.equalTo(self.snp.left).offset(10)
        }
        
        desL.font = UIFont.systemFont(ofSize: 17)
        desL.textColor = .pmB3
        desL.textAlignment = .center
        addSubview(desL)
        desL.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleL.snp.bottom).offset(13)
            make.left.equalTo(self.snp.left).offset(10)
        }
        
        subTitleL.font = UIFont.systemFont(ofSize: 16)
        subTitleL.textAlignment = .center
        addSubview(subTitleL)
        subTitleL.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(desL.snp.bottom).offset(38)
            make.left.equalTo(self.snp.left).offset(10)
        }
    }
}
