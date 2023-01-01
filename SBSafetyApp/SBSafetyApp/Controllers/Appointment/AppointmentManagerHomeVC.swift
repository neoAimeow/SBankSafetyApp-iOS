//
// Created by Aimeow on 2022/12/8.
//

import Foundation
import UIKit
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

class AppointmentManagerHomeViewModel {
    public let deptWclModel: PublishSubject<SelectLzglWclByDeptModel> = PublishSubject();
    public let wdwcqkModel: PublishSubject<WdwcqkModel> = PublishSubject();
    public let rwwcqkModel: PublishSubject<[RwwcqkModel]> = PublishSubject();
    public let taskCompleteModel: PublishSubject<[TaskCompleteModel]> = PublishSubject();

    public let loading: PublishSubject<Bool> = PublishSubject()
    private let disposeBag = DisposeBag()

    public func requestData(param: LzglBaseParam) {
        loading.onNext(false)
        Observable.zip(
                        API.selectLzglWclByDept(withParam: param),
                        API.selectLzglWdwcqk(withParam: param),
                        API.rwwcqk(withParam: param),
                        API.taskCompleteView(withParam: param))
                .subscribe(onNext: { [self] (deptWcl, wdwcqk, rwwcqk, taskComplete) in
                    loading.onNext(true)

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
                    if let taskCompleteUnWrap = taskComplete.models {
                        var arr: Array<TaskCompleteModel> = []
                        for item in taskCompleteUnWrap {
                            if let item {
                                arr.append(item)
                            }
                        }
                        taskCompleteModel.onNext(arr)
                    }

                }, onError: { error in

                })
                .disposed(by: disposeBag)
    }

    public func requestDeptWcl(param: LzglBaseParam) {
        loading.onNext(false)
        API.selectLzglWclByDept(withParam: param).subscribe { [self] model in
                    loading.onNext(true)
                    if let deptWclUnWrap = model.model {
                        deptWclModel.onNext(deptWclUnWrap)
                    }
                }
                .disposed(by: disposeBag)
    }

    public func requestTaskCompleteData(param: LzglBaseParam) {
        loading.onNext(false)
        API.taskCompleteView(withParam: param).subscribe { [self] model in
                    loading.onNext(true)
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

class AppointmentManagerHomeVC: SubLevelViewController, PullToRefreshPresentable {

    var disposeBag = DisposeBag()

    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()

    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var managerPanel: AppointmentManagerPanel = {
        let view = AppointmentManagerPanel()
        view.delegate = self
        return view
    }()

    lazy var statusView: TaskOutletStatusView = {
        let view = TaskOutletStatusView()
        return view
    }()

    lazy var completeRateView: TaskCompletionRateView = {
        let view = TaskCompletionRateView()
        return view
    }()

    lazy var taskView: AppointmentManagerTaskView = {
        let view = AppointmentManagerTaskView()
        view.delegate = self
        return view
    }()

    lazy var allStateView: TaskAllStatusView = {
        let view = TaskAllStatusView()
        view.delegate = self
        return view
    }()

    var viewModel = AppointmentManagerHomeViewModel();
    let user = BSUser.currentUser

    var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = user.deptName

        reloadAction(param: LzglBaseParam(deptId: user.deptId, dateType: DateType.day.rawValue, date: Date().string(format: "yyyy-MM-dd")))

        viewModel.deptWclModel
                .observe(on: MainScheduler.instance)
                .subscribe { [self] event in
                    if let zwcl = event.element?.zwcl {
                        managerPanel.buildData(zwcl)
                    }

                    if let zxList = event.element?.zxList {
                        completeRateView.reloadData(zxList)
                    }
                }
                .disposed(by: disposeBag)

        viewModel.wdwcqkModel
                .observe(on: MainScheduler.instance)
                .subscribe { [self] event in
                    if let element = event.element {
                        statusView.buildData(model: element)
                    }
                }
                .disposed(by: disposeBag)

        viewModel.rwwcqkModel
                .observe(on: MainScheduler.instance)
                .subscribe { [self] event in
                    if let element = event.element {
                        allStateView.buildData(rwwcqk: element)
                    }
                }
                .disposed(by: disposeBag)

        viewModel.taskCompleteModel
                .observe(on: MainScheduler.instance)
                .subscribe { [self] event in
                    if let element = event.element {
                        taskView.buildModels(models: element)
                    }
                }
                .disposed(by: disposeBag)

        setupUI()
        setupPullToRefresh(on: scrollView, bottomRefreshing: false)
    }

    func reloadAction(param: LzglBaseParam) {
        viewModel.requestData(param: param);
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        scrollView.removeAllPullToRefresh()
    }

    // MARK: - Setup

    func setupUI() {
        view.backgroundColor = .bg
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(managerPanel)
        contentView.addSubview(statusView)
        contentView.addSubview(completeRateView)
        contentView.addSubview(taskView)
        contentView.addSubview(allStateView)

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.bottom.equalTo(view)
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(ScreenWidth)
        }

        managerPanel.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
            make.top.equalTo(contentView.snp.top)
        }

        statusView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.top.equalTo(managerPanel.snp.bottom).offset(20)
        }

