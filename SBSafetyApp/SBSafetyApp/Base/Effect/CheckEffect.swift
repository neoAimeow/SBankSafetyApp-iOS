//
//  CheckEffect.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/15.
//

import Foundation
import UIKit

protocol CheckEffectDelegate: AnyObject {
    func valueChange(_ isCheck: Bool?)
}

class CheckEffect: UIControl {
    
    var title: String = "" {
        didSet {
            updateTitle()
        }
    }
    
    var isCheck: Bool? {
        didSet {
            updateStatus()
            delegate?.valueChange(isCheck)
        }
    }
    
    weak var delegate: CheckEffectDelegate?

    let titleL = UILabel()
    let noBtn = UIButton(type: .custom)
    let line = UIView()
    let yesBtn = UIButton(type: .custom)
    
    init(withEnable enable: Bool = true) {
        super.init(frame: .zero)
        backgroundColor = .white
        layer.borderColor = UIColor.hex("#E0E0E0").cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 4
        
        isEnabled = enable
        setupUI()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.borderColor = UIColor.hex("#E0E0E0").cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 4
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateStatus() {
        if isCheck == nil {
            line.layer.opacity = 1
            yesBtn.layer.opacity = 1
            noBtn.layer.opacity = 1
            noBtn.tintColor = .hex("#CFCFCF")
            yesBtn.tintColor = .hex("#CFCFCF")
            backgroundColor = .white
            layer.borderColor = UIColor.hex("#E0E0E0").cgColor
            
            yesBtn.snp.remakeConstraints { make in
                make.right.equalTo(line.snp.left)
                make.centerY.equalToSuperview()
                make.width.height.equalTo(45)
            }

        } else if isCheck == true {
            line.layer.opacity = 0
            noBtn.layer.opacity = 0
            yesBtn.layer.opacity = 1
            yesBtn.tintColor = .hex("#2AAD67")
            backgroundColor = .hex("#EAF7F0")
            layer.borderColor = UIColor.hex("#2AAD67").cgColor

            yesBtn.snp.remakeConstraints { make in
                make.right.equalTo(self.snp.right)
                make.centerY.equalToSuperview()
                make.width.height.equalTo(45)
            }
            
        } else if isCheck == false {
            line.layer.opacity = 0
            noBtn.layer.opacity = 1
            yesBtn.layer.opacity = 0
            noBtn.tintColor = .hex("#FF0000")
            backgroundColor = .hex("#FDEDEC")
            layer.borderColor = UIColor.hex("#E64340").cgColor
        }
    }
    
    func updateTitle() {
        titleL.text = title
    }
    
    @objc func noTapped() {
        if isCheck != false {
            isCheck = false
        } else {
            isCheck = nil
        }
    }
    
    @objc func yesTapped() {
        if isCheck != true {
            isCheck = true
        } else {
            isCheck = nil
        }
    }
    
    @objc func clearTapped() {
        if isCheck != nil {
            isCheck = nil
        }
    }
    
    func setupUI() {
        addTarget(self, action: #selector(clearTapped), for: .touchUpInside)

        titleL.font = UIFont.systemFont(ofSize: 15)
        titleL.textColor = .hex("#333333")
        addSubview(titleL)
        titleL.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(self.snp.left).offset(13)
        }
        
        noBtn.setImage(UIImage(systemName: "multiply"), for: .normal)
        noBtn.tintColor = .hex("#CFCFCF")
        noBtn.addTarget(self, action: #selector(noTapped), for: .touchUpInside)
        addSubview(noBtn)
        noBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(self.snp.right)
            make.width.height.equalTo(45)
        }
        
        line.backgroundColor = .hex("#E0E0E0")
        addSubview(line)
        line.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(noBtn.snp.left)
            make.width.equalTo(0.5)
            make.height.equalTo(26)
        }
        
        yesBtn.setImage(UIImage(systemName: "checkmark"), for: .normal)
        yesBtn.tintColor = .hex("#CFCFCF")
        yesBtn.addTarget(self, action: #selector(yesTapped), for: .touchUpInside)
        addSubview(yesBtn)
        yesBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(line.snp.left)
            make.width.height.equalTo(45)
        }
    }
}
