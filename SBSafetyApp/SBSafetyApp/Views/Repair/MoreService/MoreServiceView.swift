//
//  MoreServiceView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/28.
//
// 【首页-一键报修】一键报修-更多服务

import Foundation
import UIKit

class MoreServiceView: UIView {
    
    let todayRepairItem = MoreServiceItem(withIsSmall: false)
    let todayCompletedItem = MoreServiceItem()
    let todayRescheduledItem = MoreServiceItem()
    let todayCancelItem = MoreServiceItem()
    
    let departItem = MyItemView(withModal: MyItemModal(icon: "ic_device_add", name: "设备新增", status: .single, lineType: .line_none))

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
        
        API.getYjwxMoreServices { responseModel in
            print("getYjwxMoreServices", responseModel)
            DispatchQueue.main.async {
                self.hideToastActivity()
                let modal = responseModel.model
                self.todayRepairItem.updateUI(withKey: "今日报修（起）", value: modal?.jrbx)
                self.todayCompletedItem.updateUI(withKey: "今日完工", value: modal?.jrwg)
                self.todayRescheduledItem.updateUI(withKey: "今日改约", value: "0")
                self.todayCancelItem.updateUI(withKey: "今日取消", value: modal?.jrqx)
            }
        }
    }
   
    func setupUI() {
        
        let baseV = UIView.createBase()
        addSubview(baseV)
        baseV.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(14)
            make.right.equalToSuperview().offset(-14)
        }
        
        baseV.addSubview(todayRepairItem)
        todayRepairItem.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(19)
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(50)
        }
        
        let width = (ScreenWidth - 36) / 3.0
        
        baseV.addSubview(todayCompletedItem)
        todayCompletedItem.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(19)
            make.top.equalTo(todayRepairItem.snp.bottom).offset(33)
            make.height.equalTo(40)
            make.width.equalTo(width)
            make.bottom.equalTo(baseV.snp.bottom).offset(-25)
        }
        
        baseV.addSubview(todayRescheduledItem)
        todayRescheduledItem.snp.makeConstraints { make in
            make.left.equalTo(todayCompletedItem.snp.right)
            make.centerY.equalTo(todayCompletedItem.snp.centerY)
            make.height.equalTo(40)
            make.width.equalTo(width)
        }
        
        baseV.addSubview(todayCancelItem)
        todayCancelItem.snp.makeConstraints { make in
            make.left.equalTo(todayRescheduledItem.snp.right)
            make.centerY.equalTo(todayCompletedItem.snp.centerY)
            make.height.equalTo(40)
            make.width.equalTo(width)
        }
        
        departItem.isHidden = true
        addSubview(departItem)
        departItem.snp.makeConstraints { make in
            make.top.equalTo(baseV.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(79)
            make.width.equalTo(ScreenWidth - 28)
        }
    }
}

class MoreServiceItem: UIView {

    init(withIsSmall isSmall: Bool? = true) {
        super.init(frame: .zero)
        setupUI(withIsSmall: isSmall)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(withKey key: String, value: String?) {
        keyL.text = key
        valL.text = value
    }
    
    func setupUI(withIsSmall isSmall: Bool? = true) {
        addSubview(keyL)
        keyL.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left)
            make.top.equalTo(self.snp.top)
        }
        
        addSubview(valL)
        valL.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left)
            make.top.equalTo(keyL.snp.bottom).offset(10)
        }
        
        if isSmall == false {
            keyL.font = .systemFont(ofSize: 17)
            valL.font = .systemFont(ofSize: 24)
        }
    }
    
    lazy var keyL: UILabel = {
        let l = UILabel()
        l.textColor = .hex("#999999")
        l.font = UIFont.systemFont(ofSize: 14)
        l.textAlignment = .left
        return l
    }()
    
    lazy var valL: UILabel = {
        let l = UILabel()
        l.textColor = .hex("#3C72FF")
        l.font = UIFont.systemFont(ofSize: 17)
        l.textAlignment = .left
        return l
    }()
}
