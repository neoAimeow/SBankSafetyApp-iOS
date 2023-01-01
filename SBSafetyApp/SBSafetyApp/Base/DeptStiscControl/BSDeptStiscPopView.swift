//
//  BSDeptStiscPopView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/14.
//

import Foundation
import UIKit
import JFPopup

protocol BSDeptStiscPopViewDelegate: AnyObject {
    func handleSelected(_ dept: TaskDeptRateModal?)
}

class BSDeptStiscPopView: UIView {
    let headerV = BSSearchButton(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 60))
    let tableView = UITableView(frame: .zero, style: .grouped)

    var resultV: BSDeptStiscResultView!

    weak var delegate: BSDeptStiscPopViewDelegate?

    var depts: [TaskDeptRateModal?] = []
        
    init(withDepts depts: [TaskDeptRateModal?]) {
        super.init(frame: .zero)
        resultV = BSDeptStiscResultView(withDepts: depts)
        setupUI()
        self.depts = depts
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func showSearchTapped() {
        if resultV.superview == nil {
            resultV.delegate = self
            addSubview(resultV)
            resultV.snp.makeConstraints { make in
                make.top.left.right.bottom.equalToSuperview()
            }
            resultV.resetUI()
        }
    }
    
    @objc func cencelTFTapped() {
        if resultV.superview != nil {
            resultV.delegate = nil
            resultV.removeFromSuperview()
        }
    }
    
    func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .white
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            if #available(iOS 15.0, *) {
                make.bottom.equalTo(self.keyboardLayoutGuide.snp.top)
            } else {
                // Fallback on earlier versions
                make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            }
        }
        
        headerV.titleL.text = "搜索网点"
        headerV.padding = 25
        headerV.ctl.addTarget(self, action: #selector(showSearchTapped), for: .touchUpInside)
        tableView.tableHeaderView = headerV
        
        resultV.headerV.cancelBtn.addTarget(self, action: #selector(cencelTFTapped), for: .touchUpInside)
    }
}

extension BSDeptStiscPopView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return depts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = depts[indexPath.row]
        let ID : String = "BSDeptStiscPopCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil { cell = UITableViewCell(style: .default, reuseIdentifier: ID) }
        cell?.textLabel?.text = data?.wdmc
        cell?.textLabel?.font = .systemFont(ofSize: 15)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let modal = depts[indexPath.row]
        delegate?.handleSelected(modal)
    }
}

extension BSDeptStiscPopView: BSDeptStiscResultViewDelegate {
    func handleDeptSearchDidSelected(_ modal: TaskDeptRateModal) {
        delegate?.handleSelected(modal)
    }
}
