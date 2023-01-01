//
//  RepairHomeVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/25.
//
// 【首页-一键报修】我的维修-提交列表

import Foundation
import UIKit
import Popover

class RepairHomeVC: SubLevelViewController {
    let datas = ["一键报修", "报修追踪"] // ["一键报修", "报修追踪", "更多服务"]

    let bottomV = UIView()
    let segmentedC = BSSegmentedControl()

    let contentV = UIView()

    let myRepairV = MyRepairView()
    let moreV = MoreServiceView()
    
    var pageIndex = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "报修追踪"
        view.backgroundColor = .bg
        navigationController?.navBarStyle(.white)
        navigationItem.rightBarButtonItems = [searchBar]
        
        if deptName == nil {
            deptName = BSUser.currentUser.deptName
            deptId = BSUser.currentUser.deptId
        }
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showMyRepair()
    }
    
    // MARK: - Actions
    
    func segmentedTapped(_ index: Int) {
        if index == 0 { // 我的维修
            onOneRepair()
        } else if index == 1 { // 报修追踪
            pageIndex = 1
            title = datas[1]
            showMyRepair()
        } else if index == 2 { // 更多服务
            pageIndex = 2
            title = datas[2]
            showMore()
        }
    }
    
    @objc func searchTapped() {
//        navigationController?.pushViewController(MyRepairInBranchVC(), animated: true)
        
        let bSearchVC = BranchSearchVC()
        bSearchVC.didSelectBranchWith = { (dept) -> () in
            self.deptName = dept.deptName
            self.deptId = dept.deptId
            self.title = dept.deptName
            
            bSearchVC.navigationController?.popViewController(animated: true)
        }
        navigationController?.pushViewController(bSearchVC, animated: true)
    }
    
    // MARK: - Setup
    
    // 一键报修
    func onOneRepair() {
        let vc = OneClickRepairVC(withDeptId: deptId, deptName: deptName)
        navigationController?.pushViewController(vc, animated: true)
        segmentedC.currentSelectedIndex = pageIndex
    }
    
        
    // 我的维修
    func showMyRepair() {
        contentV.removeAllSubViews()

        contentV.addSubview(myRepairV)
        myRepairV.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        myRepairV.reloadData(withDeptId: deptId)
    }
    
    // 更多服务
    func showMore() {
        contentV.removeAllSubViews()

        contentV.addSubview(moreV)
        moreV.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        moreV.reloadData()
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
        segmentedC.currentSelectedIndex = pageIndex
        segmentedC.didSelectItemWith = { (index, title) -> () in
            self.segmentedTapped(index)
        }
        
        view.addSubview(contentV)
        contentV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(bottomV.snp.top)
        }
    }
    
    lazy var searchBar: UIBarButtonItem = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "ic_search"), for: .normal)
        btn.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
        let bar = UIBarButtonItem(customView: btn)
        return bar
    }()
}

