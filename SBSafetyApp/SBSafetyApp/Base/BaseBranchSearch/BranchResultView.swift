//
//  BranchResultView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/30.
//

import Foundation
import UIKit

//protocol BranchResultViewDelegate: AnyObject {
//    func handleBranchResultDidSelected(_ modal: DeptModal)
//}

class BranchResultView: UIView {
    let headerV = BSSearchBar(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 60))
    let tableView = UITableView(frame: .zero, style: .grouped)

    open var didSelectBranchWith:((_ modal: DeptModal) -> ())?

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
        API.getDeptList(withParam: DeptParam(deptname: val)) { responseModel in
            self.resultDatas = responseModel.models ?? []
            DispatchQueue.main.async {
                self.tableView.tableShowEmpty(withDataCount: self.resultDatas.count)
                self.tableView.reloadData()
            }
        }
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
        tableView.keyboardDismissMode = .onDrag
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
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

extension BranchResultView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultDatas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = resultDatas[indexPath.row]
        let ID : String = "BranchSearchCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil { cell = BranchSearchCell(style: .default, reuseIdentifier: ID) }
        (cell as? BranchSearchCell)?.reload(withModal: data!)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let modal = resultDatas[indexPath.section]
        didSelectBranchWith?(modal!)
    }
}
