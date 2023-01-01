//
//  DetailCheckVideoView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/17.
//

import Foundation
import UIKit

class DetailCheckVideoView: UIScrollView {
    let modelV = ElecItemView()
    let playbackDateV = ElecItemView()
    let repairTimeV = ElecItemView()
    let nameV = ElecItemView()
    let maintenanceTimeV = ElecItemView()
    let compV = ElecItemView()
    let responsibleV = ElecItemView()
    let operatorV = ElecItemView()

    let problemsL = PaddingLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        showsVerticalScrollIndicator = false
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData(_ modal: StandingBookModal) {
        modelV.updateUI(withValue: modal.attrValue0)
        playbackDateV.updateUI(withValue: Date.momentDate(modal.attrValue1 ?? ""))
        repairTimeV.updateUI(withValue: Date.momentDate(modal.attrValue3 ?? ""))
        nameV.updateUI(withValue: modal.attrValue4)
        maintenanceTimeV.updateUI(withValue: Date.momentDate(modal.attrValue5 ?? ""))
        compV.updateUI(withValue: modal.attrValue6)
        responsibleV.updateUI(withValue: modal.attrValue7)
        operatorV.updateUI(withValue: modal.attrValue8)
        problemsL.text = modal.attrValue2
    }

    func setupUI() {
        let userV = UIView()
        userV.backgroundColor = .white
        userV.layer.cornerRadius = 10
        addSubview(userV)
        userV.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        let userTV = TitleItemView(withTitle: "情况记录")
        userV.addSubview(userTV)
        userTV.snp.makeConstraints { make in
            make.top.equalTo(userV.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(46)
        }
        
        modelV.key = "机型"
        userV.addSubview(modelV)
        modelV.snp.makeConstraints { make in
            make.top.equalTo(userTV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        playbackDateV.key = "回放日期"
        userV.addSubview(playbackDateV)
        playbackDateV.snp.makeConstraints { make in
            make.top.equalTo(modelV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(modelV.snp.height)
        }
        
        repairTimeV.key = "报修时间"
        userV.addSubview(repairTimeV)
        repairTimeV.snp.makeConstraints { make in
            make.top.equalTo(playbackDateV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(modelV.snp.height)
        }
        
        nameV.key = "报修人"
        userV.addSubview(nameV)
        nameV.snp.makeConstraints { make in
            make.top.equalTo(repairTimeV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(modelV.snp.height)
        }
        
        maintenanceTimeV.key = "维修保养时间"
        userV.addSubview(maintenanceTimeV)
        maintenanceTimeV.snp.makeConstraints { make in
            make.top.equalTo(nameV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(modelV.snp.height)
        }
        
        compV.key = "维修保养单位"
        userV.addSubview(compV)
        compV.snp.makeConstraints { make in
            make.top.equalTo(maintenanceTimeV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(modelV.snp.height)
        }
        
        responsibleV.key = "维修保养责任人"
        userV.addSubview(responsibleV)
        responsibleV.snp.makeConstraints { make in
            make.top.equalTo(compV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(modelV.snp.height)
        }
        
        operatorV.key = "检查操作人"
        userV.addSubview(operatorV)
        operatorV.snp.makeConstraints { make in
            make.top.equalTo(responsibleV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(modelV.snp.height)
            make.bottom.equalTo(userV.snp.bottom).offset(-10)
        }
        
        let resultV = UIView()
        resultV.backgroundColor = .white
        resultV.layer.cornerRadius = 10
        addSubview(resultV)
        resultV.snp.makeConstraints { make in
            make.top.equalTo(userV.snp.bottom).offset(10)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        let resultTV = TitleItemView(withTitle: "回放发现问题")
        resultV.addSubview(resultTV)
        resultTV.snp.makeConstraints { make in
            make.top.equalTo(resultV.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(46)
        }
        
        problemsL.layer.borderColor = UIColor.hex("#EBEBEB").cgColor
        problemsL.layer.borderWidth = 0.5
        problemsL.layer.cornerRadius = 4
        problemsL.insets = UIEdgeInsets(top: 13, left: 14, bottom: 13, right: 14)
        problemsL.textColor = .hex("#333333")
        problemsL.font = UIFont.systemFont(ofSize: 15)
        problemsL.numberOfLines = 0
        resultV.addSubview(problemsL)
        problemsL.snp.makeConstraints { make in
            make.top.equalTo(resultTV.snp.bottom)
            make.left.equalTo(resultV.snp.left).offset(10)
            make.right.equalTo(resultV.snp.right).offset(-10)
            make.height.equalTo(116)
            make.bottom.equalTo(resultV.snp.bottom).offset(-10)
        }
        
        let bottomIV = UIImageView(image: UIImage(named: "elec_bottom"))
        addSubview(bottomIV)
        bottomIV.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(resultV.snp.bottom).offset(40)
            make.bottom.equalTo(self.snp.bottom).offset(-16)
            make.height.equalTo(24)
        }
    }
}
