//
//  TaskFinishProgressCell.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/28.
//

import Foundation
import UIKit

class TaskFinishProgressCell: UITableViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hex("#333333")
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    lazy var lineView: UIView = {
        return UIView.createLine()
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(lineView)

        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(16)
        }

        lineView.snp.makeConstraints { make in
            make.height.equalTo(0.5)
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalTo(self.contentView)
        }

    }

    func buildData(title: String) {
        titleLabel.text = title
    }

    func buildModel(model: RwwcqkModel) {
        if let deptName = model.deptName {
            titleLabel.text = deptName
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
