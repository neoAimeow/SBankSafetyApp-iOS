//
//  TaskHomeView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/18.
//

import Foundation
import UIKit
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

class TaskHomeViewModel {
    public let deptWclModel: PublishSubject<TaskDeptRateModal> = PublishSubject();
    public let taskCompleteModel: PublishSubject<[TaskCompleteModel]> = PublishSubject();
    public let loading: PublishSubject<Bool> = PublishSubject()
    private let disposeBag = DisposeBag()


    public func requestData(param: LzglBaseParam) {
        loading.onNext(false)
        Observable.zip(
                        API.selectLzglWcl(withParam: param),
                        API.taskCompleteView(withParam: param))
                .subscribe(onNext: { [self] (deptWcl, taskComplete) in
                    loading.onNext(true)

                    print(deptWcl)
                    if let deptWclUnWrap = deptWcl.model {
                        deptWclModel.onNext(deptWclUnWrap)
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
        API.selectLzglWcl(withParam: param).subscribe { [self] model in
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

class TaskHomeView: UIView {
    var disposeBag = DisposeBag()

    let headerV = TaskHomeHeaderView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 234))

    var models: [TaskCompleteModel] = []

    let tableView = UITableView(frame: .zero, style: .plain)
    let viewModel = TaskHomeViewModel()

    var deptId: Int64?
    var deptName: String?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .bg
        setupUI()

        viewModel.deptWclModel
                .observe(on: MainScheduler.instance)
                .subscribe { [self] event in
                    if let element = event.element {
                        headerV.updateUI(rate: element.zwcl, summary: element.rwzs, finish: element.wcs, errorCount: element.ycs)
                    }
                }
                .disposed(by: disposeBag)

        viewModel.taskCompleteModel
                .observe(on: MainScheduler.instance)
                .subscribe { [self] event in
                    if let element = event.element {
                        models = element
                        tableView.reloadData()
                    }
                }
                .disposed(by: disposeBag)

    }

    func requestData() {
        viewModel.requestData(param: LzglBaseParam(deptId: deptId ?? BSUser.currentUser.deptId, dateType: DateType.day.rawValue, date: Date().string(format: "yyyy-MM-dd")))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions

    @objc func segmentSelected(sender: ScrollableSegmentedControl) {
        print("segmentSelected", sender.selectedSegmentIndex)
        let index = sender.selectedSegmentIndex
        var dateValue = DateType.day.rawValue

        if (index == 0) {
            dateValue = DateType.day.rawValue
        } else if (index == 1) {
            dateValue = DateType.month.rawValue
        } else if (index == 2) {
            dateValue = DateType.season.rawValue
        } else {
            dateValue = DateType.year.rawValue
        }
        viewModel.requestTaskCompleteData(param: LzglBaseParam(deptId: deptId ?? BSUser.currentUser.deptId, dateType: dateValue, date: Date().string(format: "yyyy-MM-dd")))
    }

    func setupUI() {
        tableView.layer.cornerRadius = 10
        tableView.layer.masksToBounds = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .bg
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(self.snp.bottom).offset(-20)
        }

        tableView.tableHeaderView = headerV

        headerV.segmentedC.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)
        headerV.customV.delegate = self
    }
}


extension TaskHomeView: BSCustomDateViewDelegate {
    func didSelected(year: Int, quarter: Int?, month: Int?, day: Int?, dateEnum: CustomDateEnum) {
        viewModel.requestDeptWcl(param: LzglBaseParam(deptId: deptId ?? BSUser.currentUser.deptId, dateType: dateEnum.rawValue, date: "\(year)-\(month ?? 0)-\(day ?? 0)"))
    }
}

class TaskHomeHeaderView: UIView {
    let rateV = TaskFinishRateView(frame: CGRect(x: 0, y: 0, width: 90, height: 90))
    let summaryItem = TaskHomeItemView()
    let finishItem = TaskHomeItemView()
    let errorItem = TaskHomeItemView()
    let segmentedC = ScrollableSegmentedControl()
    let customV = BSCustomDateView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .bg
        setupUI()

        updateUI(rate: "0", summary: 0, finish: 0, errorCount: 0)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateUI(rate: String?, summary: Int?, finish: Int?, errorCount: Int?) {
        if let rateValue = rate {
            rateV.update(withVal: "\(rateValue)")
        }

        if let summaryValue = summary {
            summaryItem.val = "\(summaryValue)"
        }

        if let finishValue = finish {
            finishItem.val = "\(finishValue)"
        }

        if let errorValue = errorCount {
            errorItem.val = "\(errorValue)"
        }
    }

    func setupUI() {
        let baseV = UIView()
        baseV.backgroundColor = .white
        baseV.layer.cornerRadius = 10
        baseV.layer.masksToBounds = true
        addSubview(baseV)
        baseV.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(168)
        }

        baseV.addSubview(customV)
        customV.snp.makeConstraints { make in
            make.top.equalTo(baseV.snp.top).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(35)
        }

        baseV.addSubview(rateV)
        rateV.snp.makeConstraints { make in
            make.top.equalTo(customV.snp.bottom).offset(20)
            make.left.equalTo(baseV.snp.left).offset(10)
            make.width.height.equalTo(90)
        }

        summaryItem.key = "任务数"
        let itemWidth = (ScreenWidth - 130) / 3
        baseV.addSubview(summaryItem)
        summaryItem.snp.makeConstraints { make in
            make.top.equalTo(rateV.snp.top)
            make.left.equalTo(rateV.snp.right).offset(4)
            make.width.equalTo(itemWidth)
        }

        let vLine1 = UIView()
        vLine1.backgroundColor = .hex("#F5F5F5")
        addSubview(vLine1)
        vLine1.snp.makeConstraints { make in
            make.left.equalTo(summaryItem.snp.right)
            make.centerY.equalTo(rateV.snp.centerY)
            make.height.equalTo(42)
            make.width.equalTo(0.5)
        }

        finishItem.key = "已完成"
        baseV.addSubview(finishItem)
        finishItem.snp.makeConstraints { make in
            make.top.equalTo(rateV.snp.top)
            make.left.equalTo(summaryItem.snp.right)
            make.width.equalTo(itemWidth)
        }

        let vLine2 = UIView()
        vLine2.backgroundColor = .hex("#F5F5F5")
        addSubview(vLine2)
        vLine2.snp.makeConstraints { make in
            make.left.equalTo(finishItem.snp.right)
            make.centerY.equalTo(rateV.snp.centerY)
            make.height.equalTo(vLine1.snp.height)
            make.width.equalTo(vLine1.snp.width)
        }

        errorItem.key = "异常数"
        errorItem.valL.textColor = .hex("#F17854")
        baseV.addSubview(errorItem)
        errorItem.snp.makeConstraints { make in
            make.top.equalTo(rateV.snp.top)
            make.left.equalTo(finishItem.snp.right)
            make.width.equalTo(itemWidth)
        }

        let segmentBaseV = CornerView()
        segmentBaseV.corners = SBRectCorner(topLeft: 10, topRight: 10)
        segmentBaseV.backgroundColor = .white
        segmentBaseV.layer.masksToBounds = true
        addSubview(segmentBaseV)
        segmentBaseV.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(45)
        }

        segmentedC.tintColor = .primary
        segmentedC.underlineSelected = true
        segmentedC.segmentContentColor = .black
        segmentedC.selectedSegmentContentColor = .primary
        segmentedC.isFullLine = true
        segmentedC.backgroundColor = .white
        let normalAttrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        let highlightAttrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        let selectAttrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        segmentedC.setTitleTextAttributes(normalAttrs, for: .normal)
        segmentedC.setTitleTextAttributes(highlightAttrs, for: .highlighted)
        segmentedC.setTitleTextAttributes(selectAttrs, for: .selected)
        segmentBaseV.addSubview(segmentedC)
        segmentedC.snp.makeConstraints { (make) -> Void in
            make.top.left.right.bottom.equalToSuperview()
        }

        segmentedC.insertSegment(withTitle: "今日", at: 0)
        segmentedC.insertSegment(withTitle: "本月", at: 1)
        segmentedC.insertSegment(withTitle: "本季", at: 2)
        segmentedC.insertSegment(withTitle: "今年", at: 3)
        segmentedC.selectedSegmentIndex = 0
    }
}

