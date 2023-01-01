//
//  BSDeptStiscResultView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/14.
//

import Foundation
import UIKit

protocol BSDeptStiscResultViewDelegate: AnyObject {
    func handleDeptSearchDidSelected(_ modal: TaskDeptRateModal)
}

class BSDeptStiscResultView: UIView {
    let headerV = BSSearchBar(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 60))
    let tableView = UITableView(frame: .zero, style: .grouped)

    weak var delegate: BSDeptStiscResultViewDelegate?

    var resultDatas: [TaskDeptRateModal?] = []
    
    var depts: [TaskDeptRateModal?] = []

    init(withDepts depts: [TaskDeptRateModal?]) {
        super.init(frame: .zero)
        setupUI()
        self.depts = depts
        NotificationCenter.default.addObserver(self, selector: #selector(textFiledEditChanged), name: UITextField.textDidChangeNotification, object: headerV.searchTF)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resetUI() {
        resultDatas = []
        headerV.searchTF.text = ""
        headerV.searchTF.becomeFirstResponder()
        tableView.reloadData()
    }
    
    func reloadData(withVal val: String) {
        resultDatas = depts.filter({$0?.wdmc?.contains(val) == true})
        self.tableView.tableShowEmpty(withDataCount: self.resultDatas.count)
        self.tableView.reloadData()
    }
    
    @objc func textFiledEditChanged() {
        let value = headerV.searchTF.text
        
        if value == nil || value == "" {
            resultDatas = []
        } else {
            resultDatas.removeAll()
            reloadData(withVal: value ?? "")
        }
        
        tableView.reloadData()
    }
    
    func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .white
        tableView.keyboardDismissMode = .interactive
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
        
        headerV.searchTF.placeholder = "搜索网点"
        headerV.padding = 25
        tableView.tableHeaderView = headerV
    }
}

extension BSDeptStiscResultView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultDatas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = resultDatas[indexPath.row]
        let ID : String = "BSDeptStiscPopCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil { cell = UITableViewCell(style: .default, reuseIdentifier: ID) }
        cell?.textLabel?.text = data?.wdmc
        cell?.textLabel?.font = .systemFont(ofSize: 15)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let modal = resultDatas[indexPath.row]
        delegate?.handleDeptSearchDidSelected(modal!)
    }
}
