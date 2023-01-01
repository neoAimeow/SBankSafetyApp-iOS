//
//  ElecHistoryView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/23.
//
// 【首页-电子台账】人员列表页面-历史记录

import Foundation
import UIKit

class ElecHistoryView: UIView, PullToRefreshPresentable {
    let tableView = UITableView(frame: .zero, style: .plain)
    let statusCtl = BSStatusControl()
    let dateCtl = BSDateControl()
    
    var typeDatas: [StandingBookTypeModal?] = [] {
        didSet {
            updateTypes()
        }
    }
    var datas: [StandingBookModal?] = []
    var sections: [String] = []

    var pageNum: Int64 = 1
    
    let param = StandingBookParam(pageSize: PageSize)
    
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
        pageNum = 1
        fetchData()
    }
    
    func fetchData() {
        /// 台账历史记录列表
        param.pageNum = pageNum
        API.getStandingBookList(withParam: param) { responseModel in
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

    // MARK: - Setup
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
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(38)
            make.width.equalTo(ScreenWidth/2.0)
        }
        
        dateCtl.nameL.text = "登记时间"
        dateCtl.backgroundColor = .bg
        dateCtl.dateMode = .date
        dateCtl.maximumDate = Date()
        dateCtl.didSelectDateWith = { (date) -> () in
            self.param.date = date.elTodayDate()
            self.pageNum = 1
            self.fetchData()
        }
        addSubview(dateCtl)
        dateCtl.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
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
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .white
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(statusCtl.snp.bottom)
        }
    }
}

extension ElecHistoryView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = datas[indexPath.row]
        let ID : String = "ElecHistoryCell"
            
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = ElecHistoryCell(style: .value1, reuseIdentifier: ID)
        }
        
        (cell as? ElecHistoryCell)?.reload(withData: data!, isLast: datas.count - 1 == indexPath.row, typeDatas: typeDatas)

        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let modal = datas[indexPath.row]
        let visitor_vc = ElecHistoryDetailVC(withModal: modal!)
        getFirstViewController()?.navigationController?.pushViewController(visitor_vc, animated: true)
    }
}

