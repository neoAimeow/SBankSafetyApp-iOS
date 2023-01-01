////
////  AppointmentStatisticsVC.swift
////  SBSafetyApp
////
////  Created by Lina on 2022/12/7.
////
//// 【首页-履职管理】履职管理- 总行/分行/支行-查看详情
//
//import Foundation
//import UIKit
//
//class AppointmentStatisticsVC: SubLevelViewController {
//    let sticsV = BSStatisticsView()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .bg
//        navigationController?.navBarStyle(.white)
//        setupUI()
//        
//        reloadData()
//        
//        title = deptName
//    }
//    
//    func reloadData() {
//        if deptName == nil {
//            deptName = BSUser.currentUser.deptName
//            deptId = BSUser.currentUser.deptId
//        }
//        
//        let deptItems = [
//            TaskRateModal(zwcl: "22", week: "星期二", date: "11/30"),
//            TaskRateModal(zwcl: "71", week: "星期三", date: "12/01"),
//            TaskRateModal(zwcl: "10", week: "星期四", date: "12/02"),
//            TaskRateModal(zwcl: "98", week: "星期五", date: "12/03"),
//            TaskRateModal(zwcl: "83", week: "星期六", date: "12/04"),
//            TaskRateModal(zwcl: "85", week: "星期日", date: "12/05"),
//            TaskRateModal(zwcl: "54", week: "星期一", date: "12/06"),
//        ]
//        
//        let rateItems = [
//            TaskDeptRateModal(zwcl: "85", wdmc: "营业部1", wxds: 2),
//            TaskDeptRateModal(zwcl: "21", wdmc: "营业部2", wxds: 4),
//            TaskDeptRateModal(zwcl: "10", wdmc: "营业部3", wxds: 3),
//            TaskDeptRateModal(zwcl: "78", wdmc: "营业部4", wxds: 44),
//            TaskDeptRateModal(zwcl: "53", wdmc: "营业部5", wxds: 5),
//            TaskDeptRateModal(zwcl: "95", wdmc: "营业部6", wxds: 6),
//            TaskDeptRateModal(zwcl: "34", wdmc: "营业部7", wxds: 7),
//            TaskDeptRateModal(zwcl: "4", wdmc: "营业部8", wxds: 8),
//            TaskDeptRateModal(zwcl: "78", wdmc: "营业部9", wxds: 2),
//        ]
////        sticsV.reloadData(deptName: deptName ?? "", zwcl: "10", deptItems: rateItems, rateItems: deptItems)
//    }
//    
//    func setupUI() {
//        sticsV.baseTV.title = "履职管理"
//        sticsV.sDelegate = self
//        sticsV.deptBtn.delegate = self
//        sticsV.customV.delegate = self
//        view.addSubview(sticsV)
//        sticsV.snp.makeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
//            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
//        }
//    }
//}
//
//extension AppointmentStatisticsVC: BSStatisticsViewDelegate {
//    func handleDeptSelected(_ dept: TaskDeptRateModal) {
//        print("BSStatisticsViewDelegate dept", dept.wdmc as Any)
//        // 跳转到子AppointmentStatisticsVC
//        let subVC = AppointmentStatisticsVC(withDeptId: dept.wddm, deptName: dept.wdmc)
//        navigationController?.pushViewController(subVC, animated: true)
//    }
//}
//
//extension AppointmentStatisticsVC: BSDeptStiscControlDelegate{
//    func handleSelected(_ dept: TaskDeptRateModal?) {
//        let subVC = AppointmentStatisticsVC(withDeptId: dept?.wddm, deptName: dept?.wdmc)
//        navigationController?.pushViewController(subVC, animated: true)
//    }
//}
//
//extension AppointmentStatisticsVC: BSCustomDateViewDelegate {
//    func didSelected(year: Int, quarter: Int?, month: Int?, day: Int?, dateEnum: CustomDateEnum) {
//        print("BSCustomDateViewDelegate", year, month, day, dateEnum, dateEnum.rawValue)
//    }
//}
