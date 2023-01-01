//
//  TaskListCell.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/16.
//
// https://pic6.58cdn.com.cn/nowater/webim/big/n_v240746a5286164c5ba58f1e7c3c0ba1a7.png

import Foundation
import UIKit

enum TaskStateEnum: String {
    case UnFinished = "0"
    case Finished = "1"
    case OverFinished = "2"
}

class TaskListModal: NSObject {
    var id: Int64 = 0
    var title: String = ""
    var dateStr: String = ""
    var state: TaskStateEnum
    var stateCount: Int = -1

    init(id: Int64, title: String, dateStr: String, state: TaskStateEnum, stateCount: Int) {
        self.id = id
        self.title = title
        self.dateStr = dateStr
        self.state = state
        self.stateCount = stateCount
    }
}

class TaskListCellView: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.hex("#333333")
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()

    lazy var dateIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "ic_clock")
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        return imageView;
    }()

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.hex("#BABABA")
        label.font = UIFont.systemFont(ofSize: 14)

        return label
    }()

    lazy var stateTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.hex("#B6B6B6")
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    lazy var indicatorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = UIColor.hex("#A5A5A5")
        imageView.contentMode = UIView.ContentMode.scaleAspectFit

        return imageView
    }()

    lazy var line: UIView = {
        let view = UIView.createLine()
        return view
    }()

    var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }()


    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor.white
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildData(data: TaskListModal) {
        titleLabel.text = data.title
        dateLabel.text = data.dateStr
//        switch data.state {
//        case .Finished:
//            stateTextLabel.text = "已完成"
//            stateTextLabel.textColor = UIColor.hex("#B6B6B6")
//            break
//        case .UnFinished:
//            stateTextLabel.text = "未完成"
//            stateTextLabel.textColor = UIColor.hex("#FF0000")
//            break
//        }
    }

    func buildModels(data: TaskCompleteModel) -> Void {

        if let rwmc = data.rwmc {
            titleLabel.text = rwmc
        }

        if let rwzt = data.rwzt {
            switch rwzt {
            case TaskStateEnum.Finished.rawValue:
                stateTextLabel.text = "已完成"
                stateTextLabel.textColor = UIColor.hex("#B6B6B6")
                break
            case TaskStateEnum.OverFinished.rawValue:
                stateTextLabel.text = "已完成"
                stateTextLabel.textColor = UIColor.hex("#B6B6B6")
                break
            case TaskStateEnum.UnFinished.rawValue:
                stateTextLabel.text = "未完成"
                stateTextLabel.textColor = UIColor.hex("#FF0000")
                break
            default:
                break
            }
        }

        var dateStr = ""
        if let rwkssj = data.rwkssj {
            let startDate = formatter.date(from: rwkssj)!

            dateStr.append("\(startDate.string(format: "HH:mm"))-")
        }

        if let rwjssj = data.rwjssj {
            let endDate = formatter.date(from: rwjssj)!
            dateStr.append("\(endDate.string(format: "HH:mm"))")
        }
        dateLabel.text = dateStr
    }

    func buildPercentModels(data: WdwcqkPercentModel) {
        if let taskName = data.taskName {
            titleLabel.text = taskName
        }

        if let rwzt = data.status {
            switch rwzt {
            case TaskStateEnum.Finished.rawValue:
                stateTextLabel.text = "已完成"
                stateTextLabel.textColor = UIColor.hex("#B6B6B6")
                break
            case TaskStateEnum.OverFinished.rawValue:
                stateTextLabel.text = "已完成"
                stateTextLabel.textColor = UIColor.hex("#B6B6B6")
                break
            case TaskStateEnum.UnFinished.rawValue:
                stateTextLabel.text = "未完成"
                stateTextLabel.textColor = UIColor.hex("#FF0000")
                break
            default:
                break
            }
        }

        var dateStr = ""
        if let rwkssj = data.startTime {
            dateStr.append("\(rwkssj)-")
        }

        if let rwjssj = data.endTime {
            dateStr.append("\(rwjssj)")
        }
        dateLabel.text = dateStr
    }


    func setupUI() {
        addSubview(titleLabel);
        addSubview(dateIconImageView)
        addSubview(dateLabel);
        addSubview(stateTextLabel)
        addSubview(indicatorImageView)
        addSubview(line)

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(15)
            make.left.equalTo(self).offset(10.5)
            make.right.equalTo(stateTextLabel.snp.left).offset(-20)
        }

        dateIconImageView.snp.makeConstraints { make in
            make.left.equalTo(self).offset(10.5)
            make.height.equalTo(12)
            make.width.equalTo(12)
            make.top.equalTo(titleLabel.snp.bottom).offset(7)
        }

        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(dateIconImageView)
            make.left.equalTo(dateIconImageView.snp.right).offset(5)
            make.right.equalTo(stateTextLabel.snp.left).offset(-20)
        }

        indicatorImageView.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.right.equalTo(self.snp.right).offset(-10)
            make.height.equalTo(10.5)
            make.width.equalTo(6)
        }

        stateTextLabel.snp.makeConstraints { make in
            make.centerY.equalTo(indicatorImageView)
            make.right.equalTo(indicatorImageView.snp.left).offset(-10)
            make.width.equalTo(40)
            make.height.equalTo(14)
        }

        line.snp.makeConstraints { make in
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(0.5)
            make.bottom.equalTo(self)
        }
    }
}

class TaskListCell: UITableViewCell {
    lazy var taskCell: TaskListCellView = {
        let view = TaskListCellView()
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.white
        contentView.addSubview(taskCell)
        taskCell.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(contentView)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildData(data: TaskListModal) {
        taskCell.buildData(data: data)
    }

    func buildModels(data: TaskCompleteModel) -> Void {
        taskCell.buildModels(data: data)
    }

    func buildPercentModels(data: WdwcqkPercentModel) {
        taskCell.buildPercentModels(data: data)
    }
}
