//
//  FinishInfoView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/24.
//

import Foundation
import UIKit

class FinishInfoView: UIView {

    let userTF = BSTextField(withModal: userM)
    let netTF = BSTextField(withModal: netM)
    let pswTF = BSTextField(withModal: pswM)
    let againPswTF = BSTextField(withModal: aPswM)
    let confrimBtn = UIButton.createPrimaryLarge("确认并登录")

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(textFiledEditChanged), name: UITextField.textDidChangeNotification, object: userTF.titleTF)
        NotificationCenter.default.addObserver(self, selector: #selector(textFiledEditChanged), name: UITextField.textDidChangeNotification, object: pswTF.titleTF)
        NotificationCenter.default.addObserver(self, selector: #selector(textFiledEditChanged), name: UITextField.textDidChangeNotification, object: netTF.titleTF)
        NotificationCenter.default.addObserver(self, selector: #selector(textFiledEditChanged), name: UITextField.textDidChangeNotification, object: againPswTF.titleTF)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func textFiledEditChanged() {
        let isEnabled = userTF.isEnable && pswTF.isEnable && netTF.isEnable && againPswTF.isEnable
        confrimBtn.isEnabled = isEnabled
    }
      
    func setupUI() {
        let scrollV = UIScrollView()
        scrollV.showsVerticalScrollIndicator = false
        scrollV.alwaysBounceVertical = true
        addSubview(scrollV)
        scrollV.snp.makeConstraints { (make) -> Void in
            make.top.left.bottom.equalToSuperview()
            make.right.equalTo(self.snp.right)
            make.width.equalTo(ScreenWidth)
        }
        
        let titleL = UILabel()
        titleL.font = UIFont.systemFont(ofSize: 22)
        titleL.textColor = .black
        titleL.text = "完善信息"
        scrollV.addSubview(titleL)
        titleL.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(scrollV.snp.top).offset(5)
            make.left.equalTo(scrollV.snp.left).offset(40)
        }
        
        let desL = UILabel()
        desL.font = UIFont.systemFont(ofSize: 17)
        desL.textColor = .pmGray
        desL.text = "首次登录请完善个人信息"
        desL.textAlignment = .center
        scrollV.addSubview(desL)
        desL.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleL.snp.bottom).offset(11)
            make.left.equalTo(scrollV.snp.left).offset(40)
        }
    
        scrollV.addSubview(userTF)
        userTF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(desL.snp.bottom).offset(52)
            make.left.equalTo(scrollV.snp.left).offset(40)
            make.right.equalTo(scrollV.snp.right).offset(-40)
            make.width.equalTo(ScreenWidth - 80)
            make.height.equalTo(46)
        }
        
        scrollV.addSubview(netTF)
        netTF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(userTF.snp.bottom).offset(15)
            make.left.equalTo(userTF.snp.left)
            make.right.equalTo(userTF.snp.right)
            make.height.equalTo(46)
        }
        
        pswTF.titleTF.isSecureTextEntry = true
        scrollV.addSubview(pswTF)
        pswTF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(netTF.snp.bottom).offset(15)
            make.left.equalTo(userTF.snp.left)
            make.right.equalTo(userTF.snp.right)
            make.height.equalTo(46)
        }
        
        againPswTF.titleTF.isSecureTextEntry = true
        scrollV.addSubview(againPswTF)
        againPswTF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(pswTF.snp.bottom).offset(15)
            make.left.equalTo(userTF.snp.left)
            make.right.equalTo(userTF.snp.right)
            make.height.equalTo(46)
        }
        
        confrimBtn.isEnabled = false
        scrollV.addSubview(confrimBtn)
        confrimBtn.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(againPswTF.snp.bottom).offset(57)
            make.left.equalTo(userTF.snp.left)
            make.right.equalTo(userTF.snp.right)
            make.height.equalTo(50)
        }
    }
}
