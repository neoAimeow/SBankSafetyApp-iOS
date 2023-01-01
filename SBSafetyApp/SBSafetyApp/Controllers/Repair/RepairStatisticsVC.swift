//
//  RepairStatisticsVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/7.
//
// 【首页-一键报修】总行看数据

import Foundation
import UIKit

class RepairStatisticsVC: SubLevelViewController {
    let sticsV = BSStatisticsView()
    
    let param: YjwxParam = YjwxParam()
    
    var date: String = Date.todayDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        navigationController?.navBarStyle(.white)
        setupUI()
        
        reloadData()
        
        title = deptName
    }
    
    func reloadData() {
        if deptName == nil {
            deptName = BSUser.currentUser.deptName
            deptId = BSUser.currentUser.deptId
        }
        
        param.deptId = deptId
        param.dateType = CustomDateEnum.daily.rawValue
        param.date = date

        sticsV.reloadData(deptName: deptName ?? "")
        
        fetchData()
    }
    
    func fetchData() {
        /// 根据部门查询完成率
        view.showToastActivity()
        API.getYjwxSelectScaleByDept(withParam: param) { responseModel in
            print("getYjwxSelectScaleByDept", responseModel.resultData as Any)
            
            DispatchQueue.main.async {
                self.sticsV.reloadData(modal: responseModel.model, hasWxds: true)
                self.view.hideToastActivity()
            }
        }
    }
    
    func setupUI() {
        sticsV.baseTV.title = "一键报修"
        sticsV.sDelegate = self
        sticsV.deptBtn.delegate = self
        sticsV.customV.delegate = self
        view.addSubview(sticsV)
        sticsV.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension RepairStatisticsVC: BSStatisticsViewDelegate {
    func handleDeptSelected(_ dept: TaskDeptRateModal) {
        // 跳转到子RepairStatisticsVC
        if dept.sfczzj == true {
            let subVC = RepairStatisticsVC(withDeptId: dept.wddm, deptName: dept.wdmc)
            navigationController?.pushViewController(subVC, animated: true)
        } else {
            let vc = RepairHomeVC(withDeptId: dept.wddm, deptName: dept.wdmc)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension RepairStatisticsVC: BSDeptStiscControlDelegate {
    func handleSelected(_ dept: TaskDeptRateModal?) {
        let vc = RepairStatisticsVC(withDeptId: dept?.wddm, deptName: dept?.wdmc)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension RepairStatisticsVC: BSCustomDateViewDelegate {
    func didSelected(year: Int, quarter: Int?, month: Int?, day: Int?, dateEnum: CustomDateEnum) {
        print("BSCustomDateViewDelegate", year, month!, day!, dateEnum, dateEnum.rawValue)
        
        param.dateType = dateEnum.rawValue
        param.date = "\(year)-\(month!)-\(day!)"
        
        fetchData()
    }
}

