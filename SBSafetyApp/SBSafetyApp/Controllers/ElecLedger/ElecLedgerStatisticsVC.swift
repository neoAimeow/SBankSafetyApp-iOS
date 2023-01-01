//
//  ElecLedgerStatisticsVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/11.
//
// 【首页-电子台账】总行看数据

import Foundation
import UIKit

class ElecLedgerStatisticsVC: SubLevelViewController {
    let sticsV = ElecStatisticsView()
    
    let param: StandingBookStaticParam = StandingBookStaticParam(tzlx: "")
    
    var date: String = Date.todayDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        navigationController?.navBarStyle(.white)
        setupUI()
        
        reloadData()
        fetchTypeData()
        
        title = deptName
    }
    
    func reloadData() {
        if deptName == nil {
            deptName = BSUser.currentUser.deptName
            deptId = BSUser.currentUser.deptId
        }
        sticsV.reloadData(deptName: deptName)
        param.deptId = deptId
        param.dateType = CustomDateEnum.daily.rawValue
        param.date = date
        
        fetchData()
    }
    
    func fetchData() {
        /// 根据部门查询电子台账完成率
        view.showToastActivity()
        API.getDztzScaleByDept(withParam: param) { responseModel in
            DispatchQueue.main.async {
                self.sticsV.reloadData(modal: responseModel.model)
                self.view.hideToastActivity()
            }
        }
    }
    
    func fetchTypeData() {
        /// 获取台账类型
        API.getStandingBookTypelist { responseModel in
            DispatchQueue.main.async {
                self.sticsV.typeDatas = responseModel.models ?? []
            }
        }
    }
    
    func setupUI() {
        sticsV.baseTV.title = "电子台账"
        sticsV.sDelegate = self
        sticsV.deptBtn.delegate = self
        sticsV.customV.delegate = self
        sticsV.statusCtl.didSelectItemWith = { (index, modal) -> () in
            self.sticsV.statusCtl.key = modal.name
            self.param.tzlx = modal.id
            self.fetchData()
        }
        view.addSubview(sticsV)
        sticsV.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension ElecLedgerStatisticsVC: BSStatisticsViewDelegate {
    func handleDeptSelected(_ dept: TaskDeptRateModal) {
        if dept.sfczzj == true {
            let subVC = ElecLedgerStatisticsVC(withDeptId: dept.wddm, deptName: dept.wdmc)
            navigationController?.pushViewController(subVC, animated: true)
        } else {
            let vc = ElecLedgerHeadHomeVC(withDeptId: dept.wddm, deptName: dept.wdmc)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ElecLedgerStatisticsVC: BSDeptStiscControlDelegate {
    func handleSelected(_ dept: TaskDeptRateModal?) {
        let vc = ElecLedgerStatisticsVC(withDeptId: dept?.wddm, deptName: dept?.wdmc)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ElecLedgerStatisticsVC: BSCustomDateViewDelegate {
    func didSelected(year: Int, quarter: Int?, month: Int?, day: Int?, dateEnum: CustomDateEnum) {
        param.dateType = dateEnum.rawValue
        param.date = "\(year)-\(month!)-\(day!)"
        fetchData()
    }
}

