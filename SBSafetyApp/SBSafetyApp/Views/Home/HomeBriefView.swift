//
//  HomeBriefView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/21.
//

import Foundation
import UIKit

class HomeBriefView: UIControl {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        let imgV = UIImageView(image: UIImage(named: "home_bg_brief"))
        addSubview(imgV)
        imgV.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        let titleL = UILabel()
        titleL.text = "每日简报"
        titleL.font = .systemFont(ofSize: 18)
        titleL.textColor = .hex("#FEFEFE")
        addSubview(titleL)
        titleL.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(17)
            make.left.equalTo(self.snp.left).offset(18)
        }
        
        let subTitleL = UILabel()
        subTitleL.text = "及时查看、不漏一日"
        subTitleL.font = .systemFont(ofSize: 14)
        subTitleL.textColor = .hex("#FEFEFE")
        addSubview(subTitleL)
        subTitleL.snp.makeConstraints { make in
            make.top.equalTo(titleL.snp.bottom).offset(10)
            make.left.equalTo(titleL.snp.left)
        }
        
        
        let actTitleL = UILabel()
        actTitleL.text = "去查看 ▶"
        actTitleL.font = .systemFont(ofSize: 14)
        actTitleL.textColor = .hex("#FEFEFE")
        addSubview(actTitleL)
        actTitleL.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom).offset(-24)
            make.right.equalTo(self.snp.right).offset(-15)
        }
    }
}
