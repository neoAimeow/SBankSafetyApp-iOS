//
//  SuperviseHomeCell.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/22.
//

import Foundation
import UIKit

class SuperviseHomeModel: NSObject {
    var icon: String = ""
    var title: String = ""
    init(icon: String, title: String) {
        self.icon = icon
        self.title = title
    }
}

class SuperviseHomeCell: UICollectionViewCell {
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .hex("#333333")
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildData(model:SuperviseHomeModel) {
        titleLabel.text = model.title
        iconImageView.image = UIImage.init(named: model.icon)
    }
    
    func setupUI() {
        backgroundColor = .hex("#F8F8F8")
        self.layer.cornerRadius = 30
        self.layer.masksToBounds = true
        self.contentView.addSubview(iconImageView)
        self.contentView.addSubview(titleLabel)
        
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(13)
            make.height.width.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(iconImageView.snp.right).offset(2)
        }
    }
}

