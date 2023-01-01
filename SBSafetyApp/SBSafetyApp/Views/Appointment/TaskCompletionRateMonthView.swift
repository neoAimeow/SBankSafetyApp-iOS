//
//  TaskCompletionRateMonthView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/24.
//

import Foundation
import UIKit

class TaskCompletionRateMonthView: UIScrollView {
    let calendarView = BSCalendarView()
    let taskV = TaskCompletionRateView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .bg
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI() {
        let datas = [
            TaskRateModal(zwcl: "87", week: "星期二", date: "11/30"),
            TaskRateModal(zwcl: "21", week: "星期三", date: "12/01"),
            TaskRateModal(zwcl: "1", week: "星期四", date: "12/02"),
            TaskRateModal(zwcl: "98", week: "星期五", date: "12/03"),
            TaskRateModal(zwcl: "53", week: "星期六", date: "12/04"),
            TaskRateModal(zwcl: "89", week: "星期日", date: "12/05"),
            TaskRateModal(zwcl: "34", week: "星期一", date: "12/06"),
        ]
        taskV.reloadData(datas)
    }
    
    func setupUI() {
        calendarView.calendarView.isScrollEnabled = false
        calendarView.style = .Style2
        addSubview(calendarView)
        calendarView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth)
            make.height.equalTo(324)
        }
        calendarView.titleStackView.isHidden = true
        calendarView.titleStackView.snp.updateConstraints { make in
            make.height.equalTo(0)
        }
        
        let tipsL = UILabel()
        tipsL.text = "注：日期下百分比为当天的任务完成率"
        tipsL.font = .systemFont(ofSize: 14)
        tipsL.textColor = .hex("#969696")
        addSubview(tipsL)
        tipsL.snp.makeConstraints { make in
            make.top.equalTo(calendarView.snp.bottom).offset(-20)
            make.centerX.equalToSuperview()
        }
        
        taskV.title = "过去6个月任务完成率"
        addSubview(taskV)
        taskV.snp.makeConstraints { make in
            make.top.equalTo(tipsL.snp.bottom).offset(22)
            make.centerX.equalToSuperview()
            make.height.equalTo(322)
            make.width.equalTo(ScreenWidth - 20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}
