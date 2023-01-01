//
//  AppointmentManagerVC.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/28.
// 履职管理 -
// https://lanhuapp.com/web/#/item/project/detailDetach?pid=dfb891ac-ad36-4690-8064-0bc7fb659321&image_id=a726cab1-f4f2-4cda-aee2-d0e8cf51437f&tid=100f38f4-ed33-4ec2-83a2-6f98243d58d3&project_id=dfb891ac-ad36-4690-8064-0bc7fb659321&fromEditor=true&type=set

import Foundation
import UIKit
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif
import JFPopup

class AppointmentManagerViewModel {
    public let yyxgjlModel: PublishSubject<[YyxgjlModel]> = PublishSubject();
    public let byStateModel: PublishSubject<CalendarByStateModel> = PublishSubject();
    
    public let loading: PublishSubject<Bool> = PublishSubject()
    private let disposeBag = DisposeBag()

    public func requestData(deptId: Int64, workDate: String) {
        loading.onNext(false)
        Observable.zip(
                        API.yyxgjl(withParam: YyxgjlParam(deptId: deptId, workDate: workDate, pageNum: 0, pageSize: 50)),
                        API.calendarByState(withParam: CalendarByStateParam(deptId: deptId, workDate: workDate)))
                .subscribe(onNext: { [self] (yyxgjl, bystate) in
                    loading.onNext(true)

                    if let yyxgjlUnWrap = yyxgjl.models {
                        var arr: Array<YyxgjlModel> = []
                        for item in yyxgjlUnWrap {
                            if let item {
                                arr.append(item)
                            }
                        }
                        yyxgjlModel.onNext(arr)
                    }
                    
                    if let bystateUnWrap = bystate.model {
                        byStateModel.onNext(bystateUnWrap)
                    }

                }, onError: { error in

                })
                .disposed(by: disposeBag)
    }

    public func requestYyxgjl(deptId: Int64, workDate: String) {
        loading.onNext(false)
        API.yyxgjl(withParam: YyxgjlParam(deptId: deptId, workDate: workDate, pageNum: 0, pageSize: 50)).subscribe { [self] model in
                    loading.onNext(true)
            if let yyxgjlUnWrap = model.element?.models {
                        var arr: Array<YyxgjlModel> = []
                        for item in yyxgjlUnWrap {
                            if let item {
                                arr.append(item)
                            }
                        }
                        yyxgjlModel.onNext(arr)
                    }
                }
                .disposed(by: disposeBag)
    }

}

class AppointmentManagerVC: SubLevelViewController {
    var disposeBag = DisposeBag()

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()

    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var calendarView: BSCalendarView = {
        let view = BSCalendarView()
        view.delegate = self
        return view
    }()

    lazy var mutationButton: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8
        view.backgroundColor = .white

        let icImageView = UIImageView(image: UIImage.init(named: "ic_calendar"))
        icImageView.contentMode = UIView.ContentMode.scaleAspectFill

        let updateLabel = UILabel()
        updateLabel.textColor = .hex("#9A9A9A")
        updateLabel.font = UIFont.systemFont(ofSize: 15)
        updateLabel.text = "修改"

        view.addSubview(icImageView)
        view.addSubview(mutationDateLabel)
        view.addSubview(stateLabel)
        view.addSubview(updateLabel)

        icImageView.snp.makeConstraints { make in
            make.left.equalTo(view).offset(20)
            make.height.width.equalTo(20)
            make.centerY.equalTo(view)
        }

        mutationDateLabel.snp.makeConstraints { make in
            make.left.equalTo(icImageView.snp.right).offset(24)
            make.centerY.equalTo(view)
        }

        stateLabel.snp.makeConstraints { make in
            make.left.equalTo(mutationDateLabel.snp.right).offset(35)
            make.centerY.equalTo(view)
        }

        updateLabel.snp.makeConstraints { make in
            make.right.equalTo(view).offset(-20)
            make.centerY.equalTo(view)
        }
        
        view.rx.tapGesture().when(.recognized)
                .subscribe(onNext: { _ in
                    var config: JFPopupConfig = .dialog
                    config.isDismissible = false
                    config.enableDrag = false
                    config.toastPosition = .center
                    
                    self.popup.custom(with: config) {
                        let v = NetworkStateEditPopup(frame: CGRect(x: 0, y: 0, width: ScreenWidth - 50, height: 302))
                        v.delegate = self
                        v.buildData(dateStr: self.calendarView.selectDate.string(format: "yyyy年MM月dd日"))
                        return v
                    }

                })
                .disposed(by: disposeBag)

