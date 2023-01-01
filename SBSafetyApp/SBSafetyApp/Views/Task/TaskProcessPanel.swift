//
//  TaskProcessPanel.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/17.
//
// https://yzf.qq.com/fsna/kf-file/kf_pic/20221121/KFPIC_kfh5221fa29cfc019f_h5cded9881fc7d6fdfece5fb364b_WXIMAGE_461691ec2c2e4430b1044c82fafac3a7.png

import Foundation
import UIKit
import GradientProgressBar

class TaskProcessPanelDataView: UIView {

    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .hex("#FFFFFF")
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()

    lazy var subLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    init() {
        super.init(frame: .zero)
        addSubview(titleLabel)
        addSubview(subLabel)

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.centerX.equalTo(self)
        }

        subLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildData(title: String, subTitle: String) {
        titleLabel.text = title
        subLabel.text = subTitle
    }

}

class TaskProcessPanelModel: NSObject {
    var taskName: String = ""
    var processValue: Float = 0.0
    var timeStr: String = ""
    var finishCount: Int = 0
    var unfinishCount: Int = 0

    init(taskName: String, processValue: Float, timeStr: String, finishCount: Int, unfinishCount: Int) {
        self.taskName = taskName
        self.processValue = processValue
        self.timeStr = timeStr
        self.finishCount = finishCount
        self.unfinishCount = unfinishCount
    }
}

class TaskProcessPanel: UIView {

    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage.init(named: "task_process_background"))
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()

    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage.init(named: "task_process_icon"))
        return imageView
    }()

    lazy var taskNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "在岗签到-保安员"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        return label
    }()

    lazy var processView: GradientProgressBar = {
        let progress = GradientProgressBar()
        progress.gradientColors = [.hex("#277DDA"), .hex("#FFFFFF")]
        progress.tintColor = .hex("#216BCA")
        progress.backgroundColor = .hex("#216BCA")
        progress.layer.cornerRadius = 5
        progress.layer.masksToBounds = true
        return progress
    }()

    lazy var processLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label

    }()

    lazy var timeDataView: TaskProcessPanelDataView = {
        let view = TaskProcessPanelDataView()
        return view
    }()

    lazy var finishDataView: TaskProcessPanelDataView = {
        let view = TaskProcessPanelDataView()
        return view
    }()

    lazy var unfinishDataView: TaskProcessPanelDataView = {
        let view = TaskProcessPanelDataView()
        return view
    }()

    init() {
        super.init(frame: .zero)
        addSubview(backgroundImageView)
        backgroundImageView.addSubview(iconImageView)
        backgroundImageView.addSubview(taskNameLabel)
        backgroundImageView.addSubview(processLabel)
        backgroundImageView.addSubview(processView)
        backgroundImageView.addSubview(timeDataView)
        backgroundImageView.addSubview(finishDataView)
        backgroundImageView.addSubview(unfinishDataView)

        let arrView = [timeDataView, finishDataView, unfinishDataView]

        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }

        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView).offset(18)
            make.left.equalTo(backgroundImageView).offset(20)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }

        taskNameLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView)
            make.left.equalTo(iconImageView.snp_rightMargin).offset(11)
        }

        processView.snp.makeConstraints { make in
            make.top.equalTo(taskNameLabel.snp_bottomMargin).offset(11)
            make.left.equalTo(taskNameLabel)
            make.right.equalTo(processLabel.snp_leftMargin).offset(-10)
            make.height.equalTo(10)
        }

        processLabel.snp.makeConstraints { make in
            make.centerY.equalTo(processView)
            make.right.equalTo(backgroundImageView.snp_rightMargin).offset(-30)
        }

        arrView.snp.distributeViewsAlong(axisType: .horizontal, fixedSpacing: 0, leadSpacing: 20, tailSpacing: 20)
        arrView.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundImageView.snp_bottomMargin).offset(-10)
            make.height.equalTo(35)
        }
    }

    func buildData(withModel model: TaskProcessPanelModel) {
        timeDataView.buildData(title: "规定时间", subTitle: model.timeStr)
        finishDataView.buildData(title: "已完成", subTitle: String(model.finishCount))
        unfinishDataView.buildData(title: "未完成", subTitle: String(model.unfinishCount))
        processLabel.text = "\(model.processValue)%"
        processView.progress = model.processValue
        taskNameLabel.text = model.taskName
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
