//
//  ElecLedgerHomeVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/23.
//
// 【首页-电子台账】电子台账列表页面

import Foundation

import UIKit

class ElecLedgerHomeVC: SubLevelViewController {
    let datas = ["台账薄", "当日登记", "历史记录"]

    let bottomV = UIView()
    let segmentedC = BSSegmentedControl()

    let contentV = UIView()

    var ledgerV: ElecLedgerView!
    let visitorV = ElecVisitorView()
    let historyV = ElecHistoryView()
    
    var typeDatas: [StandingBookTypeModal?] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "台账薄"
        view.backgroundColor = .bg
        navigationController?.navBarStyle(.white)
        
        if deptName == nil {
            deptName = BSUser.currentUser.deptName
            deptId = BSUser.currentUser.deptId
        }
        
        ledgerV = ElecLedgerView(withDeptId: deptId)
        setupUI()
        
        reloadData()
    }
    
    func reloadData() {
        /// 获取台账类型
        API.getStandingBookTypelist { responseModel in
            self.typeDatas = responseModel.models ?? []
            DispatchQueue.main.async {
                self.ledgerV.typeDatas = self.typeDatas
                self.visitorV.typeDatas = self.typeDatas
                self.historyV.typeDatas = self.typeDatas
            }
        }
    }
    
    // MARK: - Actions
    
    func segmentedTapped(_ index: Int) {
        if index == 0 { // 台账薄
            title = "台账薄"
            showElecLedger()
            navigationItem.rightBarButtonItems = []
        } else if index == 1 { // 当日登记
            title = "当日登记"
            showVisitor()
            navigationItem.rightBarButtonItems = []
        } else if index == 2 { // 历史记录
            title = "历史记录"
            showHistory()
//            setupNavItems()
        }
    }
    
    @objc func printTapped() {
        navigationController?.pushViewController(ElecLedgerPrintVC(), animated: true)
    }
    
    // MARK: - Setup
        
    // 台账薄
    func showElecLedger() {
        contentV.removeAllSubViews()

        contentV.addSubview(ledgerV)
        ledgerV.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        ledgerV.reloadData()
    }
    
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
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(bottomV.snp.top)
        }
        
        showElecLedger()
    }
    
    func setupNavItems() {
        let hisBtn = UIButton(type: .custom)
        hisBtn.setImage(UIImage(named: "ic_print"), for: .normal)
        hisBtn.addTarget(self, action: #selector(printTapped), for: .touchUpInside)
        let hisBar = UIBarButtonItem(customView: hisBtn)
        navigationItem.rightBarButtonItems = [hisBar]
    }
}
