//
//  BSSearchButton.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/24.
//

import Foundation
import UIKit

class BSSearchButton: UIView {
    let baseV = UIView()
    let titleL = UILabel()
    let ctl = UIControl()
    
    var padding = 10 {
        didSet {
            updateEntry()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateEntry() {
        baseV.snp.updateConstraints { make in
            make.left.equalTo(self.snp.left).offset(padding)
            make.right.equalTo(self.snp.right).offset(-padding)
        }
    }
    
    func setupUI() {
        baseV.layer.masksToBounds = true
        baseV.layer.cornerRadius = 20
        baseV.backgroundColor = .hex("#F3F3F3")
        addSubview(baseV)
        baseV.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(padding)
            make.right.equalTo(self.snp.right).offset(-padding)
            make.top.equalToSuperview()
            make.height.equalTo(40)
        }
        
        let iconIV = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        iconIV.contentMode = .scaleAspectFit
        iconIV.tintColor = .hex("#7D7D7D")
        baseV.addSubview(iconIV)
        iconIV.snp.makeConstraints { make in
            make.centerY.equalTo(baseV.snp.centerY)
            make.left.equalTo(baseV.snp.left).offset(17)
            make.width.equalTo(15)
        }
        
        titleL.text = "请选择要打印的日期"
        titleL.textColor = .hex("#929292")
        titleL.font = .systemFont(ofSize: 17)
        baseV.addSubview(titleL)
        titleL.snp.makeConstraints { make in
            make.centerY.equalTo(baseV.snp.centerY)
            make.left.equalTo(iconIV.snp.right).offset(8)
        }
        
        baseV.addSubview(ctl)
        ctl.snp.makeConstraints { make in
            make.left.bottom.right.top.equalToSuperview()
        }
    }
}
