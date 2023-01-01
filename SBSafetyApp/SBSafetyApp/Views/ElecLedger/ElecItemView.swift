//
//  ElecItemView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/17.
//

import Foundation
import UIKit
import Kingfisher

class ElecItemView: UIView {
    
    var key: String? {
        didSet {
            keyL.text = key
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(withValue value: String? = nil, imgURL: String? = nil) {
        if (value != nil && valueL.superview == nil) {
            addSubview(valueL)
            valueL.snp.makeConstraints { make in
                make.centerY.equalTo(self.snp.centerY)
                make.left.equalTo(keyL.snp.right).offset(10)
                make.right.equalTo(self.snp.right).offset(-13)
            }
        }
        
        if (imgURL != nil && imgIV.superview == nil) {
            addSubview(imgIV)
            imgIV.snp.makeConstraints { make in
                make.centerY.equalTo(self.snp.centerY)
                make.right.equalTo(self.snp.right).offset(10)
                make.width.equalTo(70)
            }
            
            let url = "https://www.zhxqgl.top/bosc-ydaf" + imgURL!
            imgIV.kf.setImage(with: URL(string: url))
        }
        
        valueL.text = value
    }
    
    func setupUI() {
        let line = UIView()
        line.backgroundColor = .hex("#F3F3F3")
        addSubview(line)
        line.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left).offset(11)
            make.right.equalTo(self.snp.right).offset(-13)
            make.height.equalTo(0.5)
        }
        
        addSubview(keyL)
        keyL.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.snp.left).offset(13)
            make.width.equalTo(150)
        }
    }
    
    lazy var keyL: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.textColor = .hex("#666666")
        return lab
    }()
    
    lazy var valueL: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.textColor = .hex("#444444")
        lab.textAlignment = .right
        return lab
    }()
    
    lazy var imgIV: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
}
