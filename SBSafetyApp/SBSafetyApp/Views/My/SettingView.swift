//
//  SettingView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/24.
//

import Foundation
import UIKit

class SettingView: UIView {
    let modifyPswItem = MyItemView(withModal: MyItemModal(name: "修改密码", status: .middle, lineType: .inset))
    let unlockItem = MyItemView(withModal: MyItemModal(name: "手势解锁", status: .middle, lineType: .line_none))
    
    let exitBtn = UIButton.createPrimaryLarge("退出当前账号")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(modifyPswItem)
        modifyPswItem.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(10)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(55)
        }
        
        addSubview(unlockItem)
        unlockItem.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(modifyPswItem.snp.bottom)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(55)
        }
        
        addSubview(exitBtn)
        exitBtn.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.snp.bottom).offset(-20)
            make.height.equalTo(50)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(ScreenWidth - 20)
        }
    }
}
