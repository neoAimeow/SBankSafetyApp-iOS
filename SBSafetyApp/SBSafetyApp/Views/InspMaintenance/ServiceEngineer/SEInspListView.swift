//
//  SEInspListView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/11.
//

import Foundation
import UIKit

class SEInspListView: UIView {
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
            make.height.equalTo(46)
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
        statusCtl.dataSource = dataSource
        statusCtl.key = "状态（全部）"
        statusCtl.didSelectItemWith = { (index, modal) -> () in
            print("Selected item: \(modal) at index: \(index)")
            self.statusCtl.key = "状态（\(modal.name)）"
        }
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
