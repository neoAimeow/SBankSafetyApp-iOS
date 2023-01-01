//
//  SectionTitleView.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/19.
//

import Foundation
import UIKit

enum SectionTitleStyleEnum: Int {
    case Default = 2000
    case Style1 = 2001
    case Style2 = 2002
}

class SectionTitleView: UIView {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIView.ContentMode.scaleToFill
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    init(withStyle style: SectionTitleStyleEnum, title: String) {
        super.init(frame: .zero)
        addSubview(imageView)
        addSubview(titleLabel)
        titleLabel.text = title
        switch(style) {
            case SectionTitleStyleEnum.Style1:
                titleLabel.textColor = .hex("#333333")
                titleLabel.font = UIFont.systemFont(ofSize: 17)
            
                imageView.image = UIImage.init(named: "ic_loc_blue")
                imageView.snp.makeConstraints { make in
                    make.height.equalTo(15)
                    make.width.equalTo(12)
                }
                break
            case SectionTitleStyleEnum.Style2:
                titleLabel.textColor = .hex("#333333")
                titleLabel.font = UIFont.systemFont(ofSize: 17)
            
                imageView.image = UIImage.init(named: "title_symbol")
                imageView.snp.makeConstraints { make in
                    make.height.equalTo(16)
                    make.width.equalTo(4)
                }
                break
            default:
                break
        }
        
        imageView.snp.makeConstraints { make in
            make.left.equalTo(self)
            make.centerY.equalTo(self)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(imageView.snp_rightMargin).offset(18)
            make.centerY.equalTo(imageView)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
