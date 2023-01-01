//
//  TitleItemView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/17.
//

import Foundation
import UIKit

class TitleItemView: UIView {

    var title = "" {
        didSet {
            titleL.text = title
        }
    }
    
    var subTitle = "" {
        didSet {
            subTitleL.text = subTitle
        }
    }
    
    var rightTitle = "" {
        didSet {
            rightTitleL.text = rightTitle
        }
    }
    
    init(withTitle title: String? = nil, subTitle: String? = nil, hasIcon: Bool? = true, rightTitle: String? = nil) {
        super.init(frame: .zero)
        setupUI(withTitle: title, subTitle: subTitle, hasIcon: hasIcon, rightTitle: rightTitle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI(withTitle title: String? = nil, subTitle: String? = nil, hasIcon: Bool? = true, rightTitle: String? = nil) {
        if hasIcon == true {
            addSubview(line)
            line.snp.makeConstraints { make in
                make.width.equalTo(4)
                make.height.equalTo(16)
                make.centerY.equalTo(self.snp.centerY)
                make.left.equalTo(self.snp.left).offset(11)
            }
        }
        
        titleL.text = title
        addSubview(titleL)
        titleL.snp.makeConstraints { make in
            make.left.equalTo(hasIcon == true ? line.snp.right : self.snp.left).offset(13)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        subTitleL.text = subTitle
        addSubview(subTitleL)
        subTitleL.snp.makeConstraints { make in
            make.left.equalTo(titleL.snp.right)
            make.centerY.equalTo(titleL.snp.centerY)
        }
        
        rightTitleL.text = rightTitle
        addSubview(rightTitleL)
        rightTitleL.snp.makeConstraints { make in
            make.right.equalTo(self.snp.right).offset(-22)
            make.centerY.equalTo(titleL.snp.centerY)
        }
    }
    
    lazy var line: UIView = {
        let v = UIView()
        v.backgroundColor = .black
        v.layer.cornerRadius = 2
        v.layer.masksToBounds = true
        return v
    }()
    
    lazy var titleL: UILabel = {
        let l = UILabel()
        l.textColor = .black
        l.font = UIFont.systemFont(ofSize: 16)
        l.textAlignment = .left
        return l
    }()
    
    lazy var subTitleL: UILabel = {
        let l = UILabel()
        l.textColor = .hex("#306EC8")
        l.font = UIFont.systemFont(ofSize: 17)
        l.textAlignment = .left
        return l
    }()
    
    lazy var rightTitleL: UILabel = {
        let l = UILabel()
        l.textColor = .primary
        l.font = UIFont.systemFont(ofSize: 14)
        l.textAlignment = .right
        return l
    }()
}
