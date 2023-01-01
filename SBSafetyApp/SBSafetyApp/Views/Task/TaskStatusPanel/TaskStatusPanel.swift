//
//  TaskStatusPanel.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/18.
//
// https://yzf.qq.com/fsna/kf-file/kf_pic/20221122/KFPIC_kfh5221fa29cfc019f_h5cded9881fc7d6fdfece5fb364b_WXIMAGE_f1ed07d10a6d42a78a5a5571fe6f95d4.png

import Foundation
import UIKit
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

protocol TaskStatusPanelDelegate: AnyObject {
    func didSelected(year: Int, quarter: Int?, month: Int?, day: Int?, dateEnum: CustomDateEnum)
    func statusPanelTaskFinishRateButtonClicked()
    func statusPanelErrorButtonClicked()
}

class TaskStatusPanel: UIView {
    var disposeBag = DisposeBag()

    weak var delegate: TaskStatusPanelDelegate?

    lazy var dateView: BSCustomDateView = {
        let view = BSCustomDateView()
        view.delegate = self
        return view
    }()

    lazy var mainDataView: TaskStatusDataView = {
        let view = TaskStatusDataView(isMainPanel: true)
        view.rx.tapGesture().when(.recognized)
                .subscribe(onNext: { [self] _ in
                    delegate?.statusPanelTaskFinishRateButtonClicked()
                })
                .disposed(by: disposeBag)

        return view
    }()

    lazy var subDataView: TaskStatusDataView = {
        let view = TaskStatusDataView(isMainPanel: false)
        view.rx.tapGesture().when(.recognized)
                .subscribe(onNext: { [self] _ in
                    delegate?.statusPanelErrorButtonClicked()
                })
                .disposed(by: disposeBag)

        return view;
    }()

    init() {
        super.init(frame: .zero)
        layer.masksToBounds = true
        layer.cornerRadius = 10
        backgroundColor = .white

        addSubview(dateView)
        addSubview(mainDataView)
        addSubview(subDataView)

        dateView.snp.makeConstraints { make in
            make.height.equalTo(42)
            make.left.equalTo(self).offset(11)
            make.right.equalTo(self).offset(-11)
            make.top.equalTo(self).offset(11)
        }

        mainDataView.snp.makeConstraints { make in
            make.top.equalTo(dateView.snp_bottomMargin).offset(20)
            make.height.equalTo(99)
            make.left.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-20)
            make.width.equalTo(163)
        }

        subDataView.snp.makeConstraints { make in
            make.top.equalTo(mainDataView)
            make.height.equalTo(99)
            make.right.equalTo(self).offset(-10)
            make.width.equalTo(163)
        }

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildData(finishRate: String?, errorCount: Int?) {
        if let finishRateValue = finishRate {
            mainDataView.buildData(data: TaskStatusData(descText: "任务完成率", dataText: "\(finishRateValue)", symbalText: "%"))
        }

        if let errorCountValue = errorCount {
            subDataView.buildData(data: TaskStatusData(descText: "当日异常数", dataText: "\(errorCountValue)", symbalText: "个"))
        }

    }
}

extension TaskStatusPanel: BSCustomDateViewDelegate {
    func didSelected(year: Int, quarter: Int?, month: Int?, day: Int?, dateEnum: CustomDateEnum) {
        delegate?.didSelected(year: year, quarter: quarter, month: month, day: day, dateEnum: dateEnum)
    }
}