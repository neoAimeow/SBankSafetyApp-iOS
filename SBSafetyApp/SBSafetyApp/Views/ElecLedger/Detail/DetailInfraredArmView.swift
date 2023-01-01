//
//  DetailInfraredArmView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/17.
//

import Foundation
import UIKit

class DetailInfraredArmView: UIScrollView {
    let disarmV = ElecItemView()
    let disarmSignV = ElecItemView()
    let armV = ElecItemView()
    let armSignV = ElecItemView()
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
        disarmV.updateUI(withValue: Date.momentDate(modal.attrValue0 ?? ""))
        disarmSignV.updateUI(imgURL: modal.attrValue1)
        armV.updateUI(withValue:  Date.momentDate(modal.attrValue2 ?? ""))
        armSignV.updateUI(imgURL: modal.attrValue3)
        resultL.text = modal.attrValue4
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
        
        let userTV = TitleItemView(withTitle: "布、撤防记录")
        noteV.addSubview(userTV)
        userTV.snp.makeConstraints { make in
            make.top.equalTo(noteV.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(46)
        }
        
        disarmV.key = "撤防时间"
        noteV.addSubview(disarmV)
        disarmV.snp.makeConstraints { make in
            make.top.equalTo(userTV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        disarmSignV.key = "撤防人签名"
        noteV.addSubview(disarmSignV)
        disarmSignV.snp.makeConstraints { make in
            make.top.equalTo(disarmV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(disarmV.snp.height)
        }
        
        armV.key = "布防时间"
        noteV.addSubview(armV)
        armV.snp.makeConstraints { make in
            make.top.equalTo(disarmSignV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(disarmV.snp.height)
        }
        
        armSignV.key = "布防人签名"
        noteV.addSubview(armSignV)
        armSignV.snp.makeConstraints { make in
            make.top.equalTo(armV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(disarmV.snp.height)
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
        
        let resultTV = TitleItemView(withTitle: "发现问题记录")
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
