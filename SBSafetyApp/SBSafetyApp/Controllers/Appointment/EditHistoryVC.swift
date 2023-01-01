//
//  EditHistoryVC.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/18.
//

import Foundation
import UIKit
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

class EditHistoryViewModel {
    private let disposeBag = DisposeBag()
    public let yyxgjlModel: PublishSubject<[YyxgjlModel]> = PublishSubject();
    
    public let loading: PublishSubject<Bool> = PublishSubject()

    public func requestYyxgjl(deptId: Int64, workDate: String, pageNum: Int) {
        loading.onNext(false)
        API.yyxgjl(withParam: YyxgjlParam(deptId: deptId, workDate: workDate, pageNum: pageNum, pageSize: 20)).subscribe { [self] model in
                    loading.onNext(true)
                    if let yyxgjlUnWrap = model.element?.models {
                        var arr: Array<YyxgjlModel> = []
                        for item in yyxgjlUnWrap {
                            if let itemValue = item {
                                arr.append(itemValue)
                            }
                        }
                        yyxgjlModel.onNext(arr)
                    }
                }
                .disposed(by: disposeBag)
    }

}

class EditHistoryVC: SubLevelViewController {
    private let disposeBag = DisposeBag()

    var workDate: String?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(EditHistoryCell.self, forCellReuseIdentifier: "EditHistoryCell")
        return tableView
    }()

    var historyModels: [YyxgjlModel] = []
    let viewModel = EditHistoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "修改历史"
        
        viewModel.yyxgjlModel
                .observe(on: MainScheduler.instance)
                .subscribe { [self] event in

                    if let models = event.element {
                        historyModels = models
                        self.tableView.reloadData()
                    }
                }
                .disposed(by: disposeBag)

        viewModel.requestYyxgjl(deptId: self.deptId ?? BSUser.currentUser.deptId, workDate: workDate ?? Date().string(format: "yyyy-MM-dd"), pageNum: 0)

        setupUI()
    }

    // MARK: - Setup

    func setupUI() {
        view.backgroundColor = .hex("#F8F8F8")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
}

extension EditHistoryVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = historyModels[indexPath.row]
        let cell = (tableView.dequeueReusableCell(withIdentifier: "EditHistoryCell", for: indexPath)) as! EditHistoryCell
        cell.buildData(data: data)
        cell.selectionStyle = .none
        return cell

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
