//
//  BSStatisticsView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/7.
//

import Foundation
import UIKit

protocol BSStatisticsViewDelegate: AnyObject {
    func handleDeptSelected(_ dept: TaskDeptRateModal)
}

class BSStatisticsView: UIScrollView {
    let basicBV = UIView.createBase()
    let baseTV = TitleItemView()
    let deptBtn = BSDeptStiscControl()
    let customV = BSCustomDateView(withType: .subTitle)
    let contenV = UIView()

    let rateBV = UIView.createBase()
    let taskV = TaskCompletionRateView()
    
    var isMore = false {
        didSet {
            reload(withRateItems: self.deptItems)
        }
    }
    
    var deptItems: [TaskDeptRateModal]?
    weak var sDelegate: BSStatisticsViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        keyboardDismissMode = .interactive
        showsVerticalScrollIndicator = false
        bounces = true
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func loadMore() {
        self.isMore = true
    }
    
    @objc func onSelectedDept(_ sender: UIControl) {
        let item = deptItems?[sender.tag]
        
        sDelegate?.handleDeptSelected(item!)
    }
    
    func reloadData(deptName: String? = nil, modal: CommonScaleByDeptModal? = nil, hasWxds: Bool = false) {
        if deptName != nil {
            deptBtn.deptName = deptName!
        }
        
        if modal != nil {
            customV.subValue = "整体完成率: \(modal?.zwcl ?? "0")%"
            reload(withRateItems: modal?.wdList, hasWxds: hasWxds)
            self.deptItems = modal?.wdList
            deptBtn.depts = modal?.wdList ?? []
            taskV.reloadData(modal?.zxList)
            taskV.title = modal?.title ?? "任务完成率"
        }
    }
    
    func reloadData(deptName: String? = nil, modal: SelectLzglWclByDeptModel?) {
        if deptName != nil {
            deptBtn.deptName = deptName!
        }
        
        if modal != nil {
            customV.subValue = "整体完成率: \(modal?.zwcl ?? 0.0)%"
            reload(withRateItems: modal?.wdList)
            self.deptItems = modal?.wdList
            deptBtn.depts = modal?.wdList ?? []
            taskV.reloadData(modal?.zxList)
            taskV.title = modal?.title ?? "任务完成率"
        }
    }
    
    func reload(withRateItems datas: [TaskDeptRateModal]?, hasWxds: Bool = false) {
        contenV.removeAllSubViews()
                
        var lastI: TaskCompletionRateItemView?
                
        var sortDatas: [TaskDeptRateModal] = []
        
        for (index, record) in datas!.enumerated() {
            if index < 5 {
                sortDatas.append(record)
            }
        }
        
        if isMore == true {
            sortDatas.removeAll()
            sortDatas.append(contentsOf: datas!)
        }
        
        for (index, record) in sortDatas.enumerated() {
            let itemV = TaskCompletionRateItemView()    // 网点名称
            itemV.reloadData(withModal: record, hasWxds: hasWxds)
            itemV.ctl.tag = index
            itemV.ctl.addTarget(self, action: #selector(onSelectedDept), for: .touchUpInside)
            contenV.addSubview(itemV)
            if index == sortDatas.count - 1 {
                itemV.snp.makeConstraints { make in
                    make.left.right.equalToSuperview()
                    if lastI == nil {
                        make.top.equalTo(contenV.snp.top).offset(20)
                    } else {
                        make.top.equalTo(lastI!.snp.bottom).offset(20)
                    }
                    if (datas!.count < 5 || isMore == true) {
                        make.bottom.equalToSuperview()
                    }
                }
            } else {
                itemV.snp.makeConstraints { make in
                    make.left.right.equalToSuperview()
                    if lastI == nil {
                        make.top.equalTo(contenV.snp.top).offset(20)
                    } else {
                        make.top.equalTo(lastI!.snp.bottom).offset(20)
                    }
                }
            }
            lastI = itemV
        }
        
        if datas!.count > 5 && isMore == false {
            let moreBtn = UIButton(type: .custom)
            moreBtn.setTitleColor(.hex("#B1B1B1"), for: .normal)
            moreBtn.setTitle("查看更多", for: .normal)
            moreBtn.titleLabel?.font = .systemFont(ofSize: 14)
            moreBtn.addTarget(self, action: #selector(loadMore), for: .touchUpInside)
            contenV.addSubview(moreBtn)
            moreBtn.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalTo(lastI!.snp.bottom).offset(20)
                make.height.equalTo(20)
                make.bottom.equalToSuperview()
            }
        }
        
    }
   
    func setupBasicView() {
        addSubview(basicBV)
        basicBV.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth - 20)
        }
        
        basicBV.addSubview(baseTV)
        baseTV.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(46)
        }
        
        basicBV.addSubview(deptBtn)
        deptBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(baseTV.snp.bottom).offset(20)
            make.height.equalTo(35)
        }

        customV.subValue = "整体完成率: 0%"
        basicBV.addSubview(customV)
        customV.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(deptBtn.snp.bottom).offset(20)
            make.height.equalTo(35)
        }
        
        basicBV.addSubview(contenV)
        contenV.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(customV.snp.bottom)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    func setupRateView() {
        addSubview(rateBV)
        rateBV.snp.makeConstraints { make in
            make.top.equalTo(basicBV.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth - 20)
            make.bottom.equalToSuperview().offset(-40)
        }
        
        taskV.title = "过去6个月任务完成率"
        rateBV.addSubview(taskV)
        taskV.snp.makeConstraints { make in
            make.top.equalTo(rateBV.snp.top).offset(22)
            make.centerX.equalToSuperview()
            make.height.equalTo(322)
            make.width.equalTo(ScreenWidth - 20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    func setupUI() {
        // 基本信息
        setupBasicView()
        
        // 完成率
        setupRateView()

    }
}
