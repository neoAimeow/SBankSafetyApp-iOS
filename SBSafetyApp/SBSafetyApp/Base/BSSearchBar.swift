//
//  BSSearchBar.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/30.
//

import Foundation
import UIKit

class BSSearchBar: UIView {
    let baseV = UIView()
    let searchTF = UITextField()
    let cancelBtn = UIButton.createCustom("取消")

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
            make.right.equalTo(cancelBtn.snp.left)
        }
    }
    
    func setupUI() {
        addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(40)
            make.top.equalToSuperview()
            make.right.equalTo(self.snp.right).offset(-padding)
            make.width.equalTo(80)
        }
        
        baseV.layer.masksToBounds = true
        baseV.layer.cornerRadius = 20
        baseV.backgroundColor = .hex("#F3F3F3")
        addSubview(baseV)
        baseV.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(padding)
            make.right.equalTo(cancelBtn.snp.left)
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
        
        searchTF.placeholder = "搜索网点"
        searchTF.textColor = .hex("#929292")
        searchTF.font = .systemFont(ofSize: 17)
        baseV.addSubview(searchTF)
        searchTF.snp.makeConstraints { make in
            make.centerY.equalTo(baseV.snp.centerY)
            make.left.equalTo(iconIV.snp.right).offset(8)
            make.right.equalTo(self.snp.right)
        }
    }
}
