//
//  ElecLedgerView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/23.
//
// 【首页-电子台账】电子台账列表页面

import Foundation
import UIKit

class ElecLedgerHeaderView: UIView {
    let topV = ElecHeaderView()
    let segmentedC = ScrollableSegmentedControl()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(topV)
        topV.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(178)
        }
        
        segmentedC.tintColor = .primary
        segmentedC.underlineSelected = true
        segmentedC.segmentContentColor = .black
        segmentedC.selectedSegmentContentColor = .primary
        segmentedC.backgroundColor = .bg
        let normalAttrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        let highlightAttrs =  [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        let selectAttrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        segmentedC.setTitleTextAttributes(normalAttrs, for: .normal)
        segmentedC.setTitleTextAttributes(highlightAttrs, for: .highlighted)
        segmentedC.setTitleTextAttributes(selectAttrs, for: .selected)
        addSubview(segmentedC)
        segmentedC.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(topV.snp.bottom)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(48)
        }
        
        segmentedC.insertSegment(withTitle: "日任务", at: 0)
        segmentedC.insertSegment(withTitle: "月任务", at: 1)
        segmentedC.selectedSegmentIndex = 0
    }
}

class ElecLedgerView: UIView {
    let tableView = UITableView(frame: .zero, style: .plain)
    let headerV = ElecLedgerHeaderView()

    var typeDatas: [StandingBookTypeModal?] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    let param = StandingBookParam()
    
    init(withDeptId deptId: Int64?) {
        super.init(frame: .zero)
        setupUI()
        param.deptId = deptId
        param.dateType = CustomDateEnum.daily.rawValue
        param.date = Date.todayDate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc func segmentSelected(sender: ScrollableSegmentedControl) {
        print("segmentSelected", sender.selectedSegmentIndex)
//        let index = sender.selectedSegmentIndex
        tableView.reloadData()
    }
    
    
    func reloadData() {
        tableView.reloadData()

        getStatistics()
        
    }
    
    func getStatistics() {
        /// 获取统计
        API.getStandingBookStatistics(withParam: param) { responseModel in
            DispatchQueue.main.async {
                self.headerV.topV.updateUI(withModal: responseModel.model)
            }
        }
    }
    
    func setupUI() {
        headerV.topV.customV.delegate = self
        headerV.segmentedC.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)
        addSubview(headerV)
        headerV.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .bg
        tableView.showsVerticalScrollIndicator = false
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(headerV.snp.bottom)
            make.bottom.left.right.equalToSuperview()
        }
    }
    
    // MARK: - Datas
    var dayDatas: [StandingBookTypeModal?] {
        return typeDatas.filter({$0?.fpfs == "1"})
    }
    
    var monthDatas: [StandingBookTypeModal?] {
        return typeDatas.filter({$0?.fpfs == "2"})
    }
}

