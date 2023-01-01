//
//  TaskCompletionRateView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/23.
//

import Foundation
import UIKit
import HandyJSON

class TaskCompletionRateView: UIView {
    let titleL = UILabel()
    let contentV = UIView()

    var title = "过去七天任务完成率" {
        didSet {
            titleL.text = title
        }
    }
    
    var datas: [TaskRateModal]? = []

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
        updateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData(_ datas: [TaskRateModal]?) {
        self.datas = datas
        updateUI()
    }
    
    func updateUI() {
        contentV.removeAllSubViews()
        
        let itemWidth = (ScreenWidth - 40) / 7.0
        
        var lastV: CompletionRateView?
        
        for data in datas! {
            let rateV = CompletionRateView()
            rateV.update(withModal: data)
            contentV.addSubview(rateV)
            if lastV == nil {
                rateV.snp.makeConstraints { make in
                    make.top.equalToSuperview()
                    make.width.equalTo(itemWidth)
                    make.left.equalTo(contentV.snp.left).offset(10)
                }
            } else {
                rateV.snp.makeConstraints { make in
                    make.top.equalToSuperview()
                    make.width.equalTo(itemWidth)
                    make.left.equalTo(lastV!.snp.right)
                }
            }
            
            lastV = rateV
        }
    }
    
    func setupUI() {
        backgroundColor = .white
        layer.masksToBounds = true
        layer.cornerRadius = 10
        
        titleL.text = "过去七天任务完成率"
        titleL.textColor = .hex("#333333")
        titleL.font = .systemFont(ofSize: 16)
        addSubview(titleL)
        titleL.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(23)
            make.centerX.equalToSuperview()
        }
        
        addSubview(contentV)
        contentV.snp.makeConstraints { make in
            make.top.equalTo(titleL.snp.bottom).offset(40)
            make.width.bottom.left.right.equalToSuperview()
        }
    }
}

class CompletionRateView: UIView {
    let bgV = UIView()
    let completeV = UIView()
    let dateL = UILabel()
    let weekL = UILabel()
    let rateL = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .bg
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(withModal modal: TaskRateModal) {
        completeV.snp.updateConstraints { make in
            make.height.equalTo(165 * (Double(modal.zwcl ?? "0") ?? 0) / 100)
        }
        weekL.text = modal.week
        dateL.text = modal.date
        rateL.text = "\(modal.zwcl ?? "0")%"
    }
    
    func setupUI() {
        bgV.backgroundColor = .hex("#F6F6F6")
        bgV.layer.cornerRadius = 6.5
        bgV.layer.masksToBounds = true
        addSubview(bgV)
        bgV.snp.makeConstraints { make in
            make.width.equalTo(13)
            make.height.equalTo(165)
            make.top.centerX.equalToSuperview()
        }
        
        completeV.backgroundColor = .hex("#306EC8")
        completeV.layer.cornerRadius = 6.5
        completeV.layer.masksToBounds = true
        addSubview(completeV)
        completeV.snp.makeConstraints { make in
            make.width.equalTo(13)
            make.height.equalTo(0)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(bgV.snp.bottom)
        }
        
        dateL.textColor = .hex("#969A9F")
        dateL.font = .systemFont(ofSize: 13)
        addSubview(dateL)
        dateL.snp.makeConstraints { make in
            make.top.equalTo(bgV.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
        
        weekL.textColor = .hex("#969A9F")
        weekL.font = .systemFont(ofSize: 13)
        addSubview(weekL)
        weekL.snp.makeConstraints { make in
            make.top.equalTo(dateL.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
        }
        
        rateL.textColor = .hex("#306EC8")
        rateL.font = .systemFont(ofSize: 13)
        addSubview(rateL)
        rateL.snp.makeConstraints { make in
            make.top.equalTo(weekL.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
        }
    }
}
