//
//  RepairReportView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/28.
//
// 【首页-一键报修】维修列表

import Foundation
import UIKit

public enum RepairReportType: Int {
    case time = 0
    case err = 1
    case contractor = 2
    case duration = 3
}

class RepairReportModal: NSObject {
    var icon: String?
    var name: String = ""
    var type: RepairReportType = .time
    
    init(icon: String? = nil, name: String, type: RepairReportType) {
        self.icon = icon
        self.name = name
        self.type = type
    }
}

class RepairReportView: UIView {
    let segmentedC = ScrollableSegmentedControl()
    let tableView = UITableView(frame: .zero, style: .plain)

    let datas = [
        RepairReportModal(icon: "ic_repair_report_time", name: "响应时间统计", type: .time),
        RepairReportModal(icon: "ic_repair_report_err", name: "故障信息统计", type: .err),
        RepairReportModal(icon: "ic_repair_report_contractor", name: "工程商满意度统计", type: .contractor),
        RepairReportModal(icon: "ic_repair_report_duration", name: "风险暴露时长统计", type: .duration),
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
        tableView.tableShowEmpty(withDataCount: datas.count)
        tableView.reloadData()
    }
    
    // MARK: - Actions
    @objc func segmentSelected(sender: ScrollableSegmentedControl) {
        print("segmentSelected", sender.selectedSegmentIndex)
//        let index = sender.selectedSegmentIndex
        
        reloadData()
    }
    
    // MARK: - Setup
    func setupUI() {
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth - 28, height: 161))
        let iv = UIImageView(image: UIImage(named: "repair_header"))
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 10
        header.addSubview(iv)
        iv.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .bg
        tableView.delegate = self
        tableView.dataSource = self
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(14)
            make.right.equalToSuperview().offset(-14)
        }
        tableView.tableHeaderView = header
        
        reloadData()
    }
}

extension RepairReportView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = datas[indexPath.row]
        let ID : String = "RepairReportCell"
            
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = RepairReportCell(style: .subtitle, reuseIdentifier: ID)
        }
        
        (cell as? RepairReportCell)?.reload(withModal: data)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = CornerView(frame: CGRect(x: 10, y: 0, width: ScreenWidth - 20, height: 16))
        v.backgroundColor = .white
        v.corners = SBRectCorner(topLeft: 10, topRight: 10)
        return v
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v = CornerView(frame: CGRect(x: 10, y: 0, width: ScreenWidth - 20, height: 16))
        v.backgroundColor = .white
        v.corners = SBRectCorner(bottomLeft: 10, bottomRight: 10)
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 16
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = datas[indexPath.row]
        
        switch data.type {
        case .time:
            getFirstViewController()?.navigationController?.pushViewController(RepairReportTimeVC(), animated: true)
            break
        case .err:
            getFirstViewController()?.navigationController?.pushViewController(RepairReportErrorVC(), animated: true)
            break
        case .contractor:
            getFirstViewController()?.navigationController?.pushViewController(RepairReportContractorVC(), animated: true)
            break
        case .duration:
            getFirstViewController()?.navigationController?.pushViewController(RepairReportDurationVC(), animated: true)
            break
        }
    }
}
