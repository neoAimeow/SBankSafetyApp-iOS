//
//  LoadMoreButton.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/21.
// https://yzf.qq.com/fsna/kf-file/kf_pic/20221121/KFPIC_kfh5221fa29cfc019f_h5cded9881fc7d6fdfece5fb364b_WXIMAGE_54a3445c79ac403b8be8a01b65d71aae.png

import Foundation
import UIKit

class LoadMoreButton: UIView {
    var textLabel: UILabel = {
        let label = UILabel()
        label.text = "查看更多"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .hex("#949494")
        return label
    }()
    
    var indicatorImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage.init(systemName: "chevron.right"))
        imageView.tintColor = .hex("#9B9B9B")
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        addSubview(textLabel)
        addSubview(indicatorImageView)
        
        textLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
        }
        
        indicatorImageView.snp.makeConstraints { make in
            make.width.equalTo(5.5)
            make.height.equalTo(10)
            make.left.equalTo(textLabel.snp.right).offset(5)
            make.right.equalTo(self)
            make.centerY.equalTo(self)
            make.bottom.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
