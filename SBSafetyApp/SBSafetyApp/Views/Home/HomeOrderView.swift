//
//  HomeOrderView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/21.
//

import Foundation
import UIKit

class HomeOrderView: UIControl {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        let imgV = UIImageView(image: UIImage(named: "home_bg_order"))
        imgV.contentMode = .scaleAspectFill
        addSubview(imgV)
        imgV.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        let titleL = UILabel()
        titleL.text = "工单及反馈"
        titleL.font = .systemFont(ofSize: 17)
        titleL.textColor = .hex("#FEFEFE")
        addSubview(titleL)
        titleL.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(12)
            make.left.equalTo(self.snp.left).offset(16)
        }
        
        let subTitleL = PaddingLabel()
        subTitleL.insets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        subTitleL.text = "记录每条工单&反馈"
        subTitleL.font = .systemFont(ofSize: 12)
        subTitleL.backgroundColor = .hex("#99B8FC")
        subTitleL.textColor = .hex("#FEFEFE")
        subTitleL.layer.cornerRadius = 4
        subTitleL.layer.masksToBounds = true
        addSubview(subTitleL)
        subTitleL.snp.makeConstraints { make in
            make.top.equalTo(titleL.snp.bottom).offset(10)
            make.left.equalTo(titleL.snp.left)
        }
    }
}

class HomeNotiView: UIControl {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.masksToBounds = true
        layer.cornerRadius = 10
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        let imgV = UIImageView(image: UIImage(named: "ic_noti"))
        imgV.contentMode = .scaleAspectFill
        addSubview(imgV)
        imgV.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(9)
            make.left.equalTo(self.snp.left).offset(14)
            make.width.equalTo(44)
            make.height.equalTo(33)
        }
        
        let titleL = UILabel()
        titleL.text = "通知 ▶"
        titleL.font = .systemFont(ofSize: 14)
        titleL.textColor = .hex("#60B268")
        addSubview(titleL)
        titleL.snp.makeConstraints { make in
            make.top.equalTo(imgV.snp.bottom)
            make.left.equalTo(imgV.snp.left)
        }
    }
}

class HomeCollectView: UIControl {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.masksToBounds = true
        layer.cornerRadius = 10
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        let imgV = UIImageView(image: UIImage(named: "ic_collect"))
        imgV.contentMode = .scaleAspectFill
        addSubview(imgV)
        imgV.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(9)
            make.left.equalTo(self.snp.left).offset(14)
            make.width.equalTo(44)
            make.height.equalTo(33)
        }
        
        let titleL = UILabel()
        titleL.text = "我的收藏 ▶"
        titleL.font = .systemFont(ofSize: 14)
        titleL.textColor = .hex("#F4952A")
        addSubview(titleL)
        titleL.snp.makeConstraints { make in
            make.top.equalTo(imgV.snp.bottom)
            make.left.equalTo(imgV.snp.left)
        }
    }
}

