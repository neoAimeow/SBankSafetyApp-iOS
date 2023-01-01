//
//  SecurityTaskListVC.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/28.
//  保安管理-任务列表页
//

import Foundation
import UIKit
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

class AppointmentTaskListViewModel {
    public let taskCompleteModel: PublishSubject<[TaskCompleteModel]> = PublishSubject();
    public let loading: PublishSubject<Bool> = PublishSubject()
    private let disposeBag = DisposeBag()

    public func requestTaskCompleteData(param: LzglBaseParam) {
        loading.onNext(false)
        API.taskCompleteView(withParam: param).subscribe { [self] model in
                    loading.onNext(true)
                    print(model)
                    if let taskCompleteUnWrap = model.models {
                        var arr: Array<TaskCompleteModel> = []
                        for item in taskCompleteUnWrap {
                            if let item {
                                arr.append(item)
                            }
                        }
                        taskCompleteModel.onNext(arr)
                    }
                }
                .disposed(by: disposeBag)
    }

}

class AppointmentTaskListVC: SubLevelViewController {
    // 页面入参
    var dateType: DateType.RawValue?
    var date: String?

    private let disposeBag = DisposeBag()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(TaskListCell.self, forCellReuseIdentifier: "SecurityTaskListCell")
        return tableView
    }()

    var models: [TaskCompleteModel] = []

    var viewModel = AppointmentTaskListViewModel()
    let user = BSUser.currentUser

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "任务列表"

        viewModel.taskCompleteModel
                .observe(on: MainScheduler.instance)
                .subscribe { [self] event in
                    if let element = event.element {
                        models = element
                        tableView.reloadData()
                        tableView.tableShowEmpty(withDataCount: models.count)
                    }
                }
                .disposed(by: disposeBag)

        viewModel.requestTaskCompleteData(param: LzglBaseParam(deptId: user.deptId, dateType: DateType.day.rawValue, date: Date().string(format: "yyyy-MM-dd")))

        setupUI()
    }

    // MARK: - Setup

    func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
}

extension AppointmentTaskListVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = models[indexPath.row]
        let cell = (tableView.dequeueReusableCell(withIdentifier: "SecurityTaskListCell", for: indexPath)) as! TaskListCell
        cell.buildModels(data: data)
        cell.selectionStyle = .none
        return cell
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        64.5
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = models[indexPath.row]

        let vc = TaskFinishProgressVC()
        vc.taskModel = data
        vc.deptId = deptId
        vc.deptName = deptName
        vc.date = date
        vc.dateType = dateType

        navigationController?.pushViewController(vc, animated: true)
    }
}
