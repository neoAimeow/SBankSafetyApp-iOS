//
//  TaskFinishStateVC.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/24.
// 任务完成情况

import Foundation
import UIKit
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

class TaskFinishStateViewModel {
    public let deptWclModel: PublishSubject<TaskDeptRateModal> = PublishSubject();
    public let dailyTaskModel: PublishSubject<[WdwcqkPercentModel]> = PublishSubject();
    public let monthTaskModel: PublishSubject<[WdwcqkPercentModel]> = PublishSubject();
    public let loading: PublishSubject<Bool> = PublishSubject()
    private let disposeBag = DisposeBag()

    public func requestData(deptId: Int64, dateType: DateType.RawValue, date: String, rwzq: Int?) {
        loading.onNext(false)
        Observable.zip(
                        API.selectLzglWcl(withParam: LzglBaseParam(deptId: deptId, dateType: dateType, date: date)),
                        API.wdwcqk(withParam: WdwcqkParam(deptId: deptId, dateType: dateType, date: date, rwzq: rwzq)))
                .subscribe(onNext: { [self] (deptWcl, taskComplete) in
                    loading.onNext(true)

                    if let deptWclUnWrap = deptWcl.model {
                        deptWclModel.onNext(deptWclUnWrap)
                    }

                    if rwzq != nil {
                        if let taskCompleteUnWrap = taskComplete.models {
                            print(taskCompleteUnWrap)
                            var arr: Array<WdwcqkPercentModel> = []
                            for item in taskCompleteUnWrap {
                                if let item {
                                    arr.append(item)
                                }
                            }
                            monthTaskModel.onNext(arr)
                        }
                    } else {
                        if let taskCompleteUnWrap = taskComplete.models {
                            var arr: Array<WdwcqkPercentModel> = []
                            for item in taskCompleteUnWrap {
                                if let item {
                                    arr.append(item)
                                }
                            }
                            dailyTaskModel.onNext(arr)
                        }
                    }


                }, onError: { error in

                })
                .disposed(by: disposeBag)
    }

}

class TaskFinishStateVC: SubLevelViewController {
    private let disposeBag = DisposeBag()

    lazy var taskStatusPanel: TaskStatusPanel = {
        let panel = TaskStatusPanel()
        panel.delegate = self
        return panel
    }()

    lazy var titleView: SectionTitleView = {
        let view = SectionTitleView(withStyle: .Style2, title: "履职记录")
        return view
    }()

    lazy var tableContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 7
        return view
    }()

    lazy var dailyTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(TaskListCell.self, forCellReuseIdentifier: "SecurityTaskListCell")
        return tableView
    }()


    lazy var leftButtonTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .hex("#FFFFFF")
        label.text = "每日任务"
        return label
    }()

    lazy var rightButtonTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .hex("#333333")
        label.text = "每月任务"

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
        view.rx.tapGesture().when(.recognized)
                .subscribe(onNext: { _ in
                    self.viewModel.requestData(
                            deptId: self.deptId ?? BSUser.currentUser.deptId,
                            dateType: self.taskStatusPanel.dateView.dateEnum.rawValue,
                            date: "\(self.taskStatusPanel.dateView.year)-\(self.taskStatusPanel.dateView.month)-\(self.taskStatusPanel.dateView.day)",
                            rwzq: 1
                    )

                })
                .disposed(by: disposeBag)

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
        view.rx.tapGesture().when(.recognized)
                .subscribe(onNext: { _ in
                    self.viewModel.requestData(
                            deptId: self.deptId ?? BSUser.currentUser.deptId,
                            dateType: self.taskStatusPanel.dateView.dateEnum.rawValue,
                            date: "\(self.taskStatusPanel.dateView.year)-\(self.taskStatusPanel.dateView.month)-\(self.taskStatusPanel.dateView.day)",
                            rwzq: 2
                    )

                })
                .disposed(by: disposeBag)

        rightButtonTitle.snp.makeConstraints { make in
            make.center.equalTo(view)
        }

        return view
    }()

    lazy var monthTableView: UITableView = {
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


    var models: [WdwcqkPercentModel] = []
    var monthModels: [WdwcqkPercentModel] = []

    let viewModel = TaskFinishStateViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = deptName
        view.backgroundColor = .bg


        viewModel.deptWclModel
                .observe(on: MainScheduler.instance)
                .subscribe { [self] event in
                    if let element = event.element {
                        taskStatusPanel.buildData(finishRate: element.zwcl, errorCount: element.ycs)
                    }
                }
                .disposed(by: disposeBag)


        viewModel.dailyTaskModel
                .observe(on: MainScheduler.instance)
                .subscribe { [self] event in
                    if let element = event.element {
                        models = element
                        dailyTableView.reloadData()
                        dailyTableView.tableShowEmpty(withDataCount: models.count)
                    }
                }
                .disposed(by: disposeBag)

        viewModel.monthTaskModel
                .observe(on: MainScheduler.instance)
                .subscribe { [self] event in
                    if let element = event.element {
                        monthModels = element
                        monthTableView.reloadData()
                        monthTableView.tableShowEmpty(withDataCount: monthModels.count)
                    }
                }
                .disposed(by: disposeBag)


        viewModel.requestData(deptId: deptId ?? BSUser.currentUser.deptId, dateType: DateType.day.rawValue, date: Date().string(format: "yyyy-MM-dd"), rwzq: nil)

        view.addSubview(taskStatusPanel)
        setupDailyTableView()
    }

    // MARK: - Setup

    func setupDailyTableView() {

        leftButton.removeFromSuperview()
        rightButton.removeFromSuperview()
        monthTableView.removeFromSuperview()
        titleView.removeFromSuperview()
        dailyTableView.removeFromSuperview()

        view.addSubview(titleView)
        view.addSubview(dailyTableView)

        taskStatusPanel.snp.remakeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
        }

        titleView.snp.makeConstraints { make in
            make.top.equalTo(taskStatusPanel.snp.bottom).offset(20)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.height.equalTo(18)
        }

        dailyTableView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.bottom.equalTo(view).offset(-20)
        }
    }

    func setupMonthTableView() {
        titleView.removeFromSuperview()
        dailyTableView.removeFromSuperview()
        leftButton.removeFromSuperview()
        rightButton.removeFromSuperview()
        monthTableView.removeFromSuperview()
        view.addSubview(leftButton)
        view.addSubview(rightButton)

        view.addSubview(monthTableView)

        taskStatusPanel.snp.remakeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
        }

        leftButton.snp.makeConstraints { make in
            make.left.equalTo(view).offset(10)
            make.top.equalTo(taskStatusPanel.snp.bottom).offset(10)
            make.height.equalTo(45)
            make.right.equalTo(rightButton.snp.left).offset(15);
        }

        rightButton.snp.makeConstraints { make in
            make.right.equalTo(view).offset(-10)
            make.top.equalTo(taskStatusPanel.snp.bottom).offset(10)
            make.height.equalTo(45)
            make.left.equalTo(leftButton.snp.right).offset(-15)
            make.width.equalTo(leftButton)
        }

        monthTableView.snp.makeConstraints { make in
            make.top.equalTo(leftButton.snp.bottom).offset(10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.bottom.equalTo(view).offset(-20)
        }

    }


}

