//
//  ElecVisitorView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/15.
//

import Foundation
import UIKit

class ElecVisitorView: UIView, PullToRefreshPresentable {
    let tableView = UITableView(frame: .zero, style: .plain)
    var datas: [StandingBookModal?] = []
    
    let statusCtl = BSStatusControl()
    var typeDatas: [StandingBookTypeModal?] = [] {
        didSet {
            updateTypes()
        }
    }
    
    let param = StandingBookParam(pageSize: PageSize)
    var pageNum: Int64 = 1

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupPullToRefresh(on: tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateTypes() {
        var dataSource: [SelectPopModal] = [SelectPopModal(name: "全部类型")]
        for model in typeDatas {
            dataSource.append(SelectPopModal(id: (model?.typeValue)!, name: (model?.typeLabel)!))
        }
        DispatchQueue.main.async {
            self.statusCtl.dataSource = dataSource
        }
    }
    
    func reload(withDeptId deptId: Int64?) {
        param.deptId = deptId
        param.date = Date.todayDate()
        pageNum = 1
        
        fetchData()
    }
    
    func fetchData() {
        /// 访客登记
        param.pageNum = pageNum
        API.getStandingBookVisitor(withParam: param) { responseModel in
            DispatchQueue.main.async {
                if self.pageNum > 1 && (responseModel.models == nil || responseModel.models?.count == 0) {
                    self.pageNum -= 1
                    return
                }
                if self.pageNum == 1 {
                    self.datas.removeAll()
                }
                self.datas.append(contentsOf: responseModel.models ?? [])
                self.tableView.tableShowEmpty(withDataCount: self.datas.count)
                self.tableView.reloadData()
            }
        }
    }
    
    func reloadAction() {
        pageNum = 1
        fetchData()
    }
    
    func loadAction() {
        pageNum += 1
        fetchData()
    }
    
    deinit {
        tableView.removeAllPullToRefresh()
    }
    
    func setupUI() {
        statusCtl.backgroundColor = .bg
        statusCtl.key = "全部类型"
        statusCtl.didSelectItemWith = { (index, modal) -> () in
            self.statusCtl.key = modal.name
            self.param.bookType = modal.id
            self.pageNum = 1
            self.fetchData()
        }
        addSubview(statusCtl)
        statusCtl.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(38)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(statusCtl.snp.bottom)
        }
    }
}

extension ElecVisitorView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = datas[indexPath.row]
        let ID : String = "VisitorListCell"
            
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = VisitorListCell(style: .subtitle, reuseIdentifier: ID)
        }
        
        (cell as? VisitorListCell)?.reload(withData: data, typeDatas: typeDatas)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let modal = datas[indexPath.row]
        if modal?.status == "0" {
            exitTapped(withModal: modal)
        }
    }
    
    func exitTapped(withModal modal: StandingBookModal?) {
        let alertC = UIAlertController(title: modal?.attrValue2, message: modal?.attrValue1, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取 消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "离 开", style: .default, handler: { action in
            self.didExit(withModal: modal)
        })
        alertC.addAction(cancelAction)
        alertC.addAction(okAction)
        getFirstViewController()?.present(alertC, animated: true)
    }
    
    func didExit(withModal modal: StandingBookModal?) {
        API.postStandingBookSignout(withParam: StandingBookParam(bookId: modal?.bookId, bookType: modal?.bookType)) { responseModel in
            self.pageNum = 1
            self.fetchData()
        }
    }
}
