//
//  TaskFinishProgressVC.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/17.
//

import Foundation
import UIKit
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

class TaskFinishProgressViewModel {
    public let loading: PublishSubject<Bool> = PublishSubject()
    private let disposeBag = DisposeBag()

    public let panelModel: PublishSubject<TaskProcessPanelModel> = PublishSubject();
    public let unfinishListModel: PublishSubject<[RwwcqkModel]> = PublishSubject();
    public let finishListModel: PublishSubject<[RwwcqkModel]> = PublishSubject();

    func fetchData(withParam param: RwwcjdParam, task: TaskCompleteModel) {
        loading.onNext(false)
        API.rwwcjd(withParam: param).subscribe { [self] model in
                    loading.onNext(true)

                    // 构建数据
                    guard let taskName = task.rwmc else {
                        return
                    }
                    guard let finishCount = model.element?.model?.wcs else {
                        return
                    }

                    guard let unfinishCount = model.element?.model?.wwcs else {
                        return
                    }

                    var timeStr = ""
                    if let rwkssj = task.rwkssj {
                        let startDate = Date.normalDateFormatter().date(from: rwkssj)!
                        timeStr.append("\(startDate.string(format: "HH:mm"))-")
                    }

                    if let rwjssj = task.rwjssj {
                        let endDate = Date.normalDateFormatter().date(from: rwjssj)!
                        timeStr.append("\(endDate.string(format: "HH:mm"))")
                    }

                    let panelDate = TaskProcessPanelModel(taskName: taskName, processValue: 0, timeStr: timeStr, finishCount: finishCount, unfinishCount: unfinishCount);

                    panelModel.onNext(panelDate)

                    if let finishList = model.element?.model?.wcList {
                        finishListModel.onNext(finishList)
                    }

                    if let unfinishList = model.element?.model?.wwcList {
                        unfinishListModel.onNext(unfinishList)
                    }

                }
                .disposed(by: disposeBag)
    }

}

class TaskFinishProgressVC: SubLevelViewController {
    // 页面入参
    var dateType: DateType.RawValue?
    var date: String?
    var taskModel: TaskCompleteModel?

    private let disposeBag = DisposeBag()

    lazy var taskProcessPanel: TaskProcessPanel = {
        let panel = TaskProcessPanel()
        return panel
    }()

    lazy var segmentedC: ScrollableSegmentedControl = {
        let segmented = ScrollableSegmentedControl()
        segmented.tintColor = .primary
        segmented.underlineSelected = true
        segmented.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)
        segmented.segmentContentColor = .black
        segmented.selectedSegmentContentColor = .primary

        let normalAttrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
        let highlightAttrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        let selectAttrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        segmented.setTitleTextAttributes(normalAttrs, for: .normal)
        segmented.setTitleTextAttributes(highlightAttrs, for: .highlighted)
        segmented.setTitleTextAttributes(selectAttrs, for: .selected)

        return segmented
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(TaskFinishProgressCell.self, forCellReuseIdentifier: "TaskFinishProgressCell")
        return tableView
    }()


    var taskList: [RwwcqkModel] = []
    var finishList: [RwwcqkModel] = []
    var unfinishList: [RwwcqkModel] = []

    var viewModel = TaskFinishProgressViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "任务完成进度"

        viewModel.panelModel
                .observe(on: MainScheduler.instance)
                .subscribe { [self] event in
                    if let data = event.element {
                        taskProcessPanel.buildData(withModel: data)
                    }
                }
                .disposed(by: disposeBag)

        viewModel.finishListModel
                .observe(on: MainScheduler.instance)
                .subscribe { [self] event in
                    if let finish = event.element {
                        finishList = finish
                        if segmentedC.selectedSegmentIndex == 1 {
                            taskList = finishList
                            tableView.reloadData()
                        }
                        segmentedC.updateSegment(withTitle: "已完成(" + String(finishList.count) + ")", at: 1)
                    }
                }
                .disposed(by: disposeBag)

        viewModel.unfinishListModel
                .observe(on: MainScheduler.instance)
                .subscribe { [self] event in
                    if let unfinish = event.element {
                        unfinishList = unfinish
                        if segmentedC.selectedSegmentIndex == 0 {
                            taskList = unfinishList
                            tableView.reloadData()
                        }
                        segmentedC.updateSegment(withTitle: "未完成(" + String(unfinishList.count) + ")", at: 0)
                    }
                }
                .disposed(by: disposeBag)
        setupUI()

        if let taskMo = taskModel {
            if let rwid = taskMo.rwid {
                viewModel.fetchData(withParam: RwwcjdParam(rwid: rwid, date: date ?? Date().string(format: "yyyy-MM-dd"), dateType: dateType ?? DateType.day.rawValue), task: taskMo)
            }
        }
    }

    // MARK: - Setup

    func setupUI() {
        view.addSubview(taskProcessPanel)
        view.addSubview(segmentedC)
        view.addSubview(tableView)

        taskProcessPanel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
        }
        segmentedC.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.top.equalTo(taskProcessPanel.snp.bottom)
            make.height.equalTo(48)
        }

        updateSegment(unfinishCount: 0, finishCount: 0)

        tableView.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.top.equalTo(segmentedC.snp.bottom)
            make.bottom.equalTo(view)
        }
    }

    func updateSegment(unfinishCount: Int, finishCount: Int) {
        segmentedC.removeAll()
        segmentedC.insertSegment(withTitle: "未完成(" + String(unfinishCount) + ")", at: 0)
        segmentedC.insertSegment(withTitle: "已完成(" + String(finishCount) + ")", at: 1)
        segmentedC.selectedSegmentIndex = 0

    }

    @objc func segmentSelected(sender: ScrollableSegmentedControl) {
        print("segmentSelected", sender.selectedSegmentIndex)
        if sender.selectedSegmentIndex == 0 {
            taskList = unfinishList
        } else {
            taskList = finishList
        }
        tableView.reloadData()
    }
}


extension TaskFinishProgressVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = taskList[indexPath.row]
        let cell = (tableView.dequeueReusableCell(withIdentifier: "TaskFinishProgressCell", for: indexPath)) as! TaskFinishProgressCell
        cell.buildModel(model: data)
        cell.selectionStyle = .none
        return cell
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        58
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(TaskFinishStateVC(withDeptId: deptId, deptName: deptName), animated: true)
    }

}

