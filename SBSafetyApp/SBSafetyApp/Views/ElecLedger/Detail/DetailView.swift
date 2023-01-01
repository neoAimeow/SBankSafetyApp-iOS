//
//  DetailView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/17.
//

import Foundation
import UIKit

class DetailView: UIScrollView {
    let dateV = ElecItemView()
    let nameV = ElecItemView()
    let compV = ElecItemView()
    let numV = ElecItemView()
    let receptionistV = ElecItemView()
    let periodV = ElecItemView()
    let enterV = ElecItemView()
    let leaveV = ElecItemView()

    let resultV = ElecResultView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        showsVerticalScrollIndicator = false
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData(_ modal: StandingBookModal) {
        dateV.updateUI(withValue: Date.momentDate(modal.attrValue0 ?? "") )
        nameV.updateUI(withValue: modal.attrValue2)
        compV.updateUI(withValue: modal.attrValue1)
        numV.updateUI(withValue: modal.attrValue3)
        
        let type: ElecType = ElecType(rawValue: modal.bookType!)!
        switch type {
        case .OutMonitor, .OutBusiness:
            receptionistV.updateUI(withValue: modal.attrValue5)
            enterV.updateUI(withValue: modal.attrValue6)
            leaveV.updateUI(withValue: Date.momentTime(modal.attrValue7 ?? ""))
            resultV.value = modal.attrValue4
            
            receptionistV.isHidden = false
            receptionistV.snp.remakeConstraints { make in
                make.top.equalTo(numV.snp.bottom)
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.height.equalTo(dateV.snp.height)
            }
            break
        case .VideoMonitor:
            receptionistV.updateUI(withValue: modal.attrValue5)
            periodV.updateUI(withValue: modal.attrValue6)
            enterV.updateUI(withValue: modal.attrValue7)
            leaveV.updateUI(withValue: Date.momentTime(modal.attrValue8 ?? ""))
            resultV.value = modal.attrValue4
            
            receptionistV.isHidden = false
            receptionistV.snp.remakeConstraints { make in
                make.top.equalTo(numV.snp.bottom)
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.height.equalTo(dateV.snp.height)
            }
            periodV.isHidden = false
            periodV.snp.remakeConstraints { make in
                make.top.equalTo(receptionistV.snp.bottom)
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.height.equalTo(dateV.snp.height)
            }
            break
        default:
            enterV.updateUI(withValue: modal.attrValue5)
            leaveV.updateUI(withValue: Date.momentTime(modal.attrValue6 ?? ""))
            resultV.value = modal.attrValue4
            break
        }
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
        
        let userTV = TitleItemView(withTitle: "人员信息")
        userV.addSubview(userTV)
        userTV.snp.makeConstraints { make in
            make.top.equalTo(userV.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(46)
        }
        
        dateV.key = "来访日期"
        userV.addSubview(dateV)
        dateV.snp.makeConstraints { make in
            make.top.equalTo(userTV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        nameV.key = "访客姓名"
        userV.addSubview(nameV)
        nameV.snp.makeConstraints { make in
            make.top.equalTo(dateV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(dateV.snp.height)
        }
        
        compV.key = "访客单位"
        userV.addSubview(compV)
        compV.snp.makeConstraints { make in
            make.top.equalTo(nameV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(dateV.snp.height)
        }
        
        numV.key = "来访人数"
        userV.addSubview(numV)
        numV.snp.makeConstraints { make in
            make.top.equalTo(compV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(dateV.snp.height)
        }
        
        receptionistV.isHidden = true
        receptionistV.key = "接待人"
        userV.addSubview(receptionistV)
        receptionistV.snp.makeConstraints { make in
            make.top.equalTo(numV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(0)
        }
        
        periodV.isHidden = true
        periodV.key = "借、调阅录像时间段"
        userV.addSubview(periodV)
        periodV.snp.makeConstraints { make in
            make.top.equalTo(receptionistV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(0)
        }
        
        enterV.key = "进入时间"
        userV.addSubview(enterV)
        enterV.snp.makeConstraints { make in
            make.top.equalTo(periodV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(dateV.snp.height)
        }
        
        leaveV.key = "离开时间"
        userV.addSubview(leaveV)
        leaveV.snp.makeConstraints { make in
            make.top.equalTo(enterV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(dateV.snp.height)
            make.bottom.equalTo(userV.snp.bottom).offset(-10)
        }
        
        addSubview(resultV)
        resultV.snp.makeConstraints { make in
            make.top.equalTo(userV.snp.bottom).offset(10)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        let resultTV = TitleItemView(withTitle: "来访事由")
        resultV.addSubview(resultTV)
        resultTV.snp.makeConstraints { make in
            make.top.equalTo(resultV.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(46)
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

class ElecResultView: UIView {
    var title: String? {
        didSet {
            resultTV.title = title ?? "来访事由"
        }
    }
    
    var value: String? {
        didSet {
            resultL.text = value
        }
    }
    
    let resultL = PaddingLabel()
    let resultTV = TitleItemView(withTitle: "来访事由")

    override init(frame: CGRect) {
        super.init(frame: frame)
        setuUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setuUI() {
        backgroundColor = .white
        layer.cornerRadius = 10
        
        addSubview(resultTV)
        resultTV.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
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
        addSubview(resultL)
        resultL.snp.makeConstraints { make in
            make.top.equalTo(resultTV.snp.bottom)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.height.equalTo(116)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
        }
    }
}
