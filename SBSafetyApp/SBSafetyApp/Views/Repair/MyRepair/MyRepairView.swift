//
//  MyRepairView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/25.
//

import Foundation
import UIKit

public enum RepairStatus: Int {
    case pendingOrder   = 0 // 待接单
    case readyToGo      = 1 // 待出发
    case pendingArrival = 2 // 待到达
    case toBeFixed      = 3 // 待修复
    case toBeConfirmed  = 4 // 待确认
    case completed      = 5 // 已完工
    case cancelled      = 6 // 已取消
}

class MyRepairView: UIView, PullToRefreshPresentable {
    let tableView = UITableView(frame: .zero, style: .plain)

    let summaryV = RepairSummaryView()
    let statusCtl = BSStatusControl()
    let repairCtl = BSStatusControl()
    let dateCtl = BSStatusControl()
    let contractorCtl = BSStatusControl()

    var datas: [YjwxListModal?] = []
        
    var param = YjwxListParam()

    var pageNum: Int64 = 1

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupPullToRefresh(on: tableView)
        param.pageSize = PageSize
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        tableView.removeAllPullToRefresh()
    }
    
    func reloadAction() {
        pageNum = 1
        getList()
    }
    
    func loadAction() {
        pageNum += 1
        getList()
    }
    
    func reloadData(withDeptId deptId: Int64?) {
        param.wddm = deptId
        pageNum = 1

        // 获取报修单完成数
        API.getYjwxGetListTotal { responseModel in
            DispatchQueue.main.async {
                self.summaryV.update(withData: responseModel.model)
            }
        }
        
        // 报修单列表
        getList()
        
        /// 电话报修
        API.getYjwxGetDhbxList { responseModel in
//            self.contractors = responseModel.models ?? []
            DispatchQueue.main.async {
                let modals = responseModel.models ?? []
                var dataSource: [SelectPopModal] = [SelectPopModal(name: "全部工程商")]
                for model in modals {
                    dataSource.append(SelectPopModal(id: "\((model?.id)!)", name: (model?.gcsmc)!))
                }
                self.contractorCtl.dataSource = dataSource
            }
        }
    }
    
    // 报修单列表
    func getList() {
        param.pageNum = pageNum
        // 报修单列表
        API.getYjwxGetList(withParam: param) { responseModel in
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
    
    // MARK: - Setup
    
    func setupUI() {
        addSubview(summaryV)
        summaryV.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(54)
        }
    
        let dataSource = [
            SelectPopModal(name: "全部状态"),
            SelectPopModal(id: "0", name: "待接单"),
            SelectPopModal(id: "1", name: "待出发"),
            SelectPopModal(id: "2", name: "待到达"),
            SelectPopModal(id: "3", name: "待修复"),
            SelectPopModal(id: "4", name: "待确认"),
            SelectPopModal(id: "5", name: "已完工"),
            SelectPopModal(id: "6", name: "已取消"),
        ]
        
        statusCtl.dataSource = dataSource
        statusCtl.key = "全部状态"
        statusCtl.didSelectItemWith = { (index, modal) -> () in
            self.statusCtl.key = modal.name
            self.param.ddzt =  modal.id != nil ? Int64(modal.id!) : nil
            self.pageNum = 1
            self.getList()
        }
        addSubview(statusCtl)
        statusCtl.snp.makeConstraints { (make) in
            make.top.equalTo(summaryV.snp.bottom)
            make.left.equalToSuperview()
            make.height.equalTo(38)
            make.width.equalTo(ScreenWidth/4.0)
        }
        
        repairCtl.dataSource = [SelectPopModal(name: "全部报修"), SelectPopModal(id: "\(BSUser.currentUser.userId)", name: "本人报修")]
        repairCtl.key = "全部报修"
        repairCtl.didSelectItemWith = { (index, modal) -> () in
            self.repairCtl.key = modal.name
            self.param.bxrid = modal.id
            self.pageNum = 1
            self.getList()
        }
        addSubview(repairCtl)
        repairCtl.snp.makeConstraints { (make) in
            make.top.equalTo(summaryV.snp.bottom)
            make.left.equalTo(statusCtl.snp.right)
            make.height.equalTo(38)
            make.width.equalTo(ScreenWidth/4.0)
        }
        
        dateCtl.dataSource = [SelectPopModal(name: "全部时间"), SelectPopModal(id: "1", name: "最近二十次")]
        dateCtl.key = "全部时间"
        dateCtl.didSelectItemWith = { (index, modal) -> () in
            self.dateCtl.key = modal.name
            self.param.qbsj =  modal.id != nil ? Int64(modal.id!) : nil
            self.pageNum = 1
            self.getList()
        }
        addSubview(dateCtl)
        dateCtl.snp.makeConstraints { (make) in
            make.top.equalTo(summaryV.snp.bottom)
            make.left.equalTo(repairCtl.snp.right)
            make.height.equalTo(38)
            make.width.equalTo(ScreenWidth/4.0)
        }
        
        contractorCtl.dataSource = [SelectPopModal(name: "全部工程商")]
        contractorCtl.key = "全部工程商"
        contractorCtl.didSelectItemWith = { (index, modal) -> () in
            self.contractorCtl.key = modal.name
            self.param.wxgcsid = modal.id
            self.pageNum = 1
            self.getList()
        }
        addSubview(contractorCtl)
        contractorCtl.snp.makeConstraints { (make) in
            make.top.equalTo(summaryV.snp.bottom)
            make.left.equalTo(dateCtl.snp.right)
            make.height.equalTo(38)
            make.width.equalTo(ScreenWidth/4.0)
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
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .bg
        tableView.delegate = self
        tableView.dataSource = self
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(statusCtl.snp.bottom).offset(5)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
}

extension MyRepairView: UITableViewDataSource, UITableViewDelegate {
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
            cell = MyRepairCell(style: .default, reuseIdentifier: ID)
        }
        
        (cell as? MyRepairCell)?.reload(withModal: data!)
        (cell as? MyRepairCell)?.reviewsBtn.addTarget(self, action: #selector(reviewsTapped), for: .touchUpInside)
        (cell as? MyRepairCell)?.evaluatedBtn.addTarget(self, action: #selector(evaluatedTapped), for: .touchUpInside)
        (cell as? MyRepairCell)?.toBeConfirmedBtn.addTarget(self, action: #selector(toBeConfirmedTapped), for: .touchUpInside)
        (cell as? MyRepairCell)?.cancelBtn.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        return cell!
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 152
//    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = datas[indexPath.row]
        let ID : String = "MyRepairCell"
            
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = MyRepairCell(style: .default, reuseIdentifier: ID)
        }
        return (cell as? MyRepairCell)?.cellHeight(withModal: data!) ?? 186
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = datas[indexPath.row]
        let vc = RepairDetailVC(withModal: data!)
        getFirstViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
    
    // 查看评价
    @objc func reviewsTapped(_ sender: RepairModalButton) {
        if sender.modal == nil { return }

        getFirstViewController()?.navigationController?.pushViewController(MyReviewsVC(withModal: sender.modal!), animated: true)
    }
    
    // 去评价
    @objc func evaluatedTapped(_ sender: RepairModalButton) {
        if sender.modal == nil { return }

        getFirstViewController()?.navigationController?.pushViewController(EvaluatedVC(withModal: sender.modal!), animated: true)
    }
    
    // 确认修复
    @objc func toBeConfirmedTapped(_ sender: RepairModalButton) {
        if sender.modal == nil { return }
        getFirstViewController()?.navigationController?.pushViewController(ToBeConfirmedDetailVC(withModal: sender.modal!), animated: true)
    }
    
    // 取消
    @objc func cancelTapped(_ sender: RepairModalButton) {
        // 网点人员取消
        showToastActivity()
        API.postYjwxBranchStaffCancel(withParam: YjwxParam(id: sender.modal?.id)) { responseModel in
            DispatchQueue.main.async {
                self.hideToastActivity()
                if responseModel.errorCode == .Success {
                    self.showToast(witMsg: responseModel.errorMessage)
                    Utils.delay(second: 1) { self.getList() }
                }
            }
        }
    }
}

class RepairSummaryView: UIView {
    let onlineV = InspListSummaryCard()
    let completionV = InspListSummaryCard()
    let failureV = InspListSummaryCard()
    let maintenanceV = InspListSummaryCard()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(withData modal: YjwxListTotalModal?) {
        onlineV.val = modal?.wdwx
        completionV.val = modal?.ywc
        failureV.val = modal?.wwc
        maintenanceV.val = "\(modal?.wcl ?? "0")%"
    }
    
    // MARK: - Setup
    
    func setupUI() {
        backgroundColor = .hex("#FCF2ED")
        
        let itemW = ScreenWidth / 4.0

        onlineV.key = "我的维修单"
        addSubview(onlineV)
        onlineV.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left)
            make.top.equalTo(self.snp.top)
            make.width.equalTo(itemW)
        }
        
        let vLine1 = UIView()
        vLine1.backgroundColor = .hex("#F6DBCE")
        addSubview(vLine1)
        vLine1.snp.makeConstraints { make in
            make.left.equalTo(onlineV.snp.right)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(27)
            make.width.equalTo(0.5)
        }
        
        completionV.key = "已完成"
        addSubview(completionV)
        completionV.snp.makeConstraints { make in
            make.left.equalTo(onlineV.snp.right)
            make.centerY.equalTo(onlineV.snp.centerY)
            make.width.equalTo(itemW)
        }
        
        let vLine2 = UIView()
        vLine2.backgroundColor = .hex("#F6DBCE")
        addSubview(vLine2)
        vLine2.snp.makeConstraints { make in
            make.left.equalTo(completionV.snp.right)
            make.top.equalTo(vLine1.snp.top)
            make.bottom.equalTo(vLine1.snp.bottom)
            make.width.equalTo(vLine1.snp.width)
        }
        
        failureV.key = "未完成"
        addSubview(failureV)
        failureV.snp.makeConstraints { make in
            make.left.equalTo(completionV.snp.right)
            make.centerY.equalTo(onlineV.snp.centerY)
            make.width.equalTo(itemW)
        }
        
        let vLine3 = UIView()
        vLine3.backgroundColor = .hex("#F6DBCE")
        addSubview(vLine3)
        vLine3.snp.makeConstraints { make in
            make.left.equalTo(failureV.snp.right)
            make.top.equalTo(vLine1.snp.top)
            make.bottom.equalTo(vLine1.snp.bottom)
            make.width.equalTo(vLine1.snp.width)
        }
        
        maintenanceV.key = "完成率"
        addSubview(maintenanceV)
        maintenanceV.snp.makeConstraints { make in
            make.left.equalTo(failureV.snp.right)
            make.centerY.equalTo(onlineV.snp.centerY)
            make.width.equalTo(itemW)
        }
    }
}
