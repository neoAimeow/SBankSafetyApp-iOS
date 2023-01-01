//
//  SafeCheckTaskVC.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/19.
// https://pic8.58cdn.com.cn/nowater/webim/big/n_v248494064d15a4f2db79b6c7fbf8cad48.png

import Foundation
import UIKit
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

class SafeCheckTaskViewModel {
    public let taskCompleteModel: PublishSubject<TaskCompleteModel> = PublishSubject();

    public let loading: PublishSubject<Bool> = PublishSubject()
    private let disposeBag = DisposeBag()

    func requestData(id: Int64) {
        loading.onNext(false)
        API.rwedit(withParam: RWEditParam(withId: id)).subscribe { [self] model in
                    loading.onNext(true)
                    if let taskCompleteUnWrap = model.model {
                        taskCompleteModel.onNext(taskCompleteUnWrap)
                    }
                }
                .disposed(by: disposeBag)
    }
}

class SafeCheckTaskVC: SubLevelViewController {
    var id: Int64?

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.register(BaseInfoCell.self, forCellReuseIdentifier: "SafeCheckNormalCell")
        tableView.register(BaseInfoCell.self, forCellReuseIdentifier: "SafeCheckStyle1Cell")
        return tableView
    }()

    let viewModel = SafeCheckTaskViewModel()
    private let disposeBag = DisposeBag()

    var baseInfos: [BaseInfoModel] = []


    var taskModel: TaskCompleteModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = ""

        viewModel.taskCompleteModel
                .observe(on: MainScheduler.instance)
                .subscribe { [self] event in
                    if let element = event.element {
                        taskModel = element
                        baseInfos = [BaseInfoModel(style: BaseInfoStyleEnum.Normal, title: "履职人", detail: taskModel?.lzrmc),
                                     BaseInfoModel(style: BaseInfoStyleEnum.Normal, title: "任务时间", detail: taskModel?.rwrq),
                                     BaseInfoModel(style: BaseInfoStyleEnum.Normal, title: "完成时间", detail: taskModel?.tjsj)]
                        if let wdmc = taskModel?.wdmc {
                            title = wdmc
                        }
                        tableView.reloadData()
                    }
                }
                .disposed(by: disposeBag)

        if let taskId = id {
            viewModel.requestData(id: taskId)
        }


        setupUI()
    }

    // MARK: - Setup

    func setupUI() {
        view.backgroundColor = .hex("#F8F8F8")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view).offset(-10)
        }
    }
}

extension SafeCheckTaskVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        if let count = taskModel?.rwjlMbDqList?.count {
            return count + 1
        }

        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return baseInfos.count
        } else {
            if let list = taskModel?.rwjlMbDqList?[section - 1] {
                return list.boscLzglRwjlMbs?.count ?? 0
            }
            return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 1
        } else {
            return 50
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (section == 0) {
            let view = UIView()
            view.backgroundColor = .clear
            return view
        } else {
            if let data = taskModel?.rwjlMbDqList?[section - 1] {
                if let dqmc = data.dqmc {
                    let view = SectionTitleView(withStyle: SectionTitleStyleEnum.Style1, title: dqmc)
                    return view
                }
            }
        }

        let view = UIView()
        view.backgroundColor = .clear
        return view
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let data = baseInfos[indexPath.row]
            let cell = (tableView.dequeueReusableCell(withIdentifier: "SafeCheckNormalCell", for: indexPath)) as! BaseInfoCell
            cell.buildData(model: data, status: BaseInfoStatesEnum.Normal.rawValue)
            cell.selectionStyle = .none
            return cell
        } else {
            if let list = taskModel?.rwjlMbDqList?[indexPath.section - 1] {
                if let data = list.boscLzglRwjlMbs?[indexPath.row] {
                    let cell = (tableView.dequeueReusableCell(withIdentifier: "SafeCheckStyle1Cell", for: indexPath)) as! BaseInfoCell
                    if let rwmc = data.rwmc {
                        cell.buildData(model: BaseInfoModel(style: .Style1, title: rwmc), status: data.rwzt)
                    }
                    cell.selectionStyle = .none
                    return cell
                }
            }

        }
        let cell = (tableView.dequeueReusableCell(withIdentifier: "SafeCheckNormalCell", for: indexPath)) as! BaseInfoCell
        cell.selectionStyle = .none
        return cell
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0) {
           
        } else {
            if let list = taskModel?.rwjlMbDqList?[indexPath.section - 1] {
                if let data = list.boscLzglRwjlMbs?[indexPath.row] {
                    if (data.rwzt == BaseInfoStatesEnum.Normal.rawValue) {
                        let vc = SafeCheckoutMachinesVC()
                        vc.name = taskModel?.lzrmc
                        vc.dateStr = taskModel?.rwrq
                        vc.id = data.id
                        vc.remark = data.remark
                        vc.titleStr = data.rwmc
                        if (data.rwzt == "1") {
                            vc.isSuitable = true
                        } else {
                            vc.isSuitable = false
                        }
                        navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.setCornerRadiusSection(willDisplay: cell, forRowAt: indexPath)
    }
}
