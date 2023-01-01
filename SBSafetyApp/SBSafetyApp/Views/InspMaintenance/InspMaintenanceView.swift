//
//  InspMaintenanceView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/23.
//

import Foundation
import UIKit

class InspMaintenanceView: UIView {
    
    let header = InspMaintenanceHeader(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 60))

    let tableView = UITableView(frame: .zero, style: .plain)

    var datas: [ParTemplateModal?] = []
    
    var deptId: Int64? = -1
    var deptName: String?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reload(withDeptId _deptId: Int64?, deptName _deptName: String?) {
        deptId = _deptId
        deptName = _deptName
        let month = Calendar.current.dateComponents([.month], from: Date()).month ?? 1
        let year = Calendar.current.dateComponents([.year], from: Date())
        fetchData("\(year)\(month)")
    }
    
    func fetchData(_ month: String) {
        self.showToastActivity()
        API.getParList(withParam: ParHomeParam(deptId: deptId, mouth: month)) { responseModel in
            self.datas = responseModel.models ?? []
            DispatchQueue.main.async {
                self.hideToastActivity()
                self.tableView.tableShowEmpty(withDataCount: self.datas.count)
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Setup
    func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .bg
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        tableView.tableHeaderView = header
        header.delegate = self
    }
}

extension InspMaintenanceView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = datas[indexPath.row]
        let ID : String = "InspMaintenanceCell"
            
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = InspMaintenanceCell(style: .subtitle, reuseIdentifier: ID)
        }
        
        (cell as? InspMaintenanceCell)?.reload(withModal: data)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = datas[indexPath.row]

        let role = UserDefaults.standard.string(forKey: SafetyUserRole)
        if (role == UserRole.Engineer.rawValue) {
            let vc = SEInspListVC(withDeptId: deptId, deptName: deptName, wbtype: data?.dictValue)
            getFirstViewController()?.navigationController?.pushViewController(vc, animated: true)
        } else if (role == UserRole.Lattice.rawValue) {
            let vc = InspListVC(withDeptId: deptId, deptName: deptName, wbtype: data?.dictValue)
            getFirstViewController()?.navigationController?.pushViewController(vc, animated: true)
        } else {}
    }
}

extension InspMaintenanceView: InspMainHeaderDelegate {
    func handleMonthDidSelected(_ month: Int) {
        let year = Calendar.current.dateComponents([.year], from: Date())
        fetchData("\(year)\(month)")
    }
}
