//
//  MyRepairInBranchView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/25.
//

import Foundation
import UIKit

class MyRepairInBranchView: UIView {
    let tableView = UITableView(frame: .zero, style: .plain)

    let summaryV = InspListSummaryView()
   
    let datas: [YjwxListModal] = []
    
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
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .bg
        tableView.delegate = self
        tableView.dataSource = self
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(summaryV.snp.bottom).offset(5)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
}

extension MyRepairInBranchView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = datas[indexPath.row]
        let ID : String = "MyRepairCell"
            
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = MyRepairCell(style: .subtitle, reuseIdentifier: ID)
        }
        
        (cell as? MyRepairCell)?.reload(withModal: data)
        (cell as? MyRepairCell)?.reviewsBtn.addTarget(self, action: #selector(reviewsTapped), for: .touchUpInside)
        (cell as? MyRepairCell)?.evaluatedBtn.addTarget(self, action: #selector(evaluatedTapped), for: .touchUpInside)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 162
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = datas[indexPath.row]
        let vc = RepairDetailVC(withModal: data)
        getFirstViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func reviewsTapped(_ sender: RepairModalButton) {
        if sender.modal == nil { return }

        getFirstViewController()?.navigationController?.pushViewController(MyReviewsVC(withModal: sender.modal!), animated: true)
    }
    
    @objc func evaluatedTapped(_ sender: RepairModalButton) {
        if sender.modal == nil { return }

        getFirstViewController()?.navigationController?.pushViewController(EvaluatedVC(withModal: sender.modal!), animated: true)
    }
}
