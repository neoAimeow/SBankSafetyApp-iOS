//
//  BasePanel.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/24.
//

import Foundation
import UIKit

class BaseTextViewPanel: UIView {

    lazy var textView: BSTextView = {
        let textView = BSTextView()
        textView.backgroundColor = .hex("#FAFAFA")
        textView.placeholder = "请说明此次调整的原因"
        return textView
    }()
    
    
    init(withStyle style: SectionTitleStyleEnum, withTitle title: String) {
        super.init(frame: .zero)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        backgroundColor = .white
        let titleView = SectionTitleView(withStyle: style, title: title)
        
        addSubview(titleView)
        addSubview(textView)
        
    
        titleView.snp.makeConstraints { make in
            make.left.top.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(18)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(18)
            make.left.equalTo(self).offset(18)
            make.right.equalTo(self.snp.right).offset(-18)
            make.height.equalTo(116)
            make.bottom.equalTo(self).offset(-20)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
