//
// Created by Aimeow on 2022/12/13.
//

import Foundation
import UIKit

#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

class AppointmentManagerDetailViewModel {
    public let deptWclModel: PublishSubject<SelectLzglWclByDeptModel> = PublishSubject();
    public let loading: PublishSubject<Bool> = PublishSubject()
    private let disposeBag = DisposeBag()

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
}


class AppointmentManagerDetailVC: SubLevelViewController {
    var disposeBag = DisposeBag()
    let sticsV = BSStatisticsView()

    var date: String = Date.todayDate()

    var viewModel = AppointmentManagerDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        navigationController?.navBarStyle(.white)
        setupUI()

        viewModel.deptWclModel
                .observe(on: MainScheduler.instance)
                .subscribe { [self] event in
                    if let model = event.element {
                        sticsV.reloadData(deptName: deptName, modal: model)
                    }

                }
                .disposed(by: disposeBag)

        reloadData()

        title = deptName
    }

    func reloadData() {
        if deptName == nil {
            deptName = BSUser.currentUser.deptName
            deptId = BSUser.currentUser.deptId
        }

        if let deptId {
            viewModel.requestDeptWcl(param: LzglBaseParam(deptId: deptId, dateType: DateType.day.rawValue, date: Date().string(format: "yyyy-MM-dd")))
        }
    }

    func setupUI() {
        sticsV.baseTV.title = "履职管理"
        sticsV.sDelegate = self
        sticsV.deptBtn.delegate = self
        sticsV.customV.delegate = self
        view.addSubview(sticsV)
        sticsV.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension AppointmentManagerDetailVC: BSStatisticsViewDelegate {
    func handleDeptSelected(_ dept: TaskDeptRateModal) {
        if dept.sfczzj == true {
            let subVC = AppointmentManagerDetailVC(withDeptId: dept.wddm, deptName: dept.wdmc)
            navigationController?.pushViewController(subVC, animated: true)
        } else {
            let vc = TaskHomeVC(withDeptId: dept.wddm, deptName: dept.wdmc)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension AppointmentManagerDetailVC: BSDeptStiscControlDelegate {
    func handleSelected(_ dept: TaskDeptRateModal?) {
        let vc = AppointmentManagerDetailVC(withDeptId: dept?.wddm, deptName: dept?.wdmc)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension AppointmentManagerDetailVC: BSCustomDateViewDelegate {
    func didSelected(year: Int, quarter: Int?, month: Int?, day: Int?, dateEnum: CustomDateEnum) {
        print("BSCustomDateViewDelegate", year, month!, day!, dateEnum, dateEnum.rawValue)
        viewModel.requestDeptWcl(param: LzglBaseParam(deptId: deptId ?? BSUser.currentUser.deptId, dateType: dateEnum.rawValue, date: "\(year)-\(month!)-\(day!)"))
    }
}

