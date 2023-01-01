//
//  TaskStatusSelectView.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/18.
//
// https://pic5.58cdn.com.cn/nowater/webim/big/n_v212b9dca605d14ca49db1d7e151701e9e.png

import Foundation
import UIKit

class TaskStatusSelectView: UIView {
    
    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.textColor = .hex("#0F499E")
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    lazy var symbolImageView: UIImageView = {
        var imageView = UIImageView(image: UIImage.init(systemName: "chevron.down"))
        imageView.tintColor = UIColor.hex("#A5A5A5")
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 2
        self.backgroundColor = .hex("#F8F8F8")
        
        self.addSubview(titleLabel)
        self.addSubview(symbolImageView)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(13)
        }
        
        symbolImageView.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-12)
        }
    }
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
