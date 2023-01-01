//
//  DetailSecurityLegalView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/17.
//

import Foundation
import UIKit

class DetailSecurityLegalView: UIScrollView {
    let dateV = ElecItemView()
    let timeV = ElecItemView()
    let addrV = ElecItemView()
    let nameV = ElecItemView()
    let attendeesV = ElecItemView()
    let recorderV = ElecItemView()
    let resultL = PaddingLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        showsVerticalScrollIndicator = false
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData(_ modal: StandingBookModal) {
        dateV.updateUI(withValue: Date.momentDate(modal.attrValue0 ?? ""))
        timeV.updateUI(withValue: modal.attrValue1)
        addrV.updateUI(withValue: modal.attrValue2)
        nameV.updateUI(withValue: modal.attrValue3)
        attendeesV.updateUI(withValue: modal.attrValue4)
        recorderV.updateUI(withValue: modal.attrValue6)
        resultL.text = modal.attrValue5
    }

    func setupUI() {
        let noteV = UIView()
        noteV.backgroundColor = .white
        noteV.layer.cornerRadius = 10
        addSubview(noteV)
        noteV.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        let userTV = TitleItemView(withTitle: "宣传教育记录")
        noteV.addSubview(userTV)
        userTV.snp.makeConstraints { make in
            make.top.equalTo(noteV.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(46)
        }
        
        dateV.key = "日期"
        noteV.addSubview(dateV)
        dateV.snp.makeConstraints { make in
            make.top.equalTo(userTV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        timeV.key = "时间"
        noteV.addSubview(timeV)
        timeV.snp.makeConstraints { make in
            make.top.equalTo(dateV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(dateV.snp.height)
        }
        
        addrV.key = "地点"
        noteV.addSubview(addrV)
        addrV.snp.makeConstraints { make in
            make.top.equalTo(timeV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(dateV.snp.height)
        }
        
        nameV.key = "主持人"
        noteV.addSubview(nameV)
        nameV.snp.makeConstraints { make in
            make.top.equalTo(addrV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(dateV.snp.height)
        }
        
        attendeesV.key = "出席人员"
        noteV.addSubview(attendeesV)
        attendeesV.snp.makeConstraints { make in
            make.top.equalTo(nameV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(dateV.snp.height)
        }
        
        recorderV.key = "记录人"
        noteV.addSubview(recorderV)
        recorderV.snp.makeConstraints { make in
            make.top.equalTo(attendeesV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(dateV.snp.height)
            make.bottom.equalTo(noteV.snp.bottom).offset(-10)
        }
        
        let resultV = UIView()
        resultV.backgroundColor = .white
        resultV.layer.cornerRadius = 10
        addSubview(resultV)
        resultV.snp.makeConstraints { make in
            make.top.equalTo(noteV.snp.bottom).offset(10)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        let resultTV = TitleItemView(withTitle: "内容")
        resultV.addSubview(resultTV)
        resultTV.snp.makeConstraints { make in
            make.top.equalTo(resultV.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(46)
        }
        
        resultL.layer.borderColor = UIColor.hex("#EBEBEB").cgColor
        resultL.layer.borderWidth = 0.5
        resultL.layer.cornerRadius = 4
        resultL.insets = UIEdgeInsets(top: 13, left: 14, bottom: 13, right: 14)
        resultL.textColor = .hex("#333333")
        resultL.font = UIFont.systemFont(ofSize: 15)
        resultL.numberOfLines = 0
        resultV.addSubview(resultL)
        resultL.snp.makeConstraints { make in
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
