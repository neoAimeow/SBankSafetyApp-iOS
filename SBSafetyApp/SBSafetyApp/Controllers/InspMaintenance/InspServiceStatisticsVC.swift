//
//  InspServiceStatisticsVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/11.
//
// 【首页-维保服务】总统计

import Foundation
import UIKit

class InspServiceStatisticsVC: SubLevelViewController {
    let sticsV = InspServiceStatisticsView()

    var param = WbListParam(date: Date.todayDate(), dateType: CustomDateEnum.daily.rawValue)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "上海银行"
        view.backgroundColor = .bg
        setupUI()
        
        reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navBarStyle(.white)
    }
    
    func reloadData() {
        API.getWbListCountListFirst(withParam: param) { responseModel in
            DispatchQueue.main.async {
                self.sticsV.reload(witModal: responseModel.model)
            }
        }
    }
    
    // MARK: - Actions
        
    // MARK: - Setup
    
    func setupUI() {
        sticsV.dateV.delegate = self
        view.addSubview(sticsV)
        sticsV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension InspServiceStatisticsVC: BSCustomDateViewDelegate {
    func didSelected(year: Int, quarter: Int?, month: Int?, day: Int?, dateEnum: CustomDateEnum) {
        param.dateType = dateEnum.rawValue
        param.date = "\(year)-\(month!)-\(day!)"
        
        reloadData()
    }
}
