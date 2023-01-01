//
//  BaseInfoCell.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/19.
//

import Foundation
import UIKit


enum BaseInfoStyleEnum: Int {
    // https://pic4.58cdn.com.cn/nowater/webim/big/n_v2e7c11c6f10a245519118f4f1774d6798.png
    case Normal = 1001
    // https://pic2.58cdn.com.cn/nowater/webim/big/n_v291338bf2bf144a80ac6d2d6aaf1b4501.png
    case Style1 = 1002
}

enum BaseInfoStatesEnum: String {
    case Error = "0"
    case Normal = "1"
    case UnFinish = "2"
}

class BaseInfoModel: NSObject {
    var title: String
    var style: BaseInfoStyleEnum
    var detail: String?

    init(style: BaseInfoStyleEnum, title: String) {
        self.title = title
        self.style = style
    }

    init(style: BaseInfoStyleEnum, title: String, detail: String?) {
        self.title = title
        self.detail = detail
        self.style = style
    }
}

class BaseInfoCell: UITableViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var detailLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var indicateImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage.init(systemName: "chevron.right"))
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(detailLabel)

        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(16)
        }

        detailLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(self.contentView).offset(-15)
        }
    }

    func buildData(model: BaseInfoModel, status: BaseInfoStatesEnum.RawValue?) {

        titleLabel.text = model.title
        detailLabel.text = model.detail

        switch (model.style) {
        case BaseInfoStyleEnum.Normal:
            titleLabel.textColor = UIColor.hex("#666666")
            titleLabel.font = UIFont.systemFont(ofSize: 15)

            detailLabel.textColor = UIColor.hex("#000000")
            detailLabel.font = UIFont.systemFont(ofSize: 16)
            break;
        case BaseInfoStyleEnum.Style1:

            titleLabel.textColor = UIColor.hex("#333333")
            titleLabel.font = UIFont.systemFont(ofSize: 17)

            if let taskStatus = status {
                if (taskStatus == BaseInfoStatesEnum.UnFinish.rawValue) {
                    detailLabel.textColor = UIColor.hex("#FF0000")
                    detailLabel.text = "未完成"

                } else if taskStatus == BaseInfoStatesEnum.Normal.rawValue {
                    detailLabel.textColor = UIColor.hex("#B6B6B6")
                    detailLabel.text = "已完成"
                } else {
                    detailLabel.textColor = UIColor.hex("#FF0000")
                    detailLabel.text = "异常"
                }
            }

            detailLabel.font = UIFont.systemFont(ofSize: 15)
            break;
        }


    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
