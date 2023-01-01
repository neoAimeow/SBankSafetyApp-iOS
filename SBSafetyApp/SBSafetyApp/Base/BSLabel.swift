//
//  BSLabel.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/17.
//

import Foundation
import UIKit

class LabelModal: NSObject {
    var icon: String = ""
    var btnTitle: String?
    var placeholder: String?

    init(icon: String, btnTitle: String? = nil, placeholder: String? = nil) {
        self.icon = icon
        self.btnTitle = btnTitle
        self.placeholder = placeholder
    }
}

let nameLM = LabelModal(icon: "ic_user")
let phoneLM = LabelModal(icon: "ic_phone")
let locLM = LabelModal(icon: "ic_loc", btnTitle: "点击获取", placeholder: "点击获取地理位置")

class BSLabel: UIView {
    var modal: LabelModal!
    
    let titleL = UILabel()
    let btn = UIButton(type: .custom)
    let line = UIView()
    
    var value: String? {
        didSet {
            titleL.text = value ?? modal.placeholder
            titleL.textColor = (value != nil) ? .black : .hex("#D4D4D4")
        }
    }

    init(withModal _model: LabelModal) {
        super.init(frame: .zero)
        self.modal = _model
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        titleL.font = UIFont.systemFont(ofSize: 15)
        titleL.text = value ?? modal.placeholder
        titleL.textColor = (value != nil) ? .black : .hex("#D4D4D4")
        addSubview(titleL)
        titleL.snp.makeConstraints { (make) -> Void in
            make.height.centerY.equalToSuperview()
            make.left.equalTo(iconIV.snp.right).offset(9)
            make.right.equalTo(self.snp.right).offset(modal.btnTitle != nil ? -75 : -10)
        }
        
        if modal.btnTitle != nil {
            btn.setTitle(modal.btnTitle, for: .normal)
            btn.setTitleColor(.primary, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
//            btn.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
            addSubview(btn)
            btn.snp.makeConstraints { (make) -> Void in
                make.centerY.equalToSuperview()
                make.right.equalTo(self.snp.right)
                make.width.equalTo(92)
                make.height.equalTo(27)
            }
            
            line.backgroundColor = .hex("#E0E0E0")
            addSubview(line)
            line.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalTo(btn.snp.left)
                make.width.equalTo(0.5)
                make.height.equalTo(26)
            }
                
        }
    }
}
