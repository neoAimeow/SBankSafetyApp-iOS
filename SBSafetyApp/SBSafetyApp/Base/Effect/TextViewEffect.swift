//
//  TextViewEffect.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/15.
//

import Foundation
import UIKit

class TextViewEffect: BaseEffect {
    var value: String? {
        set {
            valueTV.text = newValue
            ctl.isHidden = value != nil
        }
        get {
            return valueTV.text
        }
    }
    
    let valueTV = UITextView()
    
    override func editTapped() {
        super.editTapped()
        valueTV.becomeFirstResponder()
    }
   
    override func setupUI() {
        super.setupUI()
        
        valueTV.textColor = .black
        valueTV.font = UIFont.systemFont(ofSize: 16)
        valueTV.delegate = self
        insertSubview(valueTV, aboveSubview: keyL)
        valueTV.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(keyL.snp.bottom).offset(-2)
            make.left.equalTo(self.snp.left).offset(8)
            make.right.equalTo(self.snp.right).offset(-8)
            make.bottom.equalTo(self.snp.bottom).offset(-6)
        }
        
        ctl.placeL.snp.remakeConstraints { make in
            make.top.equalTo(self.snp.top).offset(11)
            make.left.equalTo(self.snp.left).offset(10)
        }
    }
}

extension TextViewEffect: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        isEdited = !(textView.text == nil || textView.text == "")
    }
}
