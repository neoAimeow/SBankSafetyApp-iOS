//
//  InspStatisticsVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/11.
//
// 【首页-维保服务】总行看数据

import Foundation
import UIKit

class InspStatisticsVC: SubLevelViewController {
    let sticsV = BSStatisticsView()
    
    let param: WbListParam = WbListParam()
    
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
        param.wbtype = wbtype

        fetchData()
    }
    
    func fetchData() {
        /// 根据部门查询完成率
        view.showToastActivity()
        API.getWbListCountList(withParam: param) { responseModel in
            DispatchQueue.main.async {
                self.sticsV.reloadData(deptName: self.deptName, modal: responseModel.model, hasWxds: false)
                self.view.hideToastActivity()
            }
        }
    }
    
    func setupUI() {
        sticsV.baseTV.title = "维保服务"
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

extension InspStatisticsVC: BSStatisticsViewDelegate {
    func handleDeptSelected(_ dept: TaskDeptRateModal) {
        // 跳转到子InspStatisticsVC
        if dept.sfczzj == true {
            let subVC = InspStatisticsVC(withDeptId: dept.wddm, deptName: dept.wdmc, wbtype: wbtype)
            navigationController?.pushViewController(subVC, animated: true)
        } else {
            let vc = InspListVC(withDeptId: dept.wddm, deptName: dept.wdmc, wbtype: wbtype)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension InspStatisticsVC: BSDeptStiscControlDelegate {
    func handleSelected(_ dept: TaskDeptRateModal?) {
        let vc = InspStatisticsVC(withDeptId: dept?.wddm, deptName: dept?.wdmc, wbtype: wbtype)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension InspStatisticsVC: BSCustomDateViewDelegate {
    func didSelected(year: Int, quarter: Int?, month: Int?, day: Int?, dateEnum: CustomDateEnum) {
        print("BSCustomDateViewDelegate", year, month!, day!, dateEnum, dateEnum.rawValue)
        
        param.dateType = dateEnum.rawValue
        param.date = "\(year)-\(month!)-\(day!)"
        
        fetchData()
    }
}

