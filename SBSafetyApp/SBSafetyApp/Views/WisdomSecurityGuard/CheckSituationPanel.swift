//
// Created by Aimeow on 2022/12/1.
//

import Foundation
import Foundation
import UIKit

class CheckSituationModel: NSObject {
    var situationValue: String = ""
    var checkValue: String = ""
    var uncheckValue: String = ""

    init(situationValue: String, checkValue: String, uncheckValue: String) {
        super.init()
        self.situationValue = situationValue
        self.checkValue = checkValue
        self.uncheckValue = uncheckValue
    }
}

class CheckSituationPanel: UIView {
    lazy var situationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hex("#333333")
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "签到完成情况"
        return label
    }()

    lazy var situationValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hex("#3C72FF")
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()

    lazy var checkTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "签到"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .hex("#999999")
        return label
    }()

    lazy var checkTitleValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .hex("#010101")
        return label
    }()

    lazy var uncheckLabel: UILabel = {
        let label = UILabel()
        label.text = "未签到"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .hex("#999999")
        return label
    }()

    lazy var uncheckValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .hex("#F17854")
        return label
    }()

    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor.white
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        layer.masksToBounds = true
        layer.cornerRadius = 7

        addSubview(situationLabel)
        addSubview(situationValueLabel)
        addSubview(checkTitleLabel)
        addSubview(checkTitleValueLabel)
        addSubview(uncheckLabel)
        addSubview(uncheckValueLabel)

        situationLabel.snp.makeConstraints { make in
            make.left.equalTo(self).offset(22)
            make.top.equalTo(self).offset(20)
        }

        situationValueLabel.snp.makeConstraints { make in
            make.left.equalTo(self).offset(22)
            make.top.equalTo(situationLabel.snp.bottom).offset(15)
        }

        checkTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(self).offset(22)
            make.top.equalTo(situationValueLabel.snp.bottom).offset(33)
        }

        checkTitleValueLabel.snp.makeConstraints { make in
            make.left.equalTo(self).offset(22)
            make.top.equalTo(checkTitleLabel.snp.bottom).offset(15)
        }

        uncheckLabel.snp.makeConstraints { make in
            make.right.equalTo(self).offset(-90)
            make.top.equalTo(checkTitleLabel)
        }

        uncheckValueLabel.snp.makeConstraints { make in
            make.top.equalTo(checkTitleValueLabel)
            make.left.equalTo(uncheckLabel)
        }
    }

    func buildModel(model: CheckSituationModel) {
        situationValueLabel.text = model.situationValue
        checkTitleValueLabel.text = model.checkValue
        uncheckValueLabel.text = model.uncheckValue
    }
}