        allStateView.snp.makeConstraints { make in
            make.left.right.equalTo(managerPanel)
            make.top.equalTo(statusView.snp.bottom).offset(20)
        }

        taskView.snp.makeConstraints { make in
            make.left.right.equalTo(managerPanel)
            make.top.equalTo(allStateView.snp.bottom).offset(20)
        }

        completeRateView.snp.makeConstraints { make in
            make.left.right.equalTo(managerPanel)
            make.top.equalTo(taskView.snp.bottom).offset(20)
            make.bottom.equalTo(contentView.snp.bottom).offset(-20)
            make.height.equalTo(322)
        }


    }
}

extension AppointmentManagerHomeVC: AppointmentManagerTaskViewDelegate {
    func segment(_ segment: ScrollableSegmentedControl, didSelectSegmentAtIndex index: Int) {
        var dateType = DateType.day.rawValue
        switch index {
        case 0:
            dateType = DateType.day.rawValue
            break;
        case 1:
            dateType = DateType.month.rawValue
            break
        case 2:
            dateType = DateType.season.rawValue
            break
        case 3:
            dateType = DateType.year.rawValue
            break
        default:
            break;
        }

        let param = LzglBaseParam(deptId: user.deptId, dateType: dateType, date: Date().string(format: "yyyy-MM-dd"))
        viewModel.requestTaskCompleteData(param: param)
    }
}

extension AppointmentManagerHomeVC: AppointmentManagerPanelDelegate {
    func didTapDetailButton() {
        navigationController?.pushViewController(AppointmentManagerDetailVC(withDeptId: user.deptId, deptName: user.deptName), animated: true)
    }

    func didSelected(year: Int, quarter: Int?, month: Int?, day: Int?, dateEnum: CustomDateEnum) {
        let selectDate = formatter.date(from: "\(year)-\(month!)-\(day!)")

        reloadAction(param: LzglBaseParam(deptId: user.deptId, dateType: dateEnum.rawValue, date: (selectDate ?? Date()).string(format: "yyyy-MM-dd")))
    }
}

extension AppointmentManagerHomeVC: TaskAllStatusViewDelegate {
    func goToTaskList() {
        let vc = AppointmentTaskListVC()
        let dateView = managerPanel.dateView

        vc.dateType = managerPanel.dateView.dateEnum.rawValue
        vc.date = "\(dateView.year)-\(dateView.month)-\(dateView.day)"
        vc.deptId = deptId ?? BSUser.currentUser.deptId
        vc.deptName = deptName ?? BSUser.currentUser.deptName

        navigationController?.pushViewController(vc, animated: true)
    }
}
