//
//  InspListView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/22.
//

import Foundation
import UIKit

class InspListView: UIView {
    let tableView = UITableView(frame: .zero, style: .plain)

    let summaryV = InspListSummaryView()
    let statusCtl = BSStatusControl()
    let dateCtl = BSDateRangeControl()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    
    func setupUI() {
        addSubview(summaryV)
        summaryV.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(54)
        }
        
        let dataSource = [
            SelectPopModal(id: "", name: "全部"),
            SelectPopModal(id: "0", name: "未开始"),
            SelectPopModal(id: "1", name: "进行中"),
            SelectPopModal(id: "2", name: "待确认"),
            SelectPopModal(id: "3", name: "运行正常"),
            SelectPopModal(id: "4", name: "运行异常"),
            SelectPopModal(id: "5", name: "超时未提交"),
            SelectPopModal(id: "6", name: "已取消")
        ]
        
        statusCtl.key = "状态（全部）"
        statusCtl.dataSource = dataSource
        addSubview(statusCtl)
        statusCtl.snp.makeConstraints { (make) in
            make.top.equalTo(summaryV.snp.bottom)
            make.left.equalToSuperview()
            make.height.equalTo(38)
            make.width.equalTo(ScreenWidth/2.0)
        }
        
        addSubview(dateCtl)
        dateCtl.snp.makeConstraints { (make) in
            make.top.equalTo(summaryV.snp.bottom)
            make.right.equalToSuperview()
            make.height.equalTo(38)
            make.width.equalTo(ScreenWidth/2.0)
        }
        
        let vLine1 = UIView()
        vLine1.backgroundColor = .hex("#EAEAEA")
        addSubview(vLine1)
        vLine1.snp.makeConstraints { make in
            make.left.equalTo(statusCtl.snp.right)
            make.centerY.equalTo(statusCtl.snp.centerY)
            make.height.equalTo(24)
            make.width.equalTo(0.5)
        }
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .bg
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(statusCtl.snp.bottom).offset(5)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
}

class InspListSummaryView: UIView {
    let onlineV = InspListSummaryCard()
    let completionV = InspListSummaryCard()
    let failureV = InspListSummaryCard()
    let maintenanceV = InspListSummaryCard()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(withData modal: CountPatrolPatrModal?) {
        onlineV.val = "\(modal?.doing ?? 0)"
        completionV.val = "\(modal?.total ?? 0)"
        failureV.val = "\(modal?.undoing ?? 0)"
        maintenanceV.val = "\(modal?.percent ?? 0)"
    }
    
    // MARK: - Setup
    
    func setupUI() {
        backgroundColor = .hex("#FCF2ED")
        
        let itemW = ScreenWidth / 4.0

        onlineV.key = "生成任务总数"
        addSubview(onlineV)
        onlineV.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left)
            make.top.equalTo(self.snp.top)
            make.width.equalTo(itemW)
        }
        
        let vLine1 = UIView()
        vLine1.backgroundColor = .hex("#F6DBCE")
        addSubview(vLine1)
        vLine1.snp.makeConstraints { make in
            make.left.equalTo(onlineV.snp.right)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(27)
            make.width.equalTo(0.5)
        }
        
        completionV.key = "已完成"
        addSubview(completionV)
        completionV.snp.makeConstraints { make in
            make.left.equalTo(onlineV.snp.right)
            make.centerY.equalTo(onlineV.snp.centerY)
            make.width.equalTo(itemW)
        }
        
        let vLine2 = UIView()
        vLine2.backgroundColor = .hex("#F6DBCE")
        addSubview(vLine2)
        vLine2.snp.makeConstraints { make in
            make.left.equalTo(completionV.snp.right)
            make.top.equalTo(vLine1.snp.top)
            make.bottom.equalTo(vLine1.snp.bottom)
            make.width.equalTo(vLine1.snp.width)
        }
        
        failureV.key = "未完成"
        addSubview(failureV)
        failureV.snp.makeConstraints { make in
            make.left.equalTo(completionV.snp.right)
            make.centerY.equalTo(onlineV.snp.centerY)
            make.width.equalTo(itemW)
        }
        
        let vLine3 = UIView()
        vLine3.backgroundColor = .hex("#F6DBCE")
        addSubview(vLine3)
        vLine3.snp.makeConstraints { make in
            make.left.equalTo(failureV.snp.right)
            make.top.equalTo(vLine1.snp.top)
            make.bottom.equalTo(vLine1.snp.bottom)
            make.width.equalTo(vLine1.snp.width)
        }
        
        maintenanceV.key = "完成率"
        addSubview(maintenanceV)
        maintenanceV.snp.makeConstraints { make in
            make.left.equalTo(failureV.snp.right)
            make.centerY.equalTo(onlineV.snp.centerY)
            make.width.equalTo(itemW)
        }
    }
}

class InspListSummaryCard: UIView {
    var key: String? {
        didSet {
            keyL.text = key
        }
    }
    
    var val: String? {
        didSet {
            valueL.text = val
        }
    }
    
    
    let keyL = UILabel()
    let valueL = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func update(withKey key: String, value: String?) {
//        keyL.text = key
//        valueL.text = value
//    }
    
    // MARK: - Setup
    
    func setupUI() {
        valueL.textColor = .hex("#FF5200")
        valueL.font = .systemFont(ofSize: 15)
        addSubview(valueL)
        valueL.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.centerX.equalToSuperview()
        }
        
        keyL.textColor = .hex("#FF5200")
        keyL.font = .systemFont(ofSize: 12)
        addSubview(keyL)
        keyL.snp.makeConstraints { make in
            make.top.equalTo(valueL.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
}
