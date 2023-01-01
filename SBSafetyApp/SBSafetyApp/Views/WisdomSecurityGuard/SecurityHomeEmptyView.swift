//
//  SecurityHomeEmptyView.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/16.
//
// https://pic9.58cdn.com.cn/nowater/webim/big/n_v254594f01a0dc4e949ed6149ab059343d.png

import Foundation
import UIKit

class SecurityHomeEmptyView: UIView {
    var imageView: UIImageView = {
        let imageView = UIImageView();
        return imageView
    }()
    
    var textLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    init(imageNamed: String, text: String) {
        super.init(frame: .zero)
        imageView.image = UIImage.init(named: imageNamed)
        textLabel.text = text
        
        addSubview(imageView)
        addSubview(textLabel)
        imageView.snp.makeConstraints { make in
            
        }
        
        textLabel.snp.makeConstraints { make in
            
        }
    }
    
    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
