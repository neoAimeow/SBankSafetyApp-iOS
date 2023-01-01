//
//  ForgotView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/14.
//

import Foundation
import UIKit

class ForgotView: UIView {

    let phoneTF = BSTextField(withModal: phoneM)
    let imgCodeTF = BSTextField(withModal: imgCodeM)
    let codeTF = BSTextField(withModal: codeM)
    let pswTF = BSTextField(withModal: pswM)
    let againPswTF = BSTextField(withModal: aPswM)
    let confrimBtn = UIButton.createPrimaryLarge("确认修改并登录")

    var uuid: String? = ""

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(textFiledEditChanged), name: UITextField.textDidChangeNotification, object: phoneTF.titleTF)
        NotificationCenter.default.addObserver(self, selector: #selector(textFiledEditChanged), name: UITextField.textDidChangeNotification, object: pswTF.titleTF)
        NotificationCenter.default.addObserver(self, selector: #selector(textFiledEditChanged), name: UITextField.textDidChangeNotification, object: codeTF.titleTF)
        NotificationCenter.default.addObserver(self, selector: #selector(textFiledEditChanged), name: UITextField.textDidChangeNotification, object: againPswTF.titleTF)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var loginM: LoginParam {
        let modal = LoginParam()
        modal.password = pswTF.titleTF.text
        modal.username = phoneTF.titleTF.text
        modal.code = codeTF.titleTF.text
        if uuid != nil {
            modal.uuid = uuid
        }
       return modal
    }
    
    @objc func textFiledEditChanged() {
        let isEnabled = phoneTF.isEnable && pswTF.isEnable && codeTF.isEnable && againPswTF.isEnable
        confrimBtn.isEnabled = isEnabled
    }
    
    @objc func imgCodeTapped() {
        API.getCaptchaImage { responseModel in
            self.uuid = responseModel.model?.uuid
            
            let img = UIImage.base64ToImage(responseModel.model?.img)
            self.imgCodeTF.imgBtn.setImage(img, for: .normal)
        }
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
        titleL.text = "忘记登录密码"
        scrollV.addSubview(titleL)
        titleL.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(scrollV.snp.top).offset(5)
            make.left.equalTo(scrollV.snp.left).offset(40)
        }
        
        let desL = UILabel()
        desL.font = UIFont.systemFont(ofSize: 17)
        desL.textColor = .pmGray
        desL.text = "输入手机号进行找回密码"
        desL.textAlignment = .center
        scrollV.addSubview(desL)
        desL.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleL.snp.bottom).offset(11)
            make.left.equalTo(scrollV.snp.left).offset(40)
        }
    
        scrollV.addSubview(phoneTF)
        phoneTF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(desL.snp.bottom).offset(52)
            make.left.equalTo(scrollV.snp.left).offset(40)
            make.right.equalTo(scrollV.snp.right).offset(-40)
            make.width.equalTo(ScreenWidth - 80)
            make.height.equalTo(46)
        }
        
        imgCodeTF.imgBtn.addTarget(self, action: #selector(imgCodeTapped), for: .touchUpInside)
        scrollV.addSubview(imgCodeTF)
        imgCodeTF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(phoneTF.snp.bottom).offset(15)
            make.left.equalTo(phoneTF.snp.left)
            make.right.equalTo(phoneTF.snp.right)
            make.height.equalTo(46)
        }

        codeTF.delegate = self
        scrollV.addSubview(codeTF)
        codeTF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(imgCodeTF.snp.bottom).offset(15)
            make.left.equalTo(phoneTF.snp.left)
            make.right.equalTo(phoneTF.snp.right)
            make.height.equalTo(46)
        }
        
        pswTF.titleTF.isSecureTextEntry = true
        scrollV.addSubview(pswTF)
        pswTF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(codeTF.snp.bottom).offset(15)
            make.left.equalTo(phoneTF.snp.left)
            make.right.equalTo(phoneTF.snp.right)
            make.height.equalTo(46)
        }
        
        againPswTF.titleTF.isSecureTextEntry = true
        scrollV.addSubview(againPswTF)
        againPswTF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(pswTF.snp.bottom).offset(15)
            make.left.equalTo(phoneTF.snp.left)
            make.right.equalTo(phoneTF.snp.right)
            make.height.equalTo(46)
        }
        
        confrimBtn.isEnabled = false
        scrollV.addSubview(confrimBtn)
        confrimBtn.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(againPswTF.snp.bottom).offset(57)
            make.left.equalTo(phoneTF.snp.left)
            make.right.equalTo(phoneTF.snp.right)
            make.height.equalTo(50)
        }
        
        imgCodeTapped()
    }
}

extension ForgotView: BSTextFieldDelegate {
    func handleFetchCode(_ btn: UIButton) {
        let modal = RetrievepwdSendParam()
        modal.username = phoneTF.titleTF.text
        modal.code = imgCodeTF.titleTF.text
        if uuid != nil {
            modal.uuid = uuid
        }
        
        if modal.username != nil || modal.username == "" {
            showToast(witMsg: "请输入手机号")
            return
        }
        
        if modal.code != nil || modal.code == "" {
            showToast(witMsg: "请输入图形验证码")
            return
        }
        
        API.postRetrievepwdSend(withParam: modal) { responseModel in
            print("postRetrievepwdSend", responseModel)
        }
    }
}
