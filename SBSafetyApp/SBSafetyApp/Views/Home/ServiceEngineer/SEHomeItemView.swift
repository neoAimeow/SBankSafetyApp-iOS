//
//  SEHomeItemView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/11.
//

import Foundation
import UIKit

public enum SEHomeItemEnum: Int {
    case task   = 0
    case repair = 1
}

class SEHomeItemView: UIControl {
    let baseV = UIView()
    let imgV = UIImageView()
    let titleL = UILabel()
    let actImgV = UIImageView(image: UIImage(systemName: "arrow.right.circle.fill"))
    let countL = PaddingLabel()
    
    var count: Int = 0 {
        didSet {
            countL.text = "\(count)"
            countL.isHidden = count == 0
        }
    }
    
    init(withEnum style: SEHomeItemEnum = .task) {
        super.init(frame: .zero)
        setupUI()
        switch style {
        case .task:
            imgV.image = UIImage(named: "ic_sehome_task")
            titleL.text = "我的巡检"
            actImgV.tintColor = .hex("#FF9C00")
            break
        case .repair:
            imgV.image = UIImage(named: "ic_sehome_repair")
            titleL.text = "我的维修"
            actImgV.tintColor = .hex("#2CA9FA")
            break
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        let corV = CornerView()
        corV.backgroundColor = .hex("#427FD7")
        corV.corners = SBRectCorner(topLeft: 5, topRight: 5)
        addSubview(corV)
        corV.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(10)
            make.top.equalToSuperview()
        }
        
        baseV.isUserInteractionEnabled = false
        baseV.backgroundColor = .white
        baseV.layer.cornerRadius = 10
        baseV.layer.masksToBounds = true
        addSubview(baseV)
        baseV.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
        
        baseV.addSubview(imgV)
        imgV.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(24)
            make.width.height.equalTo(40)
        }
        
        countL.insets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        countL.textColor = .hex("#FF0000")
        countL.textAlignment = .center
        countL.font = .systemFont(ofSize: 15)
        countL.layer.masksToBounds = true
        countL.layer.cornerRadius = 9
        countL.layer.borderColor = UIColor.hex("#FF0000").cgColor
        countL.layer.borderWidth = 1
        countL.backgroundColor = .white
        baseV.addSubview(countL)
        countL.snp.makeConstraints { make in
            make.top.equalTo(imgV.snp.top).offset(-4)
            make.left.equalTo(imgV.snp.right).offset(-6)
            make.height.equalTo(18)
            make.width.greaterThanOrEqualTo(18)
        }
        
        titleL.font = .systemFont(ofSize: 17)
        baseV.addSubview(titleL)
        titleL.snp.makeConstraints { make in
            make.top.equalTo(imgV.snp.bottom).offset(26)
            make.left.equalTo(imgV.snp.left)
        }
        
        baseV.addSubview(actImgV)
        actImgV.snp.makeConstraints { make in
            make.centerY.equalTo(titleL.snp.centerY)
            make.right.equalToSuperview().offset(-16)
            make.width.height.equalTo(20)
        }
        
        self.count = 0
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                baseV.backgroundColor = .hex("#ECECEC")
            } else {
                baseV.backgroundColor = .white
            }
        }
    }
}
