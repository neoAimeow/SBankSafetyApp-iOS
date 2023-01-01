//
//  TextViewEditEffect.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/29.
//

import Foundation
import UIKit

class TextViewEditEffect: UIView {
    var value: String? {
        set {
            valueTV.text = newValue
        }
        get {
            return valueTV.text
        }
    }
    
    var isRequired: Bool = false {
        didSet {
            updatePlaceholder()
        }
    }
    
    var placeholder: String = "..." {
        didSet {
            updatePlaceholder()
        }
    }
        
    let keyL = UILabel()
    let valueTV = BSTextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    init(withPlaceholder _place: String) {
        super.init(frame: .zero)
        self.placeholder = _place
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updatePlaceholder() {
        keyL.text = placeholder
    }
    
    func setupUI() {
        backgroundColor = .white
        layer.borderColor = UIColor.hex("#E1E1E1").cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 10
        
        keyL.text = placeholder
        keyL.textColor = .hex("#666666")
        keyL.font = UIFont.systemFont(ofSize: 14)
        addSubview(keyL)
        keyL.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(12)
            make.left.equalTo(self.snp.left).offset(11)
        }
        
        valueTV.placeholder = "请输入..."
        valueTV.font = UIFont.systemFont(ofSize: 15)
        valueTV.textContainerInset = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
        valueTV.backgroundColor = .clear
        addSubview(valueTV)
        valueTV.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(keyL.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.snp.bottom).offset(-12)
        }
    }
}