//class RepairHomeVC: SubLevelViewController {
//    let datas = ["我的维修", "我的处置", "维修报表", "更多服务"]
//
//    let bottomV = UIView()
//    let segmentedC = BSSegmentedControl()
//
//    let contentV = UIView()
//
//    let myRepairV = MyRepairView()
//    let toBeConfirmedV = ToBeConfirmedView()
//    let reportV = RepairReportView()
//    let moreV = MoreServiceView()
//
//    fileprivate var options: [PopoverOption] = [
//        .type(.auto), .showBlackOverlay(false), .cornerRadius(6), .color(.white), .arrowSize(CGSize(width: 10, height: 5))
//    ]
//    fileprivate var popover: Popover!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        title = "我的维修"
//        view.backgroundColor = .bg
//        navigationController?.navBarStyle(.white)
//        setupUI()
//    }
//
//    // MARK: - Actions
//
//    func segmentedTapped(_ index: Int) {
//        if index == 0 { // 我的维修
//            title = "我的维修"
//            showMyRepair()
//        } else if index == 1 { // 我的处置
//            title = "我的处置"
//            showMyDisposal()
//        } else if index == 2 { // 维修报表
//            title = "维修报表"
//            showMaintenanceReport()
//        } else if index == 3 { // 更多服务
//            title = "更多服务"
//            showMore()
//        }
//    }
//
//    @objc func searchTapped() {
//        navigationController?.pushViewController(MyRepairInBranchVC(), animated: true)
//    }
//
//    @objc func menuTapped() {
//        let startPoint = CGPoint(x: ScreenWidth - 30, y: view.safeAreaInsets.top)
//        let popoverView = RepairPopoverView(frame: CGRect(x: 0, y: 0, width: 96, height: 80))
//        popoverView.firstBtn.addTarget(self, action: #selector(oneRepairTapped), for: .touchUpInside)
//        popoverView.lastBtn.addTarget(self, action: #selector(phoneCallTapped), for: .touchUpInside)
//        popover = Popover(options: options, showHandler: nil, dismissHandler: nil)
//        popover.layer.shadowOffset = CGSize(width: 0, height: 6)
//        popover.layer.shadowOpacity = 0.08
//        popover.layer.shadowColor = UIColor.black.cgColor
//        popover.show(popoverView, point: startPoint)
//    }
//
//    @objc private func oneRepairTapped() {
//        popover.dismiss()
//
//        navigationController?.pushViewController(OneClickRepairVC(), animated: true)
//    }
//
//    @objc private func phoneCallTapped() {
//        popover.dismiss()
//
//        navigationController?.pushViewController(PhoneCallRepairVC(), animated: true)
//    }
//
//    // MARK: - Setup
//
//    // 我的维修
//    func showMyRepair() {
//        contentV.removeAllSubViews()
//        navigationItem.rightBarButtonItems = [menuBar, searchBar]
//
//        contentV.addSubview(myRepairV)
//        myRepairV.snp.makeConstraints { (make) in
//            make.left.right.top.bottom.equalToSuperview()
//        }
//
//        myRepairV.reloadData()
//    }
//
//    // 我的处置
//    func showMyDisposal() {
//        contentV.removeAllSubViews()
//        navigationItem.rightBarButtonItems = [menuBar]
//
//        contentV.addSubview(toBeConfirmedV)
//        toBeConfirmedV.snp.makeConstraints { (make) in
//            make.left.right.top.bottom.equalToSuperview()
//        }
//
//        toBeConfirmedV.reloadData()
//    }
//
//    // 维修报表
//    func showMaintenanceReport() {
//        contentV.removeAllSubViews()
//        navigationItem.rightBarButtonItems = [menuBar]
//
//        contentV.addSubview(reportV)
//        reportV.snp.makeConstraints { (make) in
//            make.left.right.top.bottom.equalToSuperview()
//        }
//
//        reportV.reloadData()
//    }
//
//    // 更多服务
//    func showMore() {
//        contentV.removeAllSubViews()
//        navigationItem.rightBarButtonItems = [menuBar, scanBar]
//
//        contentV.addSubview(moreV)
//        moreV.snp.makeConstraints { (make) in
//            make.left.right.top.bottom.equalToSuperview()
//        }
//
//        moreV.reloadData()
//    }
//
//    func setupUI() {
//        bottomV.backgroundColor = .white
//        view.addSubview(bottomV)
//        bottomV.snp.makeConstraints { make in
//            make.left.right.bottom.equalToSuperview()
//            make.height.equalTo(56 + UIDevice.safeBottom())
//        }
//
//        let line = UIView()
//        line.backgroundColor = .hex("#F2F2F2")
//        bottomV.addSubview(line)
//        line.snp.makeConstraints { make in
//            make.top.left.right.equalToSuperview()
//            make.height.equalTo(0.5)
//        }
//
//        bottomV.addSubview(segmentedC)
//        segmentedC.snp.makeConstraints { make in
//            make.top.equalTo(bottomV.snp.top).offset(10)
//            make.left.equalTo(bottomV.snp.left).offset(22)
//            make.right.equalTo(bottomV.snp.right).offset(-22)
//            make.height.equalTo(36)
//        }
//        segmentedC.itemTitles = datas
//        segmentedC.currentSelectedIndex = 0
//        segmentedC.didSelectItemWith = { (index, title) -> () in
//            self.segmentedTapped(index)
//        }
//
//        view.addSubview(contentV)
//        contentV.snp.makeConstraints { (make) in
//            make.left.right.equalToSuperview()
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
//            make.bottom.equalTo(bottomV.snp.top)
//        }
//
//        showMyRepair()
//    }
//
//    lazy var menuBar: UIBarButtonItem = {
//        let btn = UIButton(type: .custom)
//        btn.setImage(UIImage(named: "ic_menu"), for: .normal)
//        btn.addTarget(self, action: #selector(menuTapped), for: .touchUpInside)
//        let bar = UIBarButtonItem(customView: btn)
//        return bar
//    }()
//
//    lazy var searchBar: UIBarButtonItem = {
//        let btn = UIButton(type: .custom)
//        btn.setImage(UIImage(named: "ic_search"), for: .normal)
//        btn.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
//        let bar = UIBarButtonItem(customView: btn)
//        return bar
//    }()
//
//    lazy var scanBar: UIBarButtonItem = {
//        let btn = UIButton(type: .custom)
//        btn.setImage(UIImage(named: "ic_scan"), for: .normal)
//        btn.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
//        let bar = UIBarButtonItem(customView: btn)
//        return bar
//    }()
//}
