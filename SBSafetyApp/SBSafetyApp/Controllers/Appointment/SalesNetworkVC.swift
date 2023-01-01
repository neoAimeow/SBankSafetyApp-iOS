//
//  SalesNetworkVC.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/28.
//

import Foundation
import UIKit

#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

class SalesNetworkViewModel {
    public let closeListSubject: PublishSubject<[YywdModel]> = PublishSubject();
    public let openListSubject: PublishSubject<[YywdModel]> = PublishSubject();

    public let loading: PublishSubject<Bool> = PublishSubject()
    private let disposeBag = DisposeBag()

    public func requestData() {
        loading.onNext(false)
        Observable.zip(
                        API.yywd(withParam: YywdParam(status: 0, workDate: Date().string(format: "yyyy-MM-dd"))),
                        API.yywd(withParam: YywdParam(status: 1, workDate: Date().string(format: "yyyy-MM-dd"))))
                .subscribe(onNext: { [self] (closeList, openList) in
                    loading.onNext(true)

                    print(closeList, openList)
                    if let models = closeList.models {
                        var arr: Array<YywdModel> = []
                        for item in models {
                            if let item {
                                arr.append(item)
                            }
                        }
                        closeListSubject.onNext(arr)
                    }

                    if let models = openList.models {
                        var arr: Array<YywdModel> = []
                        for item in models {
                            if let item {
                                arr.append(item)
                            }
                        }
                        openListSubject.onNext(arr)
                    }

                }, onError: { error in

                })
                .disposed(by: disposeBag)

    }
}

class SalesNetworkVC: SubLevelViewController {
    private let disposeBag = DisposeBag()

    lazy var segmentedControl: ScrollableSegmentedControl = {
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
        tableView.tableShowEmpty(withDataCount: models.count)

        tableView.register(SaleNetworkCell.self, forCellReuseIdentifier: "TaskFinishProgressCell")
        return tableView
    }()

    var models: [YywdModel] = []
    var openModels: [YywdModel] = []
    var closeModels: [YywdModel] = []

    let viewModel = SalesNetworkViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = deptName


        viewModel.closeListSubject
                .observe(on: MainScheduler.instance)
                .subscribe { [self] event in
                    if let element = event.element {
                        closeModels = element
                        if segmentedControl.selectedSegmentIndex == 0 {
                            models = closeModels
                            tableView.reloadData()
                            segmentedControl.updateSegment(withTitle: "不营业网点(" + String(closeModels.count) + ")", at: 0)
                        }
                    }
                }
                .disposed(by: disposeBag)

        viewModel.openListSubject
                .observe(on: MainScheduler.instance)
                .subscribe { [self] event in
                    if let element = event.element {
                        openModels = element
                        if segmentedControl.selectedSegmentIndex == 1 {
                            models = openModels
                            tableView.reloadData()
                            segmentedControl.updateSegment(withTitle: "营业网点(" + String(openModels.count) + ")", at: 1)
                        }
                    }
                }
                .disposed(by: disposeBag)

        viewModel.requestData()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    func setupUI() {
        view.addSubview(segmentedControl)
        view.addSubview(tableView)

        segmentedControl.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(48)
        }

        tableView.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.top.equalTo(segmentedControl.snp.bottom)
            make.bottom.equalTo(view)
        }

        insertSegment(unfinishCount: 0, finishCount: 0)
    }

    func insertSegment(unfinishCount: Int, finishCount: Int) {
        segmentedControl.removeAll()
        segmentedControl.insertSegment(withTitle: "不营业网点(" + String(unfinishCount) + ")", at: 0)
        segmentedControl.insertSegment(withTitle: "营业网点(" + String(finishCount) + ")", at: 1)
        segmentedControl.selectedSegmentIndex = 0
    }

    @objc func segmentSelected(sender: ScrollableSegmentedControl) {
        print("segmentSelected", sender.selectedSegmentIndex)
        if segmentedControl.selectedSegmentIndex == 0 {
            models = closeModels
        } else {
            models = openModels
        }
        tableView.reloadData()
    }
}

extension SalesNetworkVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = models[indexPath.row]
        let cell = (tableView.dequeueReusableCell(withIdentifier: "TaskFinishProgressCell", for: indexPath)) as! SaleNetworkCell
        cell.buildData(title: data.bmmc)
        cell.selectionStyle = .none
        return cell
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        58
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(AppointmentManagerVC(), animated: true)
    }

}
