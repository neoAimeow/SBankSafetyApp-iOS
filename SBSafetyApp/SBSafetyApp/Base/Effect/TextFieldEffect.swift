//
//  TextFieldEffect.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/15.
//

import Foundation
import UIKit

class TextFieldEffect: BaseEffect {
    
    var value: String? {
        set {
            valueTF.text = newValue
            ctl.isHidden = value != nil
        }
        get {
            return valueTF.text
        }
    }
    
    let valueTF = UITextField()
    
    override func editTapped() {
        super.editTapped()
        valueTF.becomeFirstResponder()
    }
    
    override func setupUI() {
        super.setupUI()
        
        valueTF.textColor = .black
        valueTF.font = UIFont.systemFont(ofSize: 16)
        valueTF.delegate = self
        insertSubview(valueTF, aboveSubview: keyL)
        valueTF.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(33)
            make.top.equalTo(keyL.snp.bottom).offset(-2)
            make.left.equalTo(self.snp.left).offset(12)
            make.right.equalTo(self.snp.right).offset(-12)
        }
    }
}

extension TextFieldEffect: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        isEdited = !(textField.text == nil || textField.text == "")
    }
}
