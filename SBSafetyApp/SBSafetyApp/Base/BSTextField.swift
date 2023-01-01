//
//  BSTextField.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/14.
//

import Foundation
import UIKit

class TextModal: NSObject {
    var icon: String = ""
    var placeholder: String = ""
    var btnTitle: String?
    var isArrow: Bool?
    var isImg: Bool?

    init(icon: String, placeholder: String, btnTitle: String? = nil, isArrow: Bool? = nil, isImg: Bool? = nil) {
        self.icon = icon
        self.placeholder = placeholder
        self.btnTitle = btnTitle
        self.isArrow = isArrow
        self.isImg = isImg
    }
}

let userM = TextModal(icon: "ic_user", placeholder: "请输入姓名")
let phoneM = TextModal(icon: "ic_phone", placeholder: "请输入手机号")
let pswM = TextModal(icon: "ic_psw", placeholder: "请输入密码")
let codeM = TextModal(icon: "ic_vcode", placeholder: "请输入验证码", btnTitle: "验证码")
let imgCodeM = TextModal(icon: "ic_vcode", placeholder: "请输入图形验证码", isImg: true)
let aPswM = TextModal(icon: "ic_psw", placeholder: "请再次输入登录密码")
let netM = TextModal(icon: "ic_net", placeholder: "请选择网点", isArrow: true)

protocol BSTextFieldDelegate: AnyObject {
    func handleFetchCode(_ btn: UIButton)
}

class BSTextField: UIView {
    var modal: TextModal!
    
    let titleTF = UITextField()
    let btn = UIButton(type: .custom)
    let imgBtn = UIButton(type: .custom)
    let ctl = UIControl()

    var timer: Timer!
    var count: NSInteger = 60

    weak var delegate: BSTextFieldDelegate?

    init(withModal _model: TextModal) {
        super.init(frame: .zero)
        self.modal = _model
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isEnable: Bool {
        return ((titleTF.text != nil) && titleTF.text!.count > 0 && !isHidden) || isHidden
    }
    
    @objc func vCodeTapped() {
        btn.isEnabled = false
        createTimer()
        btn.setTitle("\(count)s", for: .disabled)
        delegate?.handleFetchCode(btn)
    }
    
    // 实例化方法
    func createTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(countdown), userInfo: nil, repeats: true)
    }
    
    // 停止计数
    func stopTimer() {
        timer?.fireDate = Date.distantFuture
        if (timer != nil) {
            if timer.isValid {
                timer.invalidate()
                timer = nil
            }
        }
        count = 0
    }
        
    // 计数方法
    @objc func countdown() {
        if count <= 0 {
            count = 60
            btn.isEnabled = true
            stopTimer()
            return
        }
        count -= 1
        btn.setTitle("\(count)s", for: .disabled)

    }
        
    func setupUI() {
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.hex("#D9DDE9").cgColor
        
        let iconIV = UIImageView(image: UIImage(named: modal.icon))
        addSubview(iconIV)
        iconIV.snp.makeConstraints { (make) -> Void in
            make.centerY.equalToSuperview()
            make.left.equalTo(self.snp.left).offset(6)
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        
        titleTF.font = UIFont.systemFont(ofSize: 15)
        titleTF.textColor = .black
        titleTF.placeholder = modal.placeholder
        addSubview(titleTF)
        titleTF.snp.makeConstraints { (make) -> Void in
            make.height.centerY.equalToSuperview()
            make.left.equalTo(iconIV.snp.right).offset(9)
            make.right.equalTo(self.snp.right).offset(modal.btnTitle != nil ? -75 : -10)
        }
        
        if modal.btnTitle != nil {
            btn.layer.cornerRadius = 13.5
            btn.layer.masksToBounds = true
            btn.setTitle(modal.btnTitle, for: .normal)
            btn.setTitleColor(.white, for: .normal)
            btn.setBGColor(.primary, for: .normal)
            btn.setBGColor(.primaryH, for: .highlighted)
            btn.setBGColor(.primaryDis, for: .disabled)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.addTarget(self, action: #selector(vCodeTapped), for: .touchUpInside)
            addSubview(btn)
            btn.snp.makeConstraints { (make) -> Void in
                make.centerY.equalToSuperview()
                make.right.equalTo(self.snp.right).offset(-10)
                make.width.equalTo(64)
                make.height.equalTo(27)
            }
        }
        
        if modal.isImg == true {
            addSubview(imgBtn)
            imgBtn.snp.makeConstraints { (make) -> Void in
                make.centerY.equalToSuperview()
                make.right.equalTo(self.snp.right).offset(-10)
                make.width.equalTo(78)
                make.height.equalTo(24)
            }
        }
        
        if modal.isArrow == true {
            let arrowIV = UIImageView(image: UIImage(systemName: "chevron.down"))
            arrowIV.contentMode = .scaleAspectFit
            arrowIV.tintColor = .hex("#9AA2B3")
            addSubview(arrowIV)
            arrowIV.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalTo(self.snp.right).offset(-12)
                make.width.equalTo(10)
            }
            
            addSubview(ctl)
            ctl.snp.makeConstraints { make in
                make.left.right.bottom.top.equalToSuperview()
            }
        }
        
        titleTF.isEnabled = !(modal.isArrow == true)
    }
}
