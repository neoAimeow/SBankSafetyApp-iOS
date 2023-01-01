//
//  TaskHomeVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/18.
//
// 【首页-履职管理】任务

import Foundation
import UIKit

class TaskHomeVC: SubLevelViewController {
    let datas = ["任务", "巡检报告", "营业日历表"]
    let bottomV = UIView()
    let segmentedC = BSSegmentedControl()

    let contentV = UIView()

    let tHomeV = TaskHomeView()
    let reportV = TaskCheckReportView()
    let scheduleV = BusinessScheduleTbView()

    override func viewDidLoad() {
        super.viewDidLoad()
        tHomeV.deptId = deptId
        tHomeV.deptName = deptName
        reportV.deptId = deptId
        reportV.deptName = deptName
        scheduleV.deptId = deptId
        scheduleV.deptName = deptName

        // Do any additional setup after loading the view.
        title = "上海银行"
        view.backgroundColor = .bg
        navigationController?.navBarStyle(.white)

        tHomeV.requestData()
        reportV.requestData()
        scheduleV.requestData()

        setupUI()
    }

    // MARK: - Actions

    func segmentedTapped(_ index: Int) {

        let role = UserDefaults.standard.string(forKey: SafetyUserRole)
        if (role == UserRole.Lattice.rawValue) {
            if index == 0 { // 任务
                showTask()
            } else if index == 1 { // 营业日历表
                showCalendar()
            }
        } else {
            if index == 0 { // 任务
                showTask()
            } else if index == 1 { // 巡检报告
                showReport()
            } else if index == 2 { // 营业日历表
                showCalendar()
            }
        }


    }

    // MARK: - Setup

    // 任务
    func showTask() {
        contentV.removeAllSubViews()

        contentV.addSubview(tHomeV)
        tHomeV.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }

    // 巡检报告

    func showReport() {
        contentV.removeAllSubViews()
        contentV.addSubview(reportV)
        reportV.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }

    // 营业日历表

    func showCalendar() {
        contentV.removeAllSubViews()
        contentV.addSubview(scheduleV)
        scheduleV.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
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


        let role = UserDefaults.standard.string(forKey: SafetyUserRole)
        if (role == UserRole.Lattice.rawValue) {
            segmentedC.itemTitles = ["任务", "营业日历表"]
        } else {
            segmentedC.itemTitles = ["任务", "巡检报告", "营业日历表"]
        }

        segmentedC.itemTitles = ["任务", "巡检报告", "营业日历表"]
        segmentedC.didSelectItemWith = { (index, title) -> () in
            print("Selected item \(index)")
            self.segmentedTapped(index)
        }

        view.addSubview(contentV)
        contentV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(bottomV.snp.top)
        }

        showTask()
    }
}
