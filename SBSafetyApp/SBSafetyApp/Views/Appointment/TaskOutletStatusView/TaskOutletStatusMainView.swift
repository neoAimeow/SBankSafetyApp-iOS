//
//  TaskOutletStatusSubView.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/21.
//

import Foundation
import UIKit

class TaskOutletStatusMainView: UIView {
    lazy var mainView: UIView = {
        let view = UIView()
        let bgImageView = UIImageView()
        bgImageView.image = UIImage.init(named: "task_data_background")
        bgImageView.contentMode = UIView.ContentMode.topLeft
        view.addSubview(bgImageView)

        view.layer.masksToBounds = true
        view.layer.cornerRadius = 7

        view.backgroundColor = .randomColor
        let tempView = UIView()
        tempView.addSubview(finishRateValueLabel)
        tempView.addSubview(finishRateSymbolLabel)
        tempView.backgroundColor = .randomColor

        bgImageView.addSubview(tempView)
        bgImageView.addSubview(finishRateTitleLabel)

        bgImageView.snp.makeConstraints { make in
            make.top.right.bottom.left.equalTo(view)
        }

        finishRateValueLabel.snp.makeConstraints { make in
            make.top.left.equalTo(tempView)
            make.height.equalTo(20)
        }

        finishRateSymbolLabel.snp.makeConstraints { make in
            make.left.equalTo(finishRateValueLabel.snp.right).offset(3)
            make.bottom.equalTo(finishRateValueLabel).offset(2)
            make.right.equalTo(tempView)
        }

        tempView.snp.makeConstraints { make in
            make.centerX.equalTo(bgImageView)
            make.top.equalTo(20)
        }

        finishRateTitleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(bgImageView)
            make.bottom.equalTo(view).offset(-20)
        }

        return view
    }()

    lazy var finishRateValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hex("#FFFFFF")
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()

    lazy var finishRateSymbolLabel: UILabel = {
        let label = UILabel()
        label.text = "%"
        label.textColor = .hex("#FFFFFF")
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()

    lazy var finishRateTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hex("#FBCBBD")
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildData(value: String, title: String) {
        finishRateValueLabel.text = value
        finishRateTitleLabel.text = title;
    }

    func setupUI() {
        addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }

    }
}
