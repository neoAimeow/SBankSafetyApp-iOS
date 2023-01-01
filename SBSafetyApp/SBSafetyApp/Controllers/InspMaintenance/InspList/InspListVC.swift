//
//  InspListVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/23.
//
// 【首页-维保服务】巡检记录

import Foundation
import UIKit

class InspListVC: SubLevelViewController, PullToRefreshPresentable {
    let listV = InspListView()
    var datas : [ParListModal?] = []
    
    var param = ParFormParam(pageSize: PageSize)
    var c_param = CountParam()

    var pageNum: Int64 = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "巡检记录"
        view.backgroundColor = .bg
        setupNavItems()
        
        setupPullToRefresh(on: listV.tableView)

        if deptName == nil {
            deptName = BSUser.currentUser.deptName
            deptId = BSUser.currentUser.deptId
        }
        
        param.deptid = deptId
        param.dictLabel = wbtype
        
        c_param.deptId = deptId
        c_param.tmplValue = wbtype
        
        setupUI()
        reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navBarStyle(.white)
    }
    
    deinit {
        listV.tableView.removeAllPullToRefresh()
    }
    
    func reloadAction() {
        pageNum = 1
        getList()
    }
    
    func loadAction() {
        pageNum += 1
        getList()
    }
        
    @objc func searchTapped() {
        
    }
    
    @objc func chartTapped() {
        navigationController?.pushViewController(InspectionReportVC(withDeptId: deptId, deptName: deptName, wbtype: wbtype),
                                                 animated: true)
    }
    
    func reloadData() {
        /// 巡检记录-网点-头部红色
        API.getCountPatrolPatr(withParam: c_param) { responseModel in
            DispatchQueue.main.async {
                self.listV.summaryV.update(withData: responseModel.model)
            }
        }
        
        getList()
    }
    
    func getList() {
        param.pageNum = pageNum

        view.showToastActivity()
        /// 维保服务-巡检记录
        API.getParFromList(withParam: param) { responseModel in
            if self.pageNum > 1 && (responseModel.models == nil || responseModel.models?.count == 0) {
                self.pageNum -= 1
                return
            }
            if self.pageNum == 1 {
                self.datas.removeAll()
            }
            self.datas.append(contentsOf: responseModel.models ?? [])
            DispatchQueue.main.async {
                self.view.hideToastActivity()
                self.listV.tableView.tableShowEmpty(withDataCount: self.datas.count)
                self.listV.tableView.reloadData()
            }
        }
    }
    
    func setupUI() {
        listV.tableView.dataSource = self
        listV.tableView.delegate = self
        view.addSubview(listV)
        listV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        listV.statusCtl.didSelectItemWith = { (index, modal) -> () in
            self.listV.statusCtl.key = "状态（\(modal.name)）"
            self.param.status = modal.id
            self.param.pageNum = 1
            self.reloadData()
        }
        listV.dateCtl.didSelectRangeWith = { (start, end) -> () in
            self.param.startTime = start.momentTimeZero()
            self.param.endTime = end.momentTimeEnd()
            
            self.c_param.startTime = start.elTodayDate()
            self.c_param.endTime = end.elTodayDate()

            self.param.pageNum = 1
            self.reloadData()
        }
    }
    
    func setupNavItems() {
        let chartBtn = UIButton(type: .custom)
        chartBtn.setImage(UIImage(named: "ic_chart"), for: .normal)
        chartBtn.addTarget(self, action: #selector(chartTapped), for: .touchUpInside)
        let chartBar = UIBarButtonItem(customView: chartBtn)
        
        let searchBtn = UIButton(type: .custom)
        searchBtn.setImage(UIImage(named: "ic_search"), for: .normal)
        searchBtn.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
        let searchBar = UIBarButtonItem(customView: searchBtn)
        
        navigationItem.rightBarButtonItems = [searchBar, chartBar]
    }
    
}

extension InspListVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = datas[indexPath.row]
        let ID : String = "InspListCell"
            
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = InspListCell(style: .subtitle, reuseIdentifier: ID)
        }
        
        (cell as? InspListCell)?.reload(withModal: data)
        (cell as? InspListCell)?.confirmedBtn.addTarget(self, action: #selector(toBeConfirmedTapped), for: .touchUpInside)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 162
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = datas[indexPath.row]
        let vc = InspListDetailVC(withModal: data!)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // 确认
    @objc func toBeConfirmedTapped(_ sender: RepairModalButton) {
        if sender.parItem == nil { return }
        navigationController?.pushViewController(InspListDetailVC(withModal: sender.parItem!), animated: true)
    }
}

