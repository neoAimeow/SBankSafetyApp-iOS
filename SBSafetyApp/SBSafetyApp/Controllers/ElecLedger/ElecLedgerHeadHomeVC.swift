//
//  ElecLedgerHeadHomeVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/12.
//

import Foundation
import UIKit

class ElecLedgerHeadHomeVC: SubLevelViewController {
    let datas = ["当日登记", "历史记录"]
    let headerV = ElecHeaderView()

    let bottomV = UIView()
    let segmentedC = BSSegmentedControl()

    let contentV = UIView()

    let visitorV = ElecVisitorView()
    let historyV = ElecHistoryView()
        
    let static_param = StandingBookParam(date: Date.todayDate())

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "当日登记"
        view.backgroundColor = .bg
        navigationController?.navBarStyle(.white)
        if deptName == nil {
            deptName = BSUser.currentUser.deptName
            deptId = BSUser.currentUser.deptId
        }
        static_param.deptId = deptId
        static_param.dateType = CustomDateEnum.daily.rawValue
        static_param.date = Date.todayDate()

        setupUI()
        
        reloadData()
    }
    
    func reloadData() {
        /// 获取台账类型
        API.getStandingBookTypelist { responseModel in
            DispatchQueue.main.async {
                self.visitorV.typeDatas = responseModel.models ?? []
                self.historyV.typeDatas = responseModel.models ?? []
            }
        }
        
        /// 获取统计
        getStatistics()
    }
    
    
    func getStatistics() {
        /// 获取统计
        API.getStandingBookStatistics(withParam: static_param) { responseModel in
            DispatchQueue.main.async {
                self.headerV.updateUI(withModal: responseModel.model)
            }
        }
    }
    
    
    //
    func fetchData() {
        if segmentedC.currentSelectedIndex == 0 {
            visitorV.reload(withDeptId: deptId)
        } else if segmentedC.currentSelectedIndex == 0 {
            historyV.reload(withDeptId: deptId)
        }
    }
    
    // MARK: - Actions
    
    func segmentedTapped(_ index: Int) {
        if index == 0 { // 当日登记
            title = "当日登记"
            showVisitor()
            navigationItem.rightBarButtonItems = []
        } else if index == 1 { // 历史记录
            title = "历史记录"
            showHistory()
//            setupNavItems()
        }
    }
    
    @objc func printTapped() {
        navigationController?.pushViewController(ElecLedgerPrintVC(), animated: true)
    }
    
    // MARK: - Setup
    
    // 当日登记
    func showVisitor() {
        contentV.removeAllSubViews()

        contentV.addSubview(visitorV)
        visitorV.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        visitorV.reload(withDeptId: deptId)
    }
    
    // 历史记录
    func showHistory() {
        contentV.removeAllSubViews()

        contentV.addSubview(historyV)
        historyV.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        historyV.reload(withDeptId: deptId)
    }
    
    func setupUI() {
        headerV.customV.delegate = self
        view.addSubview(headerV)
        headerV.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(178)
        }
        
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
        segmentedC.itemTitles = datas
        segmentedC.currentSelectedIndex = 0
        segmentedC.didSelectItemWith = { (index, title) -> () in
            self.segmentedTapped(index)
        }
        
        view.addSubview(contentV)
        contentV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(headerV.snp.bottom)
            make.bottom.equalTo(bottomV.snp.top)
        }
        
        showVisitor()
    }
    
    func setupNavItems() {
        let hisBtn = UIButton(type: .custom)
        hisBtn.setImage(UIImage(named: "ic_print"), for: .normal)
        hisBtn.addTarget(self, action: #selector(printTapped), for: .touchUpInside)
        let hisBar = UIBarButtonItem(customView: hisBtn)
        navigationItem.rightBarButtonItems = [hisBar]
    }
}

extension ElecLedgerHeadHomeVC: BSCustomDateViewDelegate {
    func didSelected(year: Int, quarter: Int?, month: Int?, day: Int?, dateEnum: CustomDateEnum) {
        static_param.dateType = dateEnum.rawValue
        static_param.date = "\(year)-\(month ?? 0)-\(day ?? 0)"
        getStatistics()
    }
}
