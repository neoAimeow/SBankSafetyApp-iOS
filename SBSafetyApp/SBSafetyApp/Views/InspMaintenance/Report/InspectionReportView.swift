//
//  InspectionReportView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/24.
//

import Foundation
import UIKit
import AAInfographics

class InspectionReportView: UIScrollView {
    
    let staticBase1 = InspStatusStatisticsView()
    let staticBase2 = InspResultStatisticsView()
    let staticBase3 = InspErrorStatisticsView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        showsVerticalScrollIndicator = false
        backgroundColor = .hex("#3C72FF")
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {

    }
    
    // MARK: - Setup
    func setupUI() {
        addSubview(titleL)
        titleL.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(31)
            make.top.equalToSuperview().offset(6)
        }
        
        addSubview(dateBtn)
        dateBtn.snp.makeConstraints { make in
            make.left.equalTo(titleL.snp.left)
            make.top.equalTo(titleL.snp.bottom).offset(10)
            make.width.equalTo(110)
            make.height.equalTo(27)
        }
        
        addSubview(reportIV)
        reportIV.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(ScreenWidth - 170)
            make.top.equalToSuperview()
            make.height.equalTo(81)
            make.width.equalTo(144)
        }
        
        addSubview(staticBase1)
        staticBase1.snp.makeConstraints { make in
            make.top.equalTo(reportIV.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth - 20)
            make.height.equalTo(456)
        }
        
        addSubview(staticBase2)
        staticBase2.snp.makeConstraints { make in
            make.top.equalTo(staticBase1.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth - 20)
            make.height.equalTo(240)
        }
        
        addSubview(staticBase3)
        staticBase3.snp.makeConstraints { make in
            make.top.equalTo(staticBase2.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth - 20)
            make.height.equalTo(330)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    lazy var titleL: UILabel = {
        let l = UILabel()
        l.text = "网点巡检报告"
        l.font = .systemFont(ofSize: 20)
        l.textColor = .white
        return l
    }()
    
    lazy var reportIV: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "report"))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var dateBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("2022年07月", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize:12)
        btn.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        let space = 20.0
        btn.contentHorizontalAlignment = .center //默认
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -2.0/space, bottom: 0, right: 2.0/space)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0,  left: 2.0/space, bottom: 0, right: -2.0/space)
        btn.transform = CGAffineTransformMakeScale(-1,1) //自身旋转180度
        btn.imageView?.transform = CGAffineTransformMakeScale(-1, 1)
        btn.titleLabel?.transform = CGAffineTransformMakeScale(-1, 1)
        btn.backgroundColor = .hex("#3162E1")
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 2
        btn.tintColor = .white
        return btn
    }()
}

class InspStatusTitle: UIView {
    init(withIcon icon: String, name: String) {
        super.init(frame: .zero)
        
        setupUI()
        
        iconIV.image = UIImage(named: icon)
        titleL.text = name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    
    func setupUI() {
        addSubview(iconIV)
        iconIV.snp.makeConstraints { make in
            make.width.height.equalTo(21)
            make.left.centerY.equalToSuperview()
        }
        
        addSubview(titleL)
        titleL.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconIV.snp.right).offset(8)
        }
    }
    
    lazy var iconIV: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    lazy var titleL: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16)
        return l
    }()
}