extension TaskHomeView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = models[indexPath.row]
//        let cell = (tableView.dequeueReusableCell(withIdentifier: "", for: indexPath))as! TaskListCell
//        tas[indexPath.row]
        let ID: String = "SecurityTaskListCell"

        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = TaskListCell(style: .default, reuseIdentifier: ID)
        }

        (cell as? TaskListCell)?.buildModels(data: data)
        (cell as? TaskListCell)?.selectionStyle = .none
        return cell!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.5
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TaskToPatrolVC()
        getFirstViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
}

class TaskHomeItemView: UIView {

    var key: String = "" {
        didSet {
            keyL.text = key
        }
    }

    var val: String = "" {
        didSet {
            valL.text = val
        }
    }

    let keyL = UILabel()
    let valL = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        valL.text = "0"
        valL.font = .systemFont(ofSize: 20)
        valL.textAlignment = .center
        addSubview(valL)
        valL.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(18)
            make.centerX.equalTo(self.snp.centerX)
        }

        keyL.font = .systemFont(ofSize: 14)
        keyL.textColor = .hex("#ABABAB")
        addSubview(keyL)
        keyL.snp.makeConstraints { make in
            make.top.equalTo(valL.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
}

class TaskFinishRateView: UIView {
    let keyL = UILabel()
    let valL = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(withVal val: String) {
        valL.text = val
    }

    func setupUI() {
        drawBG()
        layer.masksToBounds = true
        layer.cornerRadius = 10

        valL.text = "0%"
        valL.font = .systemFont(ofSize: 24)
        valL.textColor = .white
        valL.textAlignment = .center
        valL.adjustsFontSizeToFitWidth = true
        addSubview(valL)
        valL.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(18)
            make.centerX.equalTo(self.snp.centerX)
        }

        keyL.text = "完成率"
        keyL.font = .systemFont(ofSize: 14)
        keyL.textColor = .hex("#FBCBBD")
        addSubview(keyL)
        keyL.snp.makeConstraints { make in
            make.top.equalTo(valL.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
}
