//
//  TaskCompletionRateVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/23.
//
// 【首页-履职管理】巡检报告-任务完成率

import Foundation
import UIKit
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

class TaskCompletionRateViewModel {
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

class TaskCompletionRateVC: SubLevelViewController {
    private let disposeBag = DisposeBag()

    let taskV = TaskCompletionRateView()

    let viewModel = TaskCompletionRateViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "任务完成率"
        view.backgroundColor = .bg
        setupUI()

        viewModel.deptWclModel
                .observe(on: MainScheduler.instance)
                .subscribe { [self] event in
                    if let zxList = event.element?.zxList {
                        taskV.reloadData(zxList)
                    }
                }
                .disposed(by: disposeBag)

        viewModel.requestDeptWcl(param: LzglBaseParam(deptId: deptId ?? BSUser.currentUser.deptId, dateType: DateType.day.rawValue, date: Date().string(format: "yyyy-MM-dd")))
    }


    // MARK: - Setup

    func setupUI() {
        view.addSubview(taskV)
        taskV.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(322)
        }
    }
}