extension ElecLedgerView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headerV.segmentedC.selectedSegmentIndex == 0 ? dayDatas.count : monthDatas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ds = headerV.segmentedC.selectedSegmentIndex == 0 ? dayDatas : monthDatas

        let data = ds[indexPath.row]
        let ID : String = "ElecLedgerCell"
            
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = ElecLedgerCell(style: .value1, reuseIdentifier: ID)
        }
        
        (cell as? ElecLedgerCell)?.updateUI(withModal: data, isFirst: indexPath.row == 0, isLast: indexPath.row == ds.count - 1)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return " "
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ds = headerV.segmentedC.selectedSegmentIndex == 0 ? dayDatas : monthDatas
        guard let modal = ds[indexPath.row] else { return }
        register(withModal: modal, navi: getFirstViewController()?.navigationController)
    }
    
    func register(withModal modal: StandingBookTypeModal, navi: UINavigationController?) {
        let type: ElecType = ElecType(rawValue: modal.typeValue!)!
        switch type {
        case .ATM:
            navi?.pushViewController(ATMRoomVC(withModal: modal), animated: true)
            break
        case .SecurityLegal:
            navi?.pushViewController(SecurityLegalVC(withModal: modal), animated: true)
            break
        case .InfraredArm:
            navi?.pushViewController(InfraredArmVC(withModal: modal), animated: true)
            break
        case .Repair:
            navi?.pushViewController(RepairMaintenanceVC(withModal: modal), animated: true)
            break
        case .OutMonitor:
            navi?.pushViewController(OutsidersMonitorRVC(withModal: modal), animated: true)
            break
        case .VideoMonitor:
            navi?.pushViewController(VideoMonitorRVC(withModal: modal), animated: true)
            break
        case .CheckVideo:
            navi?.pushViewController(CheckVideoVC(withModal: modal), animated: true)
            break
        case .SimpleWarehouse:
            navi?.pushViewController(SimpleWarehouseVC(withModal: modal), animated: true)
            break
        case .CashBox:
            navi?.pushViewController(ReceiveSenCashBoxVC(withModal: modal), animated: true)
            break
        case .OutBusiness:
            navi?.pushViewController(OutsidersBusinessRVC(withModal: modal), animated: true)
            break
        case .SelfCheck:
            navi?.pushViewController(SelfCheckExcelVC(withModal: modal), animated: true)
            break
        case .SecurityCheck:
            navi?.pushViewController(SecurityCheckVC(withModal: modal), animated: true)
            break
        }
    }
}

extension ElecLedgerView: BSCustomDateViewDelegate {
    func didSelected(year: Int, quarter: Int?, month: Int?, day: Int?, dateEnum: CustomDateEnum) {
        param.dateType = dateEnum.rawValue
        param.date = "\(year)-\(month ?? 0)-\(day ?? 0)"
        getStatistics()
    }
}


class ElecHeaderView: UIView {
    let customV = BSCustomDateView()
    let rateV = TaskFinishRateView(frame: CGRect(x: 0, y: 0, width: 90, height: 90))
    let finishItem = TaskHomeItemView()
    let unfinishItem = TaskHomeItemView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .bg
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(withModal modal: StandingBookStatisticsModal?) {
        finishItem.val =  "\(modal?.complete ?? 0)"
        unfinishItem.val = "\(modal?.unregTotal ?? 0)"
        rateV.valL.text = "\(modal?.percent ?? "0")%"
    }
    
    func setupUI() {
        let baseV = UIView()
        baseV.backgroundColor = .white
        baseV.layer.cornerRadius = 10
        baseV.layer.masksToBounds = true
        addSubview(baseV)
        baseV.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        baseV.addSubview(customV)
        customV.snp.makeConstraints { make in
            make.top.equalTo(baseV.snp.top).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(35)
        }
        
        baseV.addSubview(rateV)
        rateV.snp.makeConstraints { make in
            make.top.equalTo(customV.snp.bottom).offset(20)
            make.left.equalTo(baseV.snp.left).offset(10)
            make.width.height.equalTo(90)
        }
        
        let itemWidth = (ScreenWidth - 130.0) / 2.0
        finishItem.key = "完成数"
        baseV.addSubview(finishItem)
        finishItem.snp.makeConstraints { make in
            make.top.equalTo(rateV.snp.top)
            make.left.equalTo(rateV.snp.right).offset(4)
            make.width.equalTo(itemWidth)
        }
        
        let vLine1 = UIView()
        vLine1.backgroundColor = .hex("#F5F5F5")
        addSubview(vLine1)
        vLine1.snp.makeConstraints { make in
            make.left.equalTo(finishItem.snp.right)
            make.centerY.equalTo(rateV.snp.centerY)
            make.height.equalTo(42)
            make.width.equalTo(0.5)
        }

        unfinishItem.key = "未完成数"
        unfinishItem.valL.textColor = .hex("#F17854")
        baseV.addSubview(unfinishItem)
        unfinishItem.snp.makeConstraints { make in
            make.top.equalTo(rateV.snp.top)
            make.left.equalTo(finishItem.snp.right)
            make.width.equalTo(itemWidth)
        }
    }
}
