//
//  TextFieldEditEffect.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/29.
//

import Foundation
import UIKit

class TextFieldEditEffect: UIView {
    var value: String? {
        set {
            valueTF.text = newValue
        }
        get {
            return valueTF.text
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
    let valueTF = UITextField()
    
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
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.snp.left).offset(11)
        }
        
        valueTF.placeholder = "请输入..."
        valueTF.font = UIFont.systemFont(ofSize: 15)
        valueTF.textAlignment = .right
        addSubview(valueTF)
        valueTF.snp.makeConstraints { (make) -> Void in
            make.height.centerY.equalToSuperview()
            make.left.equalTo(keyL.snp.right).offset(20)
            make.right.equalTo(self.snp.right).offset(-14)
        }
    }
}
