//
//  PopoverView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/25.
//

import Foundation
import UIKit

class RepairPopoverView: UIView {
    let firstBtn = UIButton.init(type: .custom)
    let lastBtn = UIButton.init(type: .custom)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        firstBtn.titleLabel?.font = .systemFont(ofSize: 14)
        firstBtn.setTitle("一键报修", for: .normal)
        firstBtn.setTitleColor(.black, for: .normal)
        firstBtn.setImage(UIImage(named: "ic_repair"), for: .normal)
        firstBtn.setImage(UIImage(named: "ic_repair"), for: .highlighted)
        firstBtn.imageEdgeInsets = UIEdgeInsets(top: 1, left: 7, bottom: 1, right: 1)
        firstBtn.titleEdgeInsets = UIEdgeInsets(top: 10, left: 17, bottom: 10, right: 2)
        firstBtn.contentHorizontalAlignment = .left
        addSubview(firstBtn)
        firstBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(6)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(40)
        }
        
        let line = UIView()
        line.backgroundColor = .hex("#EAEAEA")
        addSubview(line)
        line.snp.makeConstraints { make in
            make.top.equalTo(firstBtn.snp.bottom)
            make.left.equalToSuperview().offset(7)
            make.right.equalToSuperview().offset(-7)
            make.height.equalTo(0.5)
        }
        
        lastBtn.titleLabel?.font = .systemFont(ofSize: 14)
        lastBtn.setTitle("电话报修", for: .normal)
        lastBtn.setTitleColor(.black, for: .normal)
        lastBtn.setImage(UIImage(named: "ic_repair_call"), for: .normal)
        lastBtn.setImage(UIImage(named: "ic_repair_call"), for: .highlighted)
        lastBtn.imageEdgeInsets = UIEdgeInsets(top: 1, left: 7, bottom: 1, right: 1)
        lastBtn.titleEdgeInsets = UIEdgeInsets(top: 10, left: 17, bottom: 10, right: 2)
        lastBtn.contentHorizontalAlignment = .left
        addSubview(lastBtn)
        lastBtn.snp.makeConstraints { (make) in
            make.top.equalTo(firstBtn.snp.bottom)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(40)
        }
    }
}
