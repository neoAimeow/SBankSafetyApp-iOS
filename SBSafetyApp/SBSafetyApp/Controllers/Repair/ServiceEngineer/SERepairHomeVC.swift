//
//  SERepairHomeVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/29.
//
// 【首页-一键报修-维修工程师】维修工程师-任务大厅

import Foundation
import UIKit
import Popover

class SERepairHomeVC: SubLevelViewController {
    let datas = ["任务大厅", "我的维修单"]

    let bottomV = UIView()
    let segmentedC = BSSegmentedControl()

    let contentV = UIView()

    let taskHallV = SETaskHallView()
    let RepairV = SEMyRepairView()
    
    fileprivate var options: [PopoverOption] = [
        .type(.auto), .showBlackOverlay(false), .cornerRadius(6), .color(.white), .arrowSize(CGSize(width: 10, height: 5))
    ]
    fileprivate var popover: Popover!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "任务大厅"
        view.backgroundColor = .bg
        navigationController?.navBarStyle(.white)
        setupUI()
    }
    
    // MARK: - Actions
    
    func segmentedTapped(_ index: Int) {
        if index == 0 { // 任务大厅
            title = "任务大厅"
            showTaskHall()
        } else if index == 1 { // 我的维修单
            title = "我的维修单"
            showMyDisposal()
        }
    }
      
    // MARK: - Setup
        
    // 任务大厅
    func showTaskHall() {
        contentV.removeAllSubViews()

        contentV.addSubview(taskHallV)
        taskHallV.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        taskHallV.reloadData()
    }
    
    // 我的维修单
    func showMyDisposal() {
        contentV.removeAllSubViews()

        contentV.addSubview(RepairV)
        RepairV.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }

        RepairV.reloadData()
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
        
        showTaskHall()
    }
}
