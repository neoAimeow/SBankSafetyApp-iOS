//
//  TaskProcessCell.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/21.
//
// https://pic2.58cdn.com.cn/nowater/webim/big/n_v2baecf076962c4c199c54c4eb1f18d5cd.png

import Foundation
import UIKit
import GradientProgressBar

class TaskProcessModal: NSObject {
    var id: Int = 0
    var title: String = ""
    var dateStr: String = ""
    var processValue: String = ""

    init(id: Int, title: String, dateStr: String, processValue: String) {
        self.id = id
        self.title = title
        self.dateStr = dateStr
        self.processValue = processValue
    }
}

class TaskProcessView: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.hex("#333333")
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()


    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.hex("#BABABA")
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    lazy var processView: GradientProgressBar = {
        let progress = GradientProgressBar()
        progress.gradientColors = [.hex("#306EC8"), .hex("#95BCF4")]
        progress.tintColor = .hex("#F8F8F8")
        progress.backgroundColor = .hex("#F8F8F8")
        progress.layer.cornerRadius = 3.5
        progress.layer.masksToBounds = true
        return progress
    }()


    lazy var processLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.hex("#BABABA")
        label.font = UIFont.systemFont(ofSize: 14)

        return label
    }()

    lazy var lineView: UIView = {
        let view = UIView.createLightLine()
        return view
    }()

    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor.white
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildData(data: TaskProcessModal) {
        titleLabel.text = data.title
        dateLabel.text = data.dateStr
        processLabel.text = String(data.processValue)
    }

    func buildPercentModel(data: WdwcqkPercentModel) {
        if let titleName = data.taskName {
            titleLabel.text = titleName
        }

        var dateStr = ""
        if let rwkssj = data.startTime {
            dateStr.append("\(rwkssj)-")
        }

        if let rwjssj = data.endTime {
            dateStr.append("\(rwjssj)")
        }
        dateLabel.text = dateStr

        if let percent = data.percent {
            processLabel.text = "\(percent)"
            processView.progress = Float(percent)
        }


    }

    func setupUI() {
        self.addSubview(titleLabel);
        self.addSubview(dateLabel);
        self.addSubview(processView)
        self.addSubview(processLabel)
        self.addSubview(lineView)

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(21)
            make.left.equalTo(self).offset(15)
        }

        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.right.equalTo(self).offset(-15)
        }

        processView.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.height.equalTo(7)
            make.right.equalTo(processLabel.snp.left).offset(-8)
        }

        processLabel.snp.makeConstraints { make in
            make.centerY.equalTo(processView)
            make.right.equalTo(self).offset(-16)
        }

        lineView.snp.makeConstraints { make in
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.top.equalTo(processView.snp.bottom).offset(16)
            make.bottom.equalTo(self)
            make.height.equalTo(0.5)
        }

    }
}

class TaskProcessCell: UITableViewCell {
    lazy var processView: TaskProcessView = {
       let view = TaskProcessView()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.addSubview(processView)
        processView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalTo(self.contentView)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildData(data: TaskProcessModal) {       
        processView.buildData(data: data)
    }
    
    
    func buildPercentModel(data: WdwcqkPercentModel) {
        processView.buildPercentModel(data: data)
    }
}
