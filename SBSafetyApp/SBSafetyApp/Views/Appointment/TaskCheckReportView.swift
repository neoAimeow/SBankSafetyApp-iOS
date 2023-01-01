//
//  TaskCheckReportView.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/21.
//

import Foundation
import UIKit

#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

class TaskCheckReportViewModel {
    public let deptWclModel: PublishSubject<TaskDeptRateModal> = PublishSubject();
    public let wdwcqkModel: PublishSubject<WdwcqkModel> = PublishSubject();
    public let rwwcqkModel: PublishSubject<[RwwcqkModel]> = PublishSubject();

    public let loading: PublishSubject<Bool> = PublishSubject()
    private let disposeBag = DisposeBag()

    public func requestData(param: LzglBaseParam) {
        loading.onNext(false)
        Observable.zip(
                        API.selectLzglWcl(withParam: param),
                        API.selectLzglWdwcqk(withParam: param),
                        API.rwwcqk(withParam: param))
                .subscribe(onNext: { [self] (deptWcl, wdwcqk, rwwcqk) in
                    loading.onNext(true)

                    print(deptWcl)
                    if let deptWclUnWrap = deptWcl.model {
                        deptWclModel.onNext(deptWclUnWrap)
                    }

                    if let wdwcqkUnWrap = wdwcqk.model {
                        wdwcqkModel.onNext(wdwcqkUnWrap)
                    }

                    if let rwwcqkUnWrap = rwwcqk.models {
                        var arr: Array<RwwcqkModel> = []
                        for item in rwwcqkUnWrap {
                            if let item {
                                arr.append(item)
                            }
                        }
                        rwwcqkModel.onNext(arr)
                    }

                }, onError: { error in

                })
                .disposed(by: disposeBag)
    }
}

class TaskCheckReportView: UIView {
    var deptId: Int64?
    var deptName: String?
    private let disposeBag = DisposeBag()

    lazy var statusPanelView: TaskStatusPanel = {
        let view = TaskStatusPanel()
        view.delegate = self
        return view
    }()

    lazy var taskOutletStatusView: TaskOutletStatusView = {
        let view = TaskOutletStatusView()
        return view
    }()

    lazy var taskAllStatusView: TaskAllStatusView = {
        let view = TaskAllStatusView()
        view.delegate = self
        return view
    }()

    let viewModel = TaskCheckReportViewModel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .bg
        viewModel.deptWclModel
                .observe(on: MainScheduler.instance)
                .subscribe { [self] event in
                    if let element = event.element {
                        statusPanelView.buildData(finishRate: element.zwcl, errorCount: element.ycs)
                    }
                }
                .disposed(by: disposeBag)

        viewModel.wdwcqkModel
                .observe(on: MainScheduler.instance)
                .subscribe { [self] event in
                    if let element = event.element {
                        taskOutletStatusView.buildData(model: element)
                    }
                }
                .disposed(by: disposeBag)

        viewModel.rwwcqkModel
                .observe(on: MainScheduler.instance)
                .subscribe { [self] event in
                    if let element = event.element {
                        taskAllStatusView.buildData(rwwcqk: element)
                    }
                }
                .disposed(by: disposeBag)

        setupUI()
    }

    func requestData() {
        viewModel.requestData(param: LzglBaseParam(deptId: deptId ?? BSUser.currentUser.deptId, dateType: DateType.day.rawValue, date: Date().string(format: "yyyy-MM-dd")))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        addSubview(statusPanelView)
        addSubview(taskOutletStatusView)
        addSubview(taskAllStatusView)

        statusPanelView.snp.makeConstraints { make in
            make.left.top.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
        }

        taskOutletStatusView.snp.makeConstraints { make in
            make.left.right.equalTo(self)
            make.top.equalTo(statusPanelView.snp.bottom).offset(10)
        }

        taskAllStatusView.snp.makeConstraints { make in
            make.left.right.equalTo(self)
            make.top.equalTo(taskOutletStatusView.snp.bottom).offset(10)
        }
    }
}

extension TaskCheckReportView: TaskStatusPanelDelegate {
    func didSelected(year: Int, quarter: Int?, month: Int?, day: Int?, dateEnum: CustomDateEnum) {
        viewModel.requestData(param: LzglBaseParam(deptId: deptId ?? BSUser.currentUser.deptId, dateType: dateEnum.rawValue, date: "\(year)-\(month ?? 0)-\(day ?? 0)"))
    }

    func statusPanelTaskFinishRateButtonClicked() {
        getFirstViewController()?.navigationController?.pushViewController(TaskCompletionRateVC(withDeptId: deptId, deptName: deptName), animated: true)
    }

    func statusPanelErrorButtonClicked() {

    }
}

extension TaskCheckReportView: TaskAllStatusViewDelegate {
    func goToTaskList() {
        let vc = AppointmentTaskListVC()
        let dateView = statusPanelView.dateView

        vc.dateType = statusPanelView.dateView.dateEnum.rawValue
        vc.date = "\(dateView.year)-\(dateView.month)-\(dateView.day)"
        vc.deptId = deptId ?? BSUser.currentUser.deptId
        vc.deptName = deptName ?? BSUser.currentUser.deptName

        getFirstViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
}
