//
//  BSDeptallResultView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/7.
//

import Foundation
import UIKit

protocol BSDeptallResultViewDelegate: AnyObject {
    func handleDeptSearchDidSelected(_ modal: DeptModal)
}

class BSDeptallResultView: UIView {
    let headerV = BSSearchBar(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 60))
    let tableView = UITableView(frame: .zero, style: .grouped)

    weak var delegate: BSDeptallResultViewDelegate?

    var resultDatas: [DeptModal?] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
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
        showToastActivity()
        API.getHomeDeptall(withParam: HomeParam(deptName: val), block: { responseModel in
            DispatchQueue.main.async {
                self.resultDatas = responseModel.models ?? []
                self.hideToastActivity()
                self.tableView.tableShowEmpty(withDataCount: self.resultDatas.count)
                self.tableView.reloadData()
            }
        })
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
                make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            }
        }
        
        headerV.searchTF.placeholder = "搜索网点"
        headerV.padding = 25
        tableView.tableHeaderView = headerV
    }
}

extension BSDeptallResultView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultDatas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = resultDatas[indexPath.row]
        let ID : String = "BSDeptallPopCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil { cell = UITableViewCell(style: .default, reuseIdentifier: ID) }
        cell?.textLabel?.text = data?.deptName
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
        return 46
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let modal = resultDatas[indexPath.row]
        delegate?.handleDeptSearchDidSelected(modal!)
    }
}
