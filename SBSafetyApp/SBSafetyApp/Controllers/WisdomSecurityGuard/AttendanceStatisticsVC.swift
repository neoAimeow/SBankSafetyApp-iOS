//
//  AttendanceStatisticsVC.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/23.
// 考勤统计

import Foundation
import UIKit

class AttendanceStatisticsVC: SubLevelViewController {
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var calendarView: BSCalendarView = {
        let view = BSCalendarView()
        
        return view
    }()
    
    lazy var checkListView: CheckInListView = {
        let view = CheckInListView()
        return view
    }()
  
    var fakeData: [CheckInListModel] = [
        CheckInListModel(timeStr: "14:25", checkInStateStr: "签到", address: "上海市浦东新区东书房路629弄3号", subBranchStr: "上海银行总行"),
        CheckInListModel(timeStr: "14:25", checkInStateStr: "签到", address: "上海市浦东新区东书房路629弄3号", subBranchStr: "上海银行总行"),
        CheckInListModel(timeStr: "14:25", checkInStateStr: "签退", address: "上海市浦东新区东书房路629弄3号", subBranchStr: "上海银行总行"),
        CheckInListModel(timeStr: "14:25", checkInStateStr: "签到", address: "上海市浦东新区东书房路629弄3号", subBranchStr: "上海银行总行"),
        CheckInListModel(timeStr: "14:25", checkInStateStr: "签退", address: "上海市浦东新区东书房路629弄4号", subBranchStr: "上海银行总行"),
        CheckInListModel(timeStr: "14:25", checkInStateStr: "签到", address: "上海市浦东新区东书房路629弄3号", subBranchStr: "上海银行总行"),
        CheckInListModel(timeStr: "14:25", checkInStateStr: "签到", address: "上海市浦东新区东书房路629弄3号", subBranchStr: "上海银行总行"),
        CheckInListModel(timeStr: "14:25", checkInStateStr: "签到", address: "上海市浦东新区东书房路629弄6号", subBranchStr: "上海银行总行"),
        CheckInListModel(timeStr: "14:25", checkInStateStr: "签到", address: "上海市浦东新区东书房路629弄8号", subBranchStr: "上海银行总行"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "考勤统计"
        setupUI()
        checkListView.buildData(models: fakeData)
    }
    
    func setupUI() {
        self.view.backgroundColor = UIColor.hex("#F8F8F8")
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(calendarView)
        contentView.addSubview(checkListView)
        
        scrollView.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(ScreenWidth)
        }
        
        calendarView.snp.makeConstraints { make in
            make.left.top.right.equalTo(contentView)
        }
        
        checkListView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.top.equalTo(calendarView.snp.bottom)
            make.bottom.equalTo(contentView.snp.bottom)
        }
   
    }
}

