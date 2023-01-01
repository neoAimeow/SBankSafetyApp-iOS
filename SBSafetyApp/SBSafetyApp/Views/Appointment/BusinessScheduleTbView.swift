//
//  BusinessScheduleTbView.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/22.
// 营业日历表

import Foundation
import UIKit

#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

class BusinessScheduleTbViewModel {
    private var disposeBag = DisposeBag()
    public let calendarStateModel: PublishSubject<CalendarByStateModel> = PublishSubject();

    public let loading: PublishSubject<Bool> = PublishSubject()

    public func requestData(param: CalendarByStateParam) {
        loading.onNext(false)
        API.calendarByState(withParam: param).subscribe { [self] event in
                    if let byState = event.element?.model {
                        calendarStateModel.onNext(byState)
                    }
                }
                .disposed(by: disposeBag)
    }
}


class BusinessScheduleTbView: UIView {
    var disposeBag = DisposeBag()

    lazy var calendarView: BSCalendarView = {
        let view = BSCalendarView()
        view.delegate = self
        return view
    }()

    lazy var openNumLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hex("#306EC7")
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    lazy var closeNumLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hex("#F17854")
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()


    lazy var openGesView: UIView = {
        let view = UIView()
        let icImageView = UIImageView(image: UIImage(named: "ic_biz_blue"))
        let titleLabel = UILabel()
        titleLabel.text = "营业网点"
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = .hex("#333333")
        let indicatorImageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        indicatorImageView.tintColor = .hex("#979797")

        view.addSubview(icImageView)
        view.addSubview(titleLabel)
        view.addSubview(openNumLabel)
        view.addSubview(indicatorImageView)

        icImageView.snp.makeConstraints { make in
            make.width.height.equalTo(23)
            make.centerY.equalTo(view)
            make.left.equalTo(view).offset(20)
        }

        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(view)
            make.left.equalTo(icImageView.snp.right).offset(10)

        }

        openNumLabel.snp.makeConstraints { make in
            make.centerY.equalTo(view)
            make.right.equalTo(indicatorImageView.snp.left).offset(-20)
        }

        indicatorImageView.snp.makeConstraints { make in
            make.centerY.equalTo(view)
            make.right.equalTo(view).offset(-21)
            make.height.equalTo(11)
            make.width.equalTo(6)

        }

        return view
    }()

    lazy var closeGesView: UIView = {
        let view = UIView()
        let icImageView = UIImageView(image: UIImage(named: "ic_biz_orag"))
        let titleLabel = UILabel()
        titleLabel.text = "不营业网点"
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = .hex("#333333")

        let indicatorImageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        indicatorImageView.tintColor = .hex("#979797")

        view.addSubview(icImageView)
        view.addSubview(titleLabel)
        view.addSubview(closeNumLabel)
        view.addSubview(indicatorImageView)

        icImageView.snp.makeConstraints { make in
            make.width.height.equalTo(23)
            make.centerY.equalTo(view)
            make.left.equalTo(view).offset(20)
        }

        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(view)
            make.left.equalTo(icImageView.snp.right).offset(10)

        }

        closeNumLabel.snp.makeConstraints { make in
            make.centerY.equalTo(view)
            make.right.equalTo(indicatorImageView.snp.left).offset(-20)
        }

        indicatorImageView.snp.makeConstraints { make in
            make.centerY.equalTo(view)
            make.right.equalTo(view).offset(-21)
            make.height.equalTo(11)
            make.width.equalTo(6)

        }

        return view
    }()

    lazy var operatorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.backgroundColor = .white

        let line = UIView.createLightLine()

        view.addSubview(closeGesView)
        view.addSubview(line)
        view.addSubview(openGesView)

        closeGesView.rx.tapGesture().when(.recognized)
                .subscribe(onNext: { _ in
                    let vc = SalesNetworkVC(withDeptId: self.deptId, deptName: self.deptName)
                    vc.segmentedControl.selectedSegmentIndex = 0
                    self.getFirstViewController()?.navigationController?.pushViewController(vc, animated: true)
                })
                .disposed(by: disposeBag)


        openGesView.rx.tapGesture().when(.recognized)
                .subscribe(onNext: { _ in
                    let vc = SalesNetworkVC(withDeptId: self.deptId, deptName: self.deptName)
                    vc.segmentedControl.selectedSegmentIndex = 1
                    self.getFirstViewController()?.navigationController?.pushViewController(vc, animated: true)
                })
                .disposed(by: disposeBag)

        closeGesView.snp.makeConstraints { make in
            make.height.equalTo(63)
            make.left.right.top.equalTo(view)
        }

        line.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.top.equalTo(closeGesView.snp.bottom)
            make.height.equalTo(0.5)
        }
//
        openGesView.snp.makeConstraints { make in
            make.height.equalTo(63)
            make.top.equalTo(closeGesView.snp.bottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(view)
        }


        return view
    }()

    let viewModel = BusinessScheduleTbViewModel()
    var deptId: Int64?
    var deptName: String?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .bg

        viewModel.calendarStateModel
                .observe(on: MainScheduler.instance)
                .subscribe { [self] event in
                    if let element = event.element {
                        if let unWorkTotalValue = element.unWorkTotal {
                            closeNumLabel.text = "\(unWorkTotalValue)"
                        }

                        if let workTotalValue = element.workTotal {
                            openNumLabel.text = "\(workTotalValue)"
                        }
                    }
                }
                .disposed(by: disposeBag)


        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func requestData() {
        viewModel.requestData(param: CalendarByStateParam(deptId: deptId ?? BSUser.currentUser.deptId, workDate: Date().string(format: "yyyy-MM-dd")))
    }

    func setupUI() {
        addSubview(calendarView)
        addSubview(operatorView)


        calendarView.snp.makeConstraints { make in
            make.top.left.right.equalTo(self)
            make.height.equalTo(370)
        }

        operatorView.snp.makeConstraints { make in
            make.top.equalTo(calendarView.snp.bottom)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
        }
    }
}

extension BusinessScheduleTbView: BSCalendarDelegate {
    func calendar(didSelectDate date: Date) {
        viewModel.requestData(param: CalendarByStateParam(deptId: deptId ?? BSUser.currentUser.deptId, workDate: date.string(format: "yyyy-MM-dd")))
    }
    
    
}
