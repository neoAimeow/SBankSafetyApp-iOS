//
//  LoginView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/14.
//

import Foundation
import UIKit

class LoginView: UIView {
    let phoneTF = BSTextField(withModal: phoneM)
    let pswTF = BSTextField(withModal: pswM)
    let imgCodeTF = BSTextField(withModal: imgCodeM)
    let rememberBtn = UIButton(type: .custom)
    let forgotBtn = UIButton(type: .custom)
    let loginBtn = UIButton.createPrimaryLarge("立即登录")

    var uuid: String? = ""

    var isimgCodeHidden: Bool = false {
        didSet {
            updateEntry()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(textFiledEditChanged), name: UITextField.textDidChangeNotification, object: phoneTF.titleTF)
        NotificationCenter.default.addObserver(self, selector: #selector(textFiledEditChanged), name: UITextField.textDidChangeNotification, object: pswTF.titleTF)
        NotificationCenter.default.addObserver(self, selector: #selector(textFiledEditChanged), name: UITextField.textDidChangeNotification, object: imgCodeTF.titleTF)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateEntry() {
        if imgCodeTF.superview == nil {
            return
        }
        
        if isimgCodeHidden == true {
            imgCodeTF.isHidden = true
            imgCodeTF.snp.updateConstraints { (make) -> Void in
                make.height.equalTo(0)
            }
        } else {
            imgCodeTF.isHidden = false
            imgCodeTF.snp.updateConstraints { (make) -> Void in
                make.height.equalTo(46)
            }
            imgCodeTapped()
        }
    }
    
    func reloadData() {
        let user = BSUser.currentUser
        if user.isRemember == true {
            phoneTF.titleTF.text = user.phone
            pswTF.titleTF.text = user.password
        }
        
        rememberBtn.tintColor = user.isRemember ? .primary : .pmGray
        rememberBtn.isSelected = user.isRemember
        
        textFiledEditChanged()
    }
    
    var loginM: LoginParam {
        let modal = LoginParam()
        modal.password = pswTF.titleTF.text
        modal.username = phoneTF.titleTF.text
        modal.code = imgCodeTF.titleTF.text
        if uuid != nil {
            modal.uuid = uuid
        }
       return modal
    }
    
    @objc func textFiledEditChanged() {
        let isEnabled = phoneTF.isEnable && pswTF.isEnable && imgCodeTF.isEnable
        loginBtn.isEnabled = isEnabled
    }
    
    @objc func rememberTapped() {
        let is_remember = !BSUser.currentUser.isRemember

        BSUser.currentUser.modifyUser(_isRemember: is_remember)
        if is_remember {
            rememberBtn.tintColor = .primary
        } else {
            rememberBtn.tintColor = .pmGray
        }
        rememberBtn.isSelected = is_remember
    }
    
    @objc func imgCodeTapped() {
        API.getCaptchaImage { responseModel in
            self.uuid = responseModel.model?.uuid
            let img = UIImage.base64ToImage(responseModel.model?.img)
            self.imgCodeTF.imgBtn.setImage(img, for: .normal)
        }
    }
        
    func setupUI() {
        let bottomIV = UIImageView(image: UIImage(named: "login_bottom"))
        bottomIV.contentMode = .scaleAspectFill
        addSubview(bottomIV)
        bottomIV.snp.makeConstraints { (make) -> Void in
            make.left.right.bottom.equalToSuperview()
        }
        
        let scrollV = UIScrollView()
        scrollV.showsVerticalScrollIndicator = false
        scrollV.alwaysBounceVertical = true
        scrollV.keyboardDismissMode = .onDrag
        scrollV.bounces = true
        addSubview(scrollV)
        scrollV.snp.makeConstraints { (make) -> Void in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(ScreenWidth)
        }
        
        let topIV = UIImageView(image: UIImage(named: "login_top"))
        scrollV.addSubview(topIV)
        topIV.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(scrollV.snp.centerX)
            make.top.equalTo(self.snp.top).offset(69)
            make.width.equalTo(245)
            make.height.equalTo(135)
        }
        
        let titleL = UILabel()
        titleL.font = UIFont.systemFont(ofSize: 22)
        titleL.textColor = .black
        titleL.text = "上银安防"
        titleL.textAlignment = .center
        scrollV.addSubview(titleL)
        titleL.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(topIV.snp.bottom).offset(33)
            make.centerX.equalTo(scrollV.snp.centerX)
        }
        
        let desL = UILabel()
        desL.font = UIFont.systemFont(ofSize: 15)
        desL.textColor = .pmGray
        desL.text = "让世界更安全"
        desL.textAlignment = .center
        scrollV.addSubview(desL)
        desL.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleL.snp.bottom).offset(12)
            make.centerX.equalTo(scrollV.snp.centerX)
        }
        
        let desBgIV = UIImageView(image: UIImage(named: "login_desc"))
        scrollV.insertSubview(desBgIV, belowSubview: desL)
        desBgIV.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(desL.snp.centerY)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth - 30)
        }

        scrollV.addSubview(phoneTF)
        phoneTF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(desL.snp.bottom).offset(45)
            make.left.equalTo(scrollV.snp.left).offset(40)
            make.right.equalTo(scrollV.snp.right).offset(-40)
            make.width.equalTo(ScreenWidth - 80)
            make.height.equalTo(46)
        }
        
        pswTF.titleTF.isSecureTextEntry = true
        scrollV.addSubview(pswTF)
        pswTF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(phoneTF.snp.bottom).offset(10)
            make.left.equalTo(phoneTF.snp.left)
            make.right.equalTo(phoneTF.snp.right)
            make.height.equalTo(46)
        }
        
        imgCodeTF.imgBtn.addTarget(self, action: #selector(imgCodeTapped), for: .touchUpInside)
        imgCodeTF.isHidden = true
        scrollV.addSubview(imgCodeTF)
        imgCodeTF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(pswTF.snp.bottom).offset(10)
            make.left.equalTo(phoneTF.snp.left)
            make.right.equalTo(phoneTF.snp.right)
            make.height.equalTo(0)
        }
        
        rememberBtn.setImage(UIImage(systemName: "square"), for: .normal)
        rememberBtn.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        rememberBtn.setTitleColor(.pmGray, for: .normal)
        rememberBtn.setTitleColor(.primary, for: .selected)
        rememberBtn.setTitle("记住密码", for: .normal)
        rememberBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        rememberBtn.tintColor = .pmGray
        rememberBtn.isSelected = false
        rememberBtn.addTarget(self, action: #selector(rememberTapped), for: .touchUpInside)
        scrollV.addSubview(rememberBtn)
        rememberBtn.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(imgCodeTF.snp.bottom).offset(10)
            make.left.equalTo(imgCodeTF.snp.left)
            make.width.equalTo(80)
            make.height.equalTo(32)
        }
        
        forgotBtn.setTitle("忘记密码?", for: .normal)
        forgotBtn.setTitleColor(.pmGray, for: .normal)
        forgotBtn.setTitleColor(.primary, for: .selected)
        forgotBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        scrollV.addSubview(forgotBtn)
        forgotBtn.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(imgCodeTF.snp.bottom).offset(10)
            make.right.equalTo(imgCodeTF.snp.right)
            make.width.equalTo(70)
            make.height.equalTo(32)
        }
        
        loginBtn.isEnabled = false
        scrollV.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(forgotBtn.snp.bottom).offset(26)
            make.left.equalTo(phoneTF.snp.left)
            make.right.equalTo(phoneTF.snp.right)
            make.height.equalTo(50)
        }
        
        let privacyL = UITextView()
        privacyL.delegate = self
        privacyL.isEditable = false
        privacyL.isScrollEnabled = false
        privacyL.backgroundColor = .clear
        privacyL.textAlignment = .center
        privacyL.font = UIFont.systemFont(ofSize: 14)
        addSubview(privacyL)
        privacyL.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom).offset(-52)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        let policy = "《上银安防平台个人信息保护声明》"
        let text = "登录即表示同意\(policy)"
        let pstyle = NSMutableParagraphStyle()
        pstyle.lineSpacing = 6
        let attri = NSMutableAttributedString(string: text, attributes: [.font:  UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.pmGray, .paragraphStyle: pstyle])
    
        let policyRange = NSMakeRange(text.distance(from: text.startIndex, to:text.range(of: policy)!.lowerBound), policy.count)
        attri.addAttribute(.foregroundColor, value: UIColor.primary, range: policyRange)
        attri.addAttribute(.link, value: "PrivacyPolicy://", range: policyRange)
        privacyL.attributedText = attri
    }
}

extension LoginView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString == "PrivacyPolicy://" {
            getFirstViewController()?.navigationController?.pushViewController(PtsmVC(), animated: true)
            return false
        }
        return true
    }
}
