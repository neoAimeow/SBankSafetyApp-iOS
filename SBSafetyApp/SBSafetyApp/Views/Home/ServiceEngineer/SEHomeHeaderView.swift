//
//  SEHomeHeaderView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/11.
//

import Foundation
import UIKit

class SEHomeHeaderView: UIView {
    let taskV = SEHomeItemView(withEnum: .task)
    let repairV = SEHomeItemView(withEnum: .repair)

    let todayV = SEHomeTodayView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI() {
        
    }
   
    func setupUI() {
        addSubview(baseIV)
        baseIV.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(283)
        }
        
        addSubview(titleL)
        titleL.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90)
            make.left.equalToSuperview().offset(20)
        }
        
        addSubview(detailL)
        detailL.snp.makeConstraints { make in
            make.left.equalTo(titleL.snp.left)
            make.top.equalTo(titleL.snp.bottom).offset(19)
        }
        
        let itemWidth = (ScreenWidth - 40) / 2.0
        addSubview(taskV)
        taskV.snp.makeConstraints { make in
            make.top.equalTo(detailL.snp.bottom).offset(44)
            make.left.equalToSuperview().offset(14)
            make.width.equalTo(itemWidth)
            make.height.equalTo(145)
        }
        
        addSubview(repairV)
        repairV.snp.makeConstraints { make in
            make.top.equalTo(taskV.snp.top)
            make.right.equalToSuperview().offset(-14)
            make.width.equalTo(itemWidth)
            make.height.equalTo(145)
        }
        
        addSubview(todayV)
        todayV.snp.makeConstraints { make in
            make.top.equalTo(taskV.snp.bottom).offset(10)
            make.width.equalTo(ScreenWidth - 28)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(100)
        }
        
        let desL = UILabel()
        desL.font = UIFont.systemFont(ofSize: 17)
        desL.text = "我的巡检单"
        desL.textAlignment = .center
        addSubview(desL)
        desL.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(todayV.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        let desBgIV = UIImageView(image: UIImage(named: "login_desc"))
        insertSubview(desBgIV, belowSubview: desL)
        desBgIV.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(desL.snp.centerY)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth - 30)
        }
    }
    
    lazy var baseIV: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "sehome_bg"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    lazy var titleL: UILabel = {
        let l = UILabel()
        l.text = "维保维修"
        l.font = .systemFont(ofSize: 24)
        l.textColor = .white
        return l
    }()
    
    lazy var detailL: UILabel = {
        let l = UILabel()
        l.text = "革除马虎之心，提高维修品质。"
        l.font = .systemFont(ofSize: 15)
        l.textColor = .white
        return l
    }()
}
