//
//  BaseImagePickerPanel.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/28.
//

import Foundation
import UIKit
class BaseImagePickerPanel: UIView {
    
    lazy var imagePickerView: BSImagePickerView = {
        let view = BSImagePickerView()
        view.maxCount = 9
        view.rowCount = 3
        
        return view
    }()
    
    init(withStyle style: SectionTitleStyleEnum, withTitle title: String) {
        super.init(frame: .zero)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        backgroundColor = .white
//        let titleView = SectionTitleView(withStyle: style, title: title)
//
//        addSubview(titleView)
        addSubview(imagePickerView)
//
//        titleView.snp.makeConstraints { make in
//            make.left.top.equalTo(self).offset(20)
//            make.right.equalTo(self).offset(-10)
//            make.height.equalTo(18)
//        }
//
        imagePickerView.snp.makeConstraints { make in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(self   ).offset(20)
            make.bottom.equalTo(self).offset(-20)
        }
          
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

