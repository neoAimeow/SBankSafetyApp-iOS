//
//  DetailCashBoxView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/17.
//

import Foundation
import UIKit

class DetailCashBoxView: UIScrollView {
    let sendDateV = ElecItemView()
    let cashV = ElecItemView()
    let boxV = ElecItemView()
    let sendTransferV = ElecItemView()
    
    let acceptsendDateV = ElecItemView()
    let acceptCashV = ElecItemView()
    let acceptBoxV = ElecItemView()
    let acceptTransferV = ElecItemView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        showsVerticalScrollIndicator = false
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData(_ modal: StandingBookModal) {
        sendDateV.updateUI(withValue: Date.momentDate(modal.attrValue0 ?? ""))
        cashV.updateUI(withValue: modal.attrValue1)
        boxV.updateUI(withValue: modal.attrValue2)
        sendTransferV.updateUI(withValue: modal.attrValue3)
        acceptsendDateV.updateUI(withValue:  Date.momentDate(modal.attrValue4 ?? ""))
        acceptCashV.updateUI(withValue: modal.attrValue5)
        acceptBoxV.updateUI(withValue: modal.attrValue6)
        acceptTransferV.updateUI(withValue: modal.attrValue7)
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
        
        let userTV = TitleItemView(withTitle: "库款箱记录")
        noteV.addSubview(userTV)
        userTV.snp.makeConstraints { make in
            make.top.equalTo(noteV.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(46)
        }
        
        sendDateV.key = "送库时间"
        noteV.addSubview(sendDateV)
        sendDateV.snp.makeConstraints { make in
            make.top.equalTo(userTV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        cashV.key = "领解现金额(元)"
        noteV.addSubview(cashV)
        cashV.snp.makeConstraints { make in
            make.top.equalTo(sendDateV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(sendDateV.snp.height)
        }
        
        boxV.key = "款箱(只)"
        noteV.addSubview(boxV)
        boxV.snp.makeConstraints { make in
            make.top.equalTo(cashV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(sendDateV.snp.height)
        }
        
        sendTransferV.key = "送库交接人"
        noteV.addSubview(sendTransferV)
        sendTransferV.snp.makeConstraints { make in
            make.top.equalTo(boxV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(sendDateV.snp.height)
        }
        
        acceptsendDateV.key = "接库时间"
        noteV.addSubview(acceptsendDateV)
        acceptsendDateV.snp.makeConstraints { make in
            make.top.equalTo(sendTransferV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(sendDateV.snp.height)
        }
        
        acceptCashV.key = "领解现金额(元)"
        noteV.addSubview(acceptCashV)
        acceptCashV.snp.makeConstraints { make in
            make.top.equalTo(acceptsendDateV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(sendDateV.snp.height)
        }
        
        acceptBoxV.key = "款箱(只)"
        noteV.addSubview(acceptBoxV)
        acceptBoxV.snp.makeConstraints { make in
            make.top.equalTo(acceptCashV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(sendDateV.snp.height)
        }
        
        acceptTransferV.key = "接库交待人"
        noteV.addSubview(acceptTransferV)
        acceptTransferV.snp.makeConstraints { make in
            make.top.equalTo(acceptBoxV.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(sendDateV.snp.height)
            make.bottom.equalTo(noteV.snp.bottom).offset(-10)
        }
        
        let bottomIV = UIImageView(image: UIImage(named: "elec_bottom"))
        addSubview(bottomIV)
        bottomIV.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(noteV.snp.bottom).offset(40)
            make.bottom.equalTo(self.snp.bottom).offset(-16)
            make.height.equalTo(24)
        }
    }
}
