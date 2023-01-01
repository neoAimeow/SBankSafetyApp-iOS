//
//  SEInspListVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/10.
//
// 【首页-维保服务】维修工程师-巡检记录

import Foundation
import UIKit

class SEInspListVC: SubLevelViewController, PullToRefreshPresentable {
    let listV = InspListView()
    let bottomV = UIView()
    let segmentedC = BSSegmentedControl()
    
    var datas : [ParListModal?] = []

    var param = ParFormParam(pageSize: PageSize)
    var c_param = CountParam()

    var pageNum: Int64 = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "巡检记录"
        view.backgroundColor = .bg
        
        setupPullToRefresh(on: listV.tableView)

        if deptName == nil {
            deptName = BSUser.currentUser.deptName
            deptId = BSUser.currentUser.deptId
        }
        
        param.deptid = deptId
        param.dictLabel = wbtype
        param.type = "0" // 总行/分行/支行/网点都为空，工程师传0：我的巡检；1是巡检列表
        
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
    
    func segmentedTapped(_ index: Int) {
        if index == 0 { // 巡检任务
            param.type = "0"
            pageNum = 1
            reloadData()
        } else if index == 1 { // 我的巡检
            param.type = "1"
            pageNum = 1
            reloadData()
        }
    }
    
    func reloadData() {
        /// 维保服务-巡检记录
        getList()
        
        /// 巡检记录-网点-头部红色
        API.getCountPatrolPatr(withParam: c_param) { responseModel in
            DispatchQueue.main.async {
                self.listV.summaryV.update(withData: responseModel.model)
            }
        }
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
        bottomV.backgroundColor = .white
        view.addSubview(bottomV)
        bottomV.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(56 + UIDevice.safeBottom())
        }
        
        let line = UIView()
        line.backgroundColor = .hex("#F2F2F2")
        bottomV.addSubview(line)
        line.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        bottomV.addSubview(segmentedC)
        segmentedC.snp.makeConstraints { make in
            make.top.equalTo(bottomV.snp.top).offset(10)
            make.left.equalTo(bottomV.snp.left).offset(22)
            make.right.equalTo(bottomV.snp.right).offset(-22)
            make.height.equalTo(36)
        }
        segmentedC.itemTitles = ["巡检任务", "我的巡检"]
        segmentedC.currentSelectedIndex = 0
        segmentedC.didSelectItemWith = { (index, title) -> () in
            self.segmentedTapped(index)
        }
        
        listV.tableView.dataSource = self
        listV.tableView.delegate = self
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
        view.addSubview(listV)
        listV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(bottomV.snp.top)
        }
    }
}

extension SEInspListVC: UITableViewDataSource, UITableViewDelegate {
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
        (cell as? InspListCell)?.startBtn.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
        (cell as? InspListCell)?.closeBtn.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 162
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = datas[indexPath.row]
        let vc = SEInspListDetailVC(withModal: data!)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // 开始巡检
    @objc func startTapped(_ sender: RepairModalButton) {
        if sender.parItem == nil { return }
        
        let e_param = EngineerParam(formId: sender.parItem?.formId)
        let fdvc = FaceDetectVC()
        fdvc.didSelectImageWith = { (img) -> () in
            fdvc.navigationController?.popViewController(animated: true)
            e_param.sign = img.imgToBase64()
            self.didStarted(withParam: e_param)
        }
        
        navigationController?.pushViewController(fdvc, animated: true)
    }
    
    func didStarted(withParam e_param: EngineerParam) {
        API.postEngineerArrive(withParam: e_param) { responseModel in
            DispatchQueue.main.async {
                self.view.hideToastActivity()
                if responseModel.errorCode == .Success {
                    self.view.showToast(witMsg: responseModel.errorMessage)
                    Utils.delay(second: 1) {
                        self.param.pageNum = 1
                        self.reloadData()
                    }
                }
            }
        }
    }
    
    // 结束巡检
    @objc func closeTapped(_ sender: RepairModalButton) {
        if sender.parItem == nil { return }

    }
}

