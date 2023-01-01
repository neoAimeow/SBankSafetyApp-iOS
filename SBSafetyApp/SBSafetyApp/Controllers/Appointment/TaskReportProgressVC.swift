//
//  TaskReportProgressVC.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/28.
// 【首页-履职管理】巡检报告-分行营业部（月、季、年）

import Foundation
import UIKit

class TaskReportProgressVC: SubLevelViewController {
    
    lazy var statusPanel: TaskStatusPanel = {
        let panel = TaskStatusPanel()
        return panel
    }()
    
    lazy var leftButtonTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .hex("#FFFFFF")
        label.text = "每日任务 89.5%"
        return label
    }()
    
    lazy var rightButtonTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .hex("#333333")
        label.text = "每月任务 0.0%"

        return label
    }()
    
    
    lazy var leftButton: UIView = {
        let imageView = UIImageView(image: UIImage.init(named: "bg_task_title"))
        let view = UIView()
        view.addSubview(imageView)
        imageView.addSubview(leftButtonTitle)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        leftButtonTitle.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
        return view
    }()
    
    lazy var rightButton: UIView = {
        let imageView = UIImageView(image: UIImage.init(named: "bg_task_title_white"))
        let view = UIView()
        view.addSubview(imageView)
        imageView.addSubview(rightButtonTitle)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        rightButtonTitle.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
        
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.masksToBounds = true
        tableView.layer.cornerRadius = 10
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.register(TaskProcessCell.self, forCellReuseIdentifier: "TaskProcessCell")
        return tableView
    }()
    
    var fakeData: [TaskProcessModal] = [
        TaskProcessModal(id: 0, title: "检查数码监控录像情况记录薄", dateStr: "06:00~22:00", processValue: "80%"),
        TaskProcessModal(id: 0, title: "检查数码监控录像情况记录薄", dateStr: "06:00~22:00", processValue: "80%"),
        TaskProcessModal(id: 0, title: "检查数码监控录像情况记录薄", dateStr: "06:00~22:00", processValue: "80%"),
        TaskProcessModal(id: 0, title: "检查数码监控录像情况记录薄", dateStr: "06:00~22:00", processValue: "80%"),
        TaskProcessModal(id: 0, title: "检查数码监控录像情况记录薄", dateStr: "06:00~22:00", processValue: "80%"),
        TaskProcessModal(id: 0, title: "检查数码监控录像情况记录薄", dateStr: "06:00~22:00", processValue: "80%"),
        TaskProcessModal(id: 0, title: "检查数码监控录像情况记录薄", dateStr: "06:00~22:00", processValue: "80%"),
        TaskProcessModal(id: 0, title: "检查数码监控录像情况记录薄", dateStr: "06:00~22:00", processValue: "80%"),
        TaskProcessModal(id: 0, title: "检查数码监控录像情况记录薄", dateStr: "06:00~22:00", processValue: "80%"),
        TaskProcessModal(id: 0, title: "检查数码监控录像情况记录薄", dateStr: "06:00~22:00", processValue: "80%"),
        TaskProcessModal(id: 0, title: "检查数码监控录像情况记录薄", dateStr: "06:00~22:00", processValue: "80%"),
        TaskProcessModal(id: 0, title: "检查数码监控录像情况记录薄", dateStr: "06:00~22:00", processValue: "80%"),
        TaskProcessModal(id: 0, title: "检查数码监控录像情况记录薄", dateStr: "06:00~22:00", processValue: "80%"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        title = "杭州分行营业部"
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func setupUI() {
        view.addSubview(statusPanel)
        
        view.addSubview(leftButton)
        view.addSubview(rightButton)
        
        view.addSubview(tableView)
        
        statusPanel.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        leftButton.snp.makeConstraints { make in
            make.left.equalTo(view).offset(10)
            make.top.equalTo(statusPanel.snp.bottom).offset(10)
            make.height.equalTo(45)
            make.right.equalTo(rightButton.snp.left).offset(15);
        }
        
        rightButton.snp.makeConstraints { make in
            make.right.equalTo(view).offset(-10)
            make.top.equalTo(statusPanel.snp.bottom).offset(10)
            make.height.equalTo(45)
            make.left.equalTo(leftButton.snp.right).offset(-15)
            make.width.equalTo(leftButton)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(leftButton.snp.bottom).offset(10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.bottom.equalTo(view).offset(-20)
        }
    }
    
}

extension TaskReportProgressVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fakeData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = fakeData[indexPath.row]
        let cell = (tableView.dequeueReusableCell(withIdentifier: "TaskProcessCell", for: indexPath))as! TaskProcessCell
        cell.buildData(data: data)
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        tableView.setCornerRadiusSection(willDisplay: cell, forRowAt: indexPath)
    }

}
