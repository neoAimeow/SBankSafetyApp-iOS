//
//  SecurityTaskListVC.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/16.
//  保安管理-任务列表页

import Foundation
import UIKit

class SecurityTaskListVC: SubLevelViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(TaskListCell.self, forCellReuseIdentifier: "SecurityTaskListCell")
        return tableView
    }()
    
    var fakeData: [TaskListModal] = [
        TaskListModal(id: 0, title: "大厅巡检",  dateStr: "2022-09-26 08:55~09:55", state: TaskStateEnum.UnFinished, stateCount: -1),
        TaskListModal(id: 1, title: "大厅巡检1",  dateStr: "2022-09-26 08:55~09:55", state: TaskStateEnum.Finished, stateCount: -1),
        TaskListModal(id: 2, title: "大厅巡检2",  dateStr: "2022-09-26 08:55~09:55", state: TaskStateEnum.UnFinished, stateCount: -1),
        TaskListModal(id: 3, title: "大厅巡检3",  dateStr: "2022-09-26 08:55~09:55", state: TaskStateEnum.UnFinished, stateCount: -1),
        TaskListModal(id: 4, title: "大厅巡检4",  dateStr: "2022-09-26 08:55~09:55", state: TaskStateEnum.Finished, stateCount: -1),
        TaskListModal(id: 5, title: "大厅巡检5",  dateStr: "2022-09-26 08:55~09:55", state: TaskStateEnum.UnFinished, stateCount: -1),
        TaskListModal(id: 6, title: "大厅巡检6",  dateStr: "2022-09-26 08:55~09:55", state: TaskStateEnum.Finished, stateCount: -1),
        TaskListModal(id: 7, title: "大厅巡检7",  dateStr: "2022-09-26 08:55~09:55", state: TaskStateEnum.UnFinished, stateCount: -1),
        TaskListModal(id: 8, title: "大厅巡检8",  dateStr: "2022-09-26 08:55~09:55", state: TaskStateEnum.Finished, stateCount: -1),
        TaskListModal(id: 9, title: "大厅巡检9",  dateStr: "2022-09-26 08:55~09:55", state: TaskStateEnum.Finished, stateCount: -1),
        TaskListModal(id: 10, title: "大厅巡检10",  dateStr: "2022-09-26 08:55~09:55", state: TaskStateEnum.Finished, stateCount: -1),
        TaskListModal(id: 11, title: "大厅巡检11",  dateStr: "2022-09-26 08:55~09:55", state: TaskStateEnum.Finished, stateCount: -1),
        TaskListModal(id: 12, title: "大厅巡检12",  dateStr: "2022-09-26 08:55~09:55", state: TaskStateEnum.Finished, stateCount: -1),
        TaskListModal(id: 13, title: "大厅巡检13",  dateStr: "2022-09-26 08:55~09:55", state: TaskStateEnum.UnFinished, stateCount: -1),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "任务列表"
        setupUI()
    }

    // MARK: - Setup
    
    func setupUI() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
    }
}

extension SecurityTaskListVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fakeData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = fakeData[indexPath.row]
        let cell = (tableView.dequeueReusableCell(withIdentifier: "SecurityTaskListCell", for: indexPath))as! TaskListCell
        cell.buildData(data: data)
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.5
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
