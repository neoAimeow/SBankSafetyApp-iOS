//
//  InspHomeVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/22.
//
// 【首页-维保服务】巡检确认

import Foundation
import UIKit

class InspHomeVC: SubLevelViewController {
    let miantenanceV = InspMaintenanceView()
    
    var param: ParHomeParam = ParHomeParam()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "维保服务"
        view.backgroundColor = .bg
        navigationController?.navBarStyle(.white)
        
        if deptName == nil {
            deptName = BSUser.currentUser.deptName
            deptId = BSUser.currentUser.deptId
        }
                
        setupUI()
        
        miantenanceV.reload(withDeptId: deptId, deptName: deptName)
    }
    
    // MARK: - Setup

    func setupUI() {
        view.addSubview(miantenanceV)
        miantenanceV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

//class InspHomeVC: SubLevelViewController {
//    let datas = ["巡检确认", "新建巡检", "维保服务"]
//    var pageIndex = 2
//
//    let bottomV = UIView()
//    let segmentedC = BSSegmentedControl()
//
//    let contentV = UIView()
//
//    let confirmV = InspConfirmView()
//    let miantenanceV = InspMaintenanceView()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        title = "维保服务"
//        view.backgroundColor = .bg
//        navigationController?.navBarStyle(.white)
//
//        if deptName == nil {
//            deptName = BSUser.currentUser.deptName
//            deptId = BSUser.currentUser.deptId
//        }
//
////        param.deptid = deptId
////        param.dictLabel = wbtype
//
//        setupUI()
//    }
//
//    // MARK: - Actions
//
//    func segmentedTapped(_ index: Int) {
//        if index == 0 { // 巡检结果确认
//            title = "巡检结果确认"
//            showInspConfirm()
//        } else if index == 1 {
//            showInspNew()
//        } else if index == 2 { // 维保服务
//            title = "维保服务"
//            showMaintenance()
//        }
//    }
//
//    // MARK: - Setup
//
//    // 巡检结果确认
//    func showInspConfirm() {
//        pageIndex = 0
//        contentV.removeAllSubViews()
//
//        contentV.addSubview(confirmV)
//        confirmV.snp.makeConstraints { (make) in
//            make.left.right.top.bottom.equalToSuperview()
//        }
//
//        confirmV.reloadData()
//    }
//
//    // 新建巡检
//    func showInspNew() {
//        let bSearchVC = BranchSearchVC()
//        bSearchVC.didSelectBranchWith = { (dept) -> () in
//            let m = InspCreateModal()
//            m.dept = dept
//            bSearchVC.navigationController?.pushViewController(InspCreateTemplateVC(withModal: m), animated: true)
//        }
//        navigationController?.pushViewController(bSearchVC, animated: true)
//        segmentedC.currentSelectedIndex = pageIndex
//    }
//
//    // 维保服务
//    func showMaintenance() {
//        pageIndex = 2
//        contentV.removeAllSubViews()
//
//        contentV.addSubview(miantenanceV)
//        miantenanceV.snp.makeConstraints { (make) in
//            make.left.right.top.bottom.equalToSuperview()
//        }
//
//        miantenanceV.reloadData()
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
//        segmentedC.currentSelectedIndex = pageIndex
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
//        showMaintenance()
//    }
//}
