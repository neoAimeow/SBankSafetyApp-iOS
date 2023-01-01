//
//  SecurityPanelView.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/16.
// https://pic6.58cdn.com.cn/nowater/webim/big/n_v299977239eaf44145b5e4c42417f241db.png

import Foundation
import UIKit
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif


protocol SecurityHomePanelTapDelegate: AnyObject {
    func taskItemTapped()
    func checkInItemTapped()
    func statisticsItemTapped()
}

class SecurityHomePanelItemView: UIView {
    typealias SecurityTapClosure = () -> Void
    var disposeBag = DisposeBag()

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        return imageView;
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.hex("#666666")
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    init(imageName: String, title: String, tapClosure: @escaping SecurityTapClosure) {
        super.init(frame: .zero)
        imageView.image = UIImage.init(named: imageName)
        titleLabel.text = title
        addSubview(imageView)
        addSubview(titleLabel)

        let gesture = UITapGestureRecognizer()
        gesture.rx.event.subscribe(onNext: { _ in
                    tapClosure()
                })
                .disposed(by: disposeBag)
        self.addGestureRecognizer(gesture);

        self.snp.makeConstraints { make in
            make.width.equalTo(55)
            make.height.equalTo(80)
        }

        imageView.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.width.equalTo(55)
            make.centerX.equalTo(self)
        }

        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self)
//            make.top.equalTo(imageView.snp_bottomMargin).offset(12)
            make.centerX.equalTo(self)
            make.height.equalTo(13)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class SecurityHomePanelView: UIView {
    weak var delegate: SecurityHomePanelTapDelegate?

    lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "security_home_panel")
        imageView.contentMode = UIView.ContentMode.scaleToFill
        imageView.backgroundColor = UIColor.randomColor
        imageView.layer.masksToBounds = true
        return imageView;
    }()

    lazy var panelView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        let taskViewItem = SecurityHomePanelItemView(imageName: "task_list_operator", title: "任务列表") {
            self.delegate?.taskItemTapped()
        }
        let checkInItem = SecurityHomePanelItemView(imageName: "check_operator", title: "签到") {
            self.delegate?.checkInItemTapped()
        }
        let statisticsItem = SecurityHomePanelItemView(imageName: "statistics_operator", title: "考勤统计") {
            self.delegate?.statisticsItemTapped()
        }

        view.addSubview(taskViewItem)
        view.addSubview(checkInItem)
        view.addSubview(statisticsItem)

        taskViewItem.snp.makeConstraints { make in
            make.centerY.equalTo(view)
            make.left.equalTo(view).offset(34.5)
        }

        checkInItem.snp.makeConstraints { make in
            make.center.equalTo(view)
        }

        statisticsItem.snp.makeConstraints { make in
            make.centerY.equalTo(view)
            make.right.equalTo(view.snp_rightMargin).offset(-34.5)
        }
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(coverImageView)
        addSubview(panelView)

        coverImageView.snp.makeConstraints { make in
            make.height.equalTo(246)
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
        }

        panelView.snp.makeConstraints { make in
            make.top.equalTo(coverImageView.snp_bottomMargin)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(155.5)
            make.bottom.equalTo(self.snp_bottomMargin)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

