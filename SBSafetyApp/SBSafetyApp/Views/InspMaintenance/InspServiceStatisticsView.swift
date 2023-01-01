//
//  InspServiceStatisticsView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/11.
//

import Foundation
import UIKit

class InspServiceStatisticsView: UIScrollView {
    let dateV = BSCustomDateView()
    let rateV = TaskFinishRateView(frame: CGRect(x: 0, y: 0, width: 90, height: 90))
    let summaryItem = TaskHomeItemView()
    let finishItem = TaskHomeItemView()
    let unfinishItem = TaskHomeItemView()
    
    let contenV = UIView()

    var datas: [WbWclModal?] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .bg
        showsVerticalScrollIndicator = false
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    @objc func onSelectedDept(_ sender: UIControl) {
        let md = datas[sender.tag]
        
        getFirstViewController()?.navigationController?.pushViewController(InspStatisticsVC(wbtype: md?.wbType), animated: true)
    }
    
    func reload(witModal modal: WbCLFirstModal?) {
        rateV.valL.text = "\(modal?.zwcl ?? 0)%"
        summaryItem.valL.text = "\(modal?.rwzs ?? 0)"
        finishItem.valL.text = "\(modal?.ywcs ?? 0)"
        unfinishItem.valL.text = "\(modal?.wwcs ?? 0)"
        
        contenV.removeAllSubViews()
        
        datas = modal!.wclList ?? []
                
        var lastI: TaskCompletionRateItemView?
                
        for (index, record) in modal!.wclList!.enumerated() {
            let itemV = TaskCompletionRateItemView()
            itemV.reloadData(withModal: record)
            itemV.ctl.tag = index
            itemV.ctl.addTarget(self, action: #selector(onSelectedDept), for: .touchUpInside)
            contenV.addSubview(itemV)
            itemV.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                if lastI == nil {
                    make.top.equalTo(contenV.snp.top).offset(20)
                } else {
                    make.top.equalTo(lastI!.snp.bottom).offset(20)
                }
                if index == modal!.wclList!.count - 1 {
                    make.bottom.equalToSuperview()
                }
            }
            lastI = itemV
        }
        
    }
    
    func reload(withRateItems datas: [TaskDeptRateModal]?) {
        contenV.removeAllSubViews()
                
        var lastI: TaskCompletionRateItemView?
                
        for (index, record) in datas!.enumerated() {
            let itemV = TaskCompletionRateItemView()
            itemV.reloadData(withModal: record)
            itemV.ctl.tag = index
            itemV.ctl.addTarget(self, action: #selector(onSelectedDept), for: .touchUpInside)
            contenV.addSubview(itemV)
            itemV.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                if lastI == nil {
                    make.top.equalTo(contenV.snp.top).offset(20)
                } else {
                    make.top.equalTo(lastI!.snp.bottom).offset(20)
                }
                if index == datas!.count - 1 {
                    make.bottom.equalToSuperview()
                }
            }
            lastI = itemV
        }
        
    }
    
    func setupUI() {
        let baseV = UIView.createBase()
        addSubview(baseV)
        baseV.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        let baseTV = TitleItemView()
        baseTV.title = "维保服务"
        baseV.addSubview(baseTV)
        baseTV.snp.makeConstraints { make in
            make.top.equalTo(baseV.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(46)
        }
        
        baseV.addSubview(dateV)
        dateV.snp.makeConstraints { make in
            make.top.equalTo(baseTV.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(35)
        }
        
        baseV.addSubview(rateV)
        rateV.snp.makeConstraints { make in
            make.top.equalTo(dateV.snp.bottom).offset(20)
            make.left.equalTo(baseV.snp.left).offset(10)
            make.width.height.equalTo(90)
        }
        
        let itemWidth = (ScreenWidth - 130.0) / 3.0
        summaryItem.key = "任务总数"
        baseV.addSubview(summaryItem)
        summaryItem.snp.makeConstraints { make in
            make.top.equalTo(rateV.snp.top)
            make.left.equalTo(rateV.snp.right).offset(4)
            make.width.equalTo(itemWidth)
        }
        
        let vLine1 = UIView()
        vLine1.backgroundColor = .hex("#F5F5F5")
        addSubview(vLine1)
        vLine1.snp.makeConstraints { make in
            make.left.equalTo(summaryItem.snp.right)
            make.centerY.equalTo(rateV.snp.centerY)
            make.height.equalTo(42)
            make.width.equalTo(0.5)
        }
        
        finishItem.key = "已完成数"
        baseV.addSubview(finishItem)
        finishItem.snp.makeConstraints { make in
            make.top.equalTo(rateV.snp.top)
            make.left.equalTo(summaryItem.snp.right)
            make.width.equalTo(itemWidth)
        }
        
        let vLine2 = UIView()
        vLine2.backgroundColor = .hex("#F5F5F5")
        addSubview(vLine2)
        vLine2.snp.makeConstraints { make in
            make.left.equalTo(finishItem.snp.right)
            make.centerY.equalTo(rateV.snp.centerY)
            make.height.equalTo(42)
            make.width.equalTo(0.5)
        }
        
        unfinishItem.key = "未完成数"
        unfinishItem.valL.textColor = .hex("#F17854")
        baseV.addSubview(unfinishItem)
        unfinishItem.snp.makeConstraints { make in
            make.top.equalTo(rateV.snp.top)
            make.left.equalTo(finishItem.snp.right)
            make.width.equalTo(itemWidth)
        }
        
        baseV.addSubview(contenV)
        contenV.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(rateV.snp.bottom)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}
