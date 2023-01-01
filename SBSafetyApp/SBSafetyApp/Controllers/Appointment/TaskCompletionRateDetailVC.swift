//
//  TaskCompletionRateDetailVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/29.
//
// 【首页-履职管理】巡检报告-任务完成率详情

import Foundation
import UIKit

class TaskCompletionRateDetailVC: SubLevelViewController {
    
    let taskV = TaskCompletionRateDetailView()

    lazy var calendarView: BSCalendarView = {
        let view = BSCalendarView()
        view.calendarView.isScrollEnabled = false
        view.style = .Style4
        
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()

    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "2022年9月"
        view.backgroundColor = .bg
        setupUI()
    }
        
    // MARK: - Setup
    
    func setupUI() {
        view.backgroundColor = .bg
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
  
        contentView.addSubview(calendarView)
        
        let remindV = TaskCRRemindView()
        contentView.addSubview(remindV)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.bottom.equalTo(view)
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(ScreenWidth)
        }

        
        calendarView.snp.makeConstraints { make in
            make.top.centerX.equalTo(contentView)
            make.width.equalTo(ScreenWidth)
            make.height.equalTo(324)
        }
        
        calendarView.titleStackView.isHidden = true
        calendarView.titleStackView.snp.updateConstraints { make in
            make.height.equalTo(0)
        }
        
        remindV.snp.makeConstraints { make in
            make.top.equalTo(calendarView.snp.bottom).offset(-20)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
        }
        
    }
}
