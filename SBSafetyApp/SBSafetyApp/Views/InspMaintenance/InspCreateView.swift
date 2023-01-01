//
//  InspCreateView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/22.
//

import Foundation
import UIKit

class InspCreateView: UIView {
    let netV = InspItemView()
    let sponsorV = InspItemView()
    let liableV = InspItemView()
    let tempV = InspItemView()
    let contractorV = InspItemView()

    let submitBtn = UIButton.createPrimaryLarge("提交")

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(withModal modal: InspCreateModal) {
        netV.updateUI(withKey: "网点名称：", value: modal.dept?.deptName)
        sponsorV.updateUI(withKey: "巡检发起人：", value: modal.sponsor)
        liableV.updateUI(withKey: "网点责任人：", value: modal.personLiable)
        tempV.updateUI(withKey: "巡检模块：", value: modal.template?.name)
        contractorV.updateUI(withKey: "巡检工程商：", value: modal.contractor?.name)
    }
    
    func setupUI() {
        let baseV = UIView()
        baseV.backgroundColor = .white
        baseV.layer.cornerRadius = 10
        addSubview(baseV)
        baseV.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.width.equalTo(ScreenWidth - 20)
            make.height.equalTo(234)
        }
        
        netV.line.isHidden = true
        baseV.addSubview(netV)
        netV.snp.makeConstraints { make in
            make.top.equalTo(baseV.snp.top).offset(6)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        baseV.addSubview(sponsorV)
        sponsorV.snp.makeConstraints { make in
            make.top.equalTo(netV.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        baseV.addSubview(liableV)
        liableV.snp.makeConstraints { make in
            make.top.equalTo(sponsorV.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        baseV.addSubview(tempV)
        tempV.snp.makeConstraints { make in
            make.top.equalTo(liableV.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        baseV.addSubview(contractorV)
        contractorV.snp.makeConstraints { make in
            make.top.equalTo(tempV.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        addSubview(submitBtn)
        submitBtn.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(baseV.snp.bottom).offset(26)
            make.height.equalTo(50)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(ScreenWidth - 20)
        }
    }
}

class InspItemView: UIView {
    let line = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(withKey key: String, value: String?) {
        keyL.text = key
        valueL.text = value
    }
    
    func setupUI() {
        line.backgroundColor = .hex("#F3F3F3")
        addSubview(line)
        line.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left).offset(16)
            make.right.equalTo(self.snp.right).offset(-16)
            make.height.equalTo(0.5)
        }
        
        addSubview(keyL)
        keyL.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.snp.left).offset(16)
            make.width.equalTo(90)
        }
        
        addSubview(valueL)
        valueL.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(keyL.snp.right).offset(10)
            make.right.equalTo(self.snp.right).offset(-16)
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
        lab.textAlignment = .left
        return lab
    }()
}