extension TaskFinishStateVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == dailyTableView {
            return models.count
        } else {
            return monthModels.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == dailyTableView {
            let data = models[indexPath.row]
            let cell = (tableView.dequeueReusableCell(withIdentifier: "SecurityTaskListCell", for: indexPath)) as! TaskListCell
            cell.buildPercentModels(data: data)
            cell.selectionStyle = .none
            return cell
        } else {
            let data = monthModels[indexPath.row]
            let cell = (tableView.dequeueReusableCell(withIdentifier: "TaskProcessCell", for: indexPath)) as! TaskProcessCell
            cell.buildPercentModel(data: data)
            cell.selectionStyle = .none
            return cell
        }
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == dailyTableView {
            return 64.5
        } else {
            return 72
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if tableView == dailyTableView {
            let data = models[indexPath.row]
            let vc = SafeCheckTaskVC()
            vc.id = data.taskId
            navigationController?.pushViewController(vc, animated: true)
        } else {
            navigationController?.pushViewController(TaskCompletionRateDetailVC(), animated: true)
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.setCornerRadiusSection(willDisplay: cell, forRowAt: indexPath)
    }

}

extension TaskFinishStateVC: TaskStatusPanelDelegate {
    func didSelected(year: Int, quarter: Int?, month: Int?, day: Int?, dateEnum: CustomDateEnum) {
        if dateEnum == CustomDateEnum.daily {
            setupDailyTableView()
            viewModel.requestData(deptId: deptId ?? BSUser.currentUser.deptId, dateType: DateType.day.rawValue, date: "\(year)-\(month ?? 0)-\(day ?? 0)", rwzq: nil)
        } else if dateEnum == CustomDateEnum.monthly {
            setupMonthTableView()
            viewModel.requestData(deptId: deptId ?? BSUser.currentUser.deptId, dateType: DateType.month.rawValue, date: "\(year)-\(month ?? 0)-\(day ?? 0)", rwzq: 1)
        } else if dateEnum == CustomDateEnum.quarterly {
            setupMonthTableView()
            viewModel.requestData(deptId: deptId ?? BSUser.currentUser.deptId, dateType: DateType.season.rawValue, date: "\(year)-\(month ?? 0)-\(day ?? 0)", rwzq: 1)
        } else if dateEnum == CustomDateEnum.annual {
            setupMonthTableView()
            viewModel.requestData(deptId: deptId ?? BSUser.currentUser.deptId, dateType: DateType.year.rawValue, date: "\(year)-\(month ?? 0)-\(day ?? 0)", rwzq: 1)

        }
    }

    func statusPanelTaskFinishRateButtonClicked() {
        navigationController?.pushViewController(TaskCompletionRateVC(withDeptId: deptId, deptName: deptName), animated: true)
    }

    func statusPanelErrorButtonClicked() {
        navigationController?.pushViewController(MonthAnomaliesVC(withDeptId: deptId, deptName: deptName), animated: true)
    }
}