        return view
    }()

    lazy var mutationDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .hex("#000000")
        return label
    }()

    lazy var stateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .hex("#306EC8")
        label.text = "营业"
        return label
    }()

    lazy var updatePanel: UpdateHistoryPanel = {
        let panel = UpdateHistoryPanel()
        panel.delegate = self
        return panel
    }()

    var historyModels: [UpdateHistoryModal] = [
       
    ]
    
    let viewModel = AppointmentManagerViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "履职管理"
        view.backgroundColor = .bg
        mutationDateLabel.text = Date().string(format: "yyyy年MM月dd日")
        viewModel.yyxgjlModel
                .observe(on: MainScheduler.instance)
                .subscribe {  event in
                    var arr:[UpdateHistoryModal] = []
                    if let models = event.element {
                        for model in models {
                            print(model)
                            arr.append(
                                UpdateHistoryModal(id: model.id, avatarUrls: "", nickName: model.xgrmc, dateStr: model.xgrq, state: model.yyzt == "1" ? UpdateHistoryStateEnum.open: UpdateHistoryStateEnum.close))
                        }
                    }
                    self.historyModels = arr
                    self.updatePanel.buildData(models: self.historyModels)
                }
                .disposed(by: disposeBag)

        viewModel.requestData(deptId: deptId ?? BSUser.currentUser.deptId, workDate: calendarView.selectDate.string(format: "yyyy-MM-dd"))
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    var menuItems: [UIAction] {
        return [
            UIAction(title: "周营业日", handler: { (_) in
                self.navigationController?.pushViewController(WeekBizDateEditVC(), animated: true)
            }),
            UIAction(title: "月营业日", handler: { (_) in
                self.navigationController?.pushViewController(UpdateBusinessDateVC(), animated: true)
            })
        ]
    }

    var menu: UIMenu {
        return UIMenu(title: "批量修改", image: nil, identifier: nil, options: [], children: menuItems)
    }

    func setupUI() {
        let rightBtn = UIBarButtonItem(title: "批量修改", image: nil, primaryAction: nil, menu: menu)
        rightBtn.tintColor = UIColor.hex("#306EC8")
        navigationItem.rightBarButtonItem = rightBtn


        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(calendarView)
        contentView.addSubview(mutationButton)
        contentView.addSubview(updatePanel)

        updatePanel.buildData(models: historyModels)

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.bottom.equalTo(view)
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(ScreenWidth)
        }

        calendarView.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.left.right.equalTo(contentView)
        }

        mutationButton.snp.makeConstraints { make in
            make.top.equalTo(calendarView.snp.bottom).offset(30)
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
            make.height.equalTo(75)
        }

        updatePanel.snp.makeConstraints { make in
            make.top.equalTo(mutationButton.snp.bottom).offset(10)
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
            make.bottom.equalTo(contentView).offset(-10)
        }
    }

    @objc func titleBarButtonItemMethod() {

    }

}

extension AppointmentManagerVC: UpdateHistoryPanelDelegate {
    func historyCellClicked(model: UpdateHistoryModal) {
        let vc = EditHistoryVC(withDeptId: self.deptId, deptName: deptName)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension AppointmentManagerVC: NetworkStateEditPopupDelegate {
    func editPopupCancelButtonClicked() {
        
    }
    
    func editPopupSubmitButtonClicked(isOpen: Bool, text: String) {
        API.xgyyzt(withParam: XgyyztParam(deptId: self.deptId ?? BSUser.currentUser.deptId, month: nil, remark: text, status: isOpen ? "1" : "0", type: "day", workDates: calendarView.selectDate.string(format: "yyyy-MM-dd"), year: nil)) { responseModel in
            Utils.app.window?.showToast(witMsg: "修改成功")
        }
    }
}

extension AppointmentManagerVC: BSCalendarDelegate {
    func calendar(didSelectDate date: Date) {
        mutationDateLabel.text = date.string(format: "yyyy年MM月dd日")
        viewModel.requestData(deptId: deptId ?? BSUser.currentUser.deptId, workDate: date.string(format: "yyyy-MM-dd"))
    }
}
