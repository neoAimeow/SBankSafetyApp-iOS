//
//  TaskOutletStatusSubView.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/21.
//

import Foundation
import UIKit

class TaskOutletStatusSubView: UIView {
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .hex("#000000")
        return label
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hex("#ABABAB")
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildData(value: Int, title: String) {
        valueLabel.text = String(value);
        titleLabel.text = title;
    }

    func setupUI() {
        addSubview(valueLabel)
        addSubview(titleLabel)
        valueLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(24)
        }

        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-24)
        }
    }
}
