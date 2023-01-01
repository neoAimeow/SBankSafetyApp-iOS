//
// Created by Aimeow on 2022/12/1.
//

import Foundation
import UIKit

class SecurityStatisticsVC: SubLevelViewController {

    lazy var situationPanel: CheckSituationPanel = {
        let view = CheckSituationPanel()
        return view
    }()

    lazy var statusView: TaskOutletStatusView = {
        let view = TaskOutletStatusView()
        return view
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(TaskListCell.self, forCellReuseIdentifier: "TaskListCellIdentifier")
        return tableView
    }()

    var fakeData: [TaskListModal] = [
        TaskListModal(id: 0, title: "大厅巡检", dateStr: "2022-09-26 08:55~09:55", state: TaskStateEnum.UnFinished, stateCount: -1),
        TaskListModal(id: 1, title: "大厅巡检1", dateStr: "2022-09-26 08:55~09:55", state: TaskStateEnum.Finished, stateCount: -1),
        TaskListModal(id: 2, title: "大厅巡检2", dateStr: "2022-09-26 08:55~09:55", state: TaskStateEnum.UnFinished, stateCount: -1),
        TaskListModal(id: 3, title: "大厅巡检3", dateStr: "2022-09-26 08:55~09:55", state: TaskStateEnum.UnFinished, stateCount: -1),
        TaskListModal(id: 4, title: "大厅巡检4", dateStr: "2022-09-26 08:55~09:55", state: TaskStateEnum.Finished, stateCount: -1),
        TaskListModal(id: 5, title: "大厅巡检5", dateStr: "2022-09-26 08:55~09:55", state: TaskStateEnum.UnFinished, stateCount: -1),
        TaskListModal(id: 6, title: "大厅巡检6", dateStr: "2022-09-26 08:55~09:55", state: TaskStateEnum.Finished, stateCount: -1),
        TaskListModal(id: 7, title: "大厅巡检7", dateStr: "2022-09-26 08:55~09:55", state: TaskStateEnum.UnFinished, stateCount: -1),
        TaskListModal(id: 8, title: "大厅巡检8", dateStr: "2022-09-26 08:55~09:55", state: TaskStateEnum.Finished, stateCount: -1),
        TaskListModal(id: 9, title: "大厅巡检9", dateStr: "2022-09-26 08:55~09:55", state: TaskStateEnum.Finished, stateCount: -1),
        TaskListModal(id: 10, title: "大厅巡检10", dateStr: "2022-09-26 08:55~09:55", state: TaskStateEnum.Finished, stateCount: -1),
        TaskListModal(id: 11, title: "大厅巡检11", dateStr: "2022-09-26 08:55~09:55", state: TaskStateEnum.Finished, stateCount: -1),
        TaskListModal(id: 12, title: "大厅巡检12", dateStr: "2022-09-26 08:55~09:55", state: TaskStateEnum.Finished, stateCount: -1),
        TaskListModal(id: 13, title: "大厅巡检13", dateStr: "2022-09-26 08:55~09:55", state: TaskStateEnum.UnFinished, stateCount: -1),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "保安统计情况"
        setupUI()
    }

    // MARK: - Setup

    func setupUI() {

        view.addSubview(situationPanel)
        view.addSubview(statusView)
        view.addSubview(tableView)

        situationPanel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
        }

        statusView.snp.makeConstraints { make in
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.top.equalTo(situationPanel.snp.bottom).offset(20)
        }

        tableView.snp.makeConstraints { make in
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.top.equalTo(statusView.snp.bottom).offset(10)
        }
    }
}

extension SecurityStatisticsVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fakeData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = fakeData[indexPath.row]
        let cell = (tableView.dequeueReusableCell(withIdentifier: "TaskListCellIdentifier", for: indexPath)) as! TaskListCell
        cell.selectionStyle = .none
        cell.buildData(data: data)
        return cell
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.setCornerRadiusSection(willDisplay: cell, forRowAt: indexPath)
    }
}

