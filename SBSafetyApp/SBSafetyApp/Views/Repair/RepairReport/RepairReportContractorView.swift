//
//  RepairReportContractorView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/28.
//

import Foundation
import UIKit

class RepairReportContractorView: UIView {
    let tableView = UITableView(frame: .zero, style: .plain)
    let statusCtl = BSStatusControl()
    let dateCtl = BSMonthControl()

    let datas: [Any] = []
    
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
    
    // MARK: - Setup
    
    func setupUI() {
        let dataSource = [
            SelectPopModal(name: "综合成绩"), SelectPopModal(name: "修复速度"),
            SelectPopModal(name: "进行中"), SelectPopModal(name: "待确认"),
        ]
        statusCtl.backgroundColor = .bg
        statusCtl.dataSource = dataSource
        statusCtl.key = "综合成绩"
        statusCtl.didSelectItemWith = { (index, modal) -> () in
            print("Selected item: \(modal) at index: \(index)")
            self.statusCtl.key = modal.name
        }
        addSubview(statusCtl)
        statusCtl.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth/2.0)
        }
        
        dateCtl.backgroundColor = .bg
        addSubview(dateCtl)
        dateCtl.snp.makeConstraints { (make) in
            make.right.top.equalToSuperview()
            make.height.equalTo(50)
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
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(statusCtl.snp.bottom)
        }
    }
}

extension RepairReportContractorView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let data = datas[indexPath.row]
        let ID : String = "MyRepairCell"

        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = MyRepairCell(style: .subtitle, reuseIdentifier: ID)
        }
//
//        (cell as? MyRepairCell)?.reload(withModal: data)
//        (cell as? MyRepairCell)?.reviewsBtn.addTarget(self, action: #selector(reviewsTapped), for: .touchUpInside)
//        (cell as? MyRepairCell)?.evaluatedBtn.addTarget(self, action: #selector(evaluatedTapped), for: .touchUpInside)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 162
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let data = datas[indexPath.row]
//        let vc = RepairDetailVC(withModal: data)
//        getFirstViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
}
