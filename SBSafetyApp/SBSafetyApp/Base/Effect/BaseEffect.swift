//
//  BaseEffect.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/15.
//

import Foundation
import UIKit

class BaseEffect: UIView {
    
    var isRequired: Bool = false {
        didSet {
            updatePlaceholder()
        }
    }
    
    var isEdited: Bool = false {
        didSet {
            updateTextEntry()
        }
    }
    
    var isDarkBg: Bool = false {
        didSet {
            updateTextStatus()
        }
    }
    
    var placeholder: String = "..." {
        didSet {
            updatePlaceholder()
        }
    }
        
    let keyL = UILabel()
    let ctl = ControlEffect()
    
    init(withEnable enable: Bool = true) {
        super.init(frame: .zero)
        backgroundColor = .white
        layer.borderColor = UIColor.hex("#E0E0E0").cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 4
        
        isUserInteractionEnabled = enable
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updatePlaceholder() {
        ctl.isRequired = isRequired
        if isRequired {
            let value1 = "＊"
            let text = "\(value1) \(placeholder)"
            let attri = NSMutableAttributedString(string: text, attributes: [.font:  UIFont.systemFont(ofSize: 15), .foregroundColor: UIColor.hex("#999999")])

            let v1Range = NSMakeRange(text.distance(from: text.startIndex, to:text.range(of: value1)!.lowerBound), value1.count)
            attri.addAttribute(.foregroundColor, value: UIColor.hex("#FF0000"), range: v1Range)
//            attri.addAttribute(.font, value: UIFont.systemFont(ofSize: 17), range: v1Range)
            keyL.attributedText = attri
        } else {
            keyL.text = placeholder
            ctl.placeholder = "请输入\(placeholder)"
        }
    }
    
    func updateTextEntry() {
        keyL.isHidden = (placeholder == "...")
        if isEdited {
            UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: .beginFromCurrentState, animations: ({
                self.ctl.layer.opacity = 0.0
            }), completion: { _ in

            })
        } else {
            UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: .beginFromCurrentState, animations: ({
                self.ctl.layer.opacity = 1.0
            }), completion: { _ in

            })
        }
    }
    
    func updateTextStatus() {
        if isDarkBg {
            backgroundColor = .hex("#F5F5F5")
            ctl.backgroundColor = .hex("#F5F5F5")
            updateTextEntry()
        } else {
            backgroundColor = .white
            ctl.backgroundColor = .white
            updateTextEntry()
        }
    }
    
    @objc func editTapped() {
        self.isEdited = true
    }
    
    func setupUI() {
        keyL.textColor = .hex("#999999")
        keyL.font = UIFont.systemFont(ofSize: 15)
        addSubview(keyL)
        keyL.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(6)
            make.left.equalTo(self.snp.left).offset(11)
        }
        
        ctl.addTarget(self, action: #selector(editTapped), for: .touchUpInside)
        addSubview(ctl)
        ctl.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}

class ControlEffect: UIControl {
    var isRequired: Bool = false {
        didSet {
            updatePlaceholder()
        }
    }
    
    var placeholder: String? {
        didSet {
            updatePlaceholder()
        }
    }
    
    let placeL = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updatePlaceholder() {
        if isRequired {
            let value1 = "＊"
            let text = "\(value1) \(placeholder ?? "...")"
            let attri = NSMutableAttributedString(string: text, attributes: [.font:  UIFont.systemFont(ofSize: 15), .foregroundColor: UIColor.hex("#D4D4D4")])

            let v1Range = NSMakeRange(text.distance(from: text.startIndex, to:text.range(of: value1)!.lowerBound), value1.count)
            attri.addAttribute(.foregroundColor, value: UIColor.hex("#FF0000"), range: v1Range)
//            attri.addAttribute(.font, value: UIFont.systemFont(ofSize: 17), range: v1Range)
            placeL.attributedText = attri
        } else {
            placeL.text = placeholder
        }
    }
    
    func setupUI() {
        placeL.text = "请输入..."
        placeL.textColor = .hex("#D4D4D4")
        placeL.font = UIFont.systemFont(ofSize: 15)
        addSubview(placeL)
        placeL.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(self.snp.left).offset(11)
        }
    }
}
