//
//  TaskAllStateCell.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/21.
//

import Foundation
import UIKit

class TaskAllStateCell: UICollectionViewCell {
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .hex("#333333")
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byCharWrapping
        return label
    }()

    var valueMainLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .hex("#0F499E")
        return label
    }()

    var valueSubLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .hex("#333333")
        return label
    }()

    var progressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: UIProgressView.Style.default)
        progress.progressTintColor = .hex("#0F499E")
        progress.trackTintColor = .hex("#F5F5F5")

        return progress
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildData(rwwcqk: RwwcqkModel) {
        if let taskName = rwwcqk.taskName {
            nameLabel.text = taskName
        }

        if let completeTotal = rwwcqk.completeTotal {
            valueMainLabel.text = String(completeTotal)
        }

        if let total = rwwcqk.total {
            valueSubLabel.text = "/" + String(total)
        }
        
        if let progress = rwwcqk.percent {
            progressView.progress = progress
        }

    }

    func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = 7
        layer.masksToBounds = true
        contentView.addSubview(nameLabel)
        contentView.addSubview(valueMainLabel)
        contentView.addSubview(valueSubLabel)
        contentView.addSubview(progressView)

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(18)
            make.left.equalTo(contentView).offset(16)
            make.right.equalTo(contentView.snp.right).offset(-10)
            make.height.equalTo(30)
        }

        valueMainLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(35)
            make.left.equalTo(contentView).offset(16)
        }

        valueSubLabel.snp.makeConstraints { make in
            make.bottom.equalTo(valueMainLabel.snp.bottom)
            make.left.equalTo(valueMainLabel.snp.right)
        }

        progressView.snp.makeConstraints { make in
            make.width.equalTo(82)
            make.height.equalTo(4)
            make.centerX.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-24)
        }
    }
}

