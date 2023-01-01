//
//  SuperviseHomeTitleView.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/22.
//

import Foundation
import UIKit

class SuperviseHomeTitleView: UIView {
    lazy var lImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage.init(named: "Supervise_t_left"))
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        return imageView
    }()
    
    lazy var rImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage.init(named: "Supervise_t_right"))
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .hex("#000000")
        label.text = "检查监督"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(lImageView)
        addSubview(titleLabel)
        addSubview(rImageView)
        
        lImageView.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.equalTo(self)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(lImageView.snp.right).offset(5)
            make.centerY.equalTo(self)
        }
        
        rImageView.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.right).offset(5)
            make.centerY.equalTo(self)
            make.right.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
