//
//  SalesNetworkCell.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/28.
//


import Foundation
import UIKit

class SaleNetworkModel: NSObject {
    var title: String
    var detail: String

    init(title: String, detail: String) {
        self.title = title
        self.detail = detail
    }
}

class SaleNetworkCell: UITableViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hex("#333333")
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hex("#696A6C")
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    lazy var indicatorImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage.init(systemName: "chevron.right"))
        imageView.tintColor = .hex("#A5A5A5")
        return imageView
    }()

    lazy var lineView: UIView = {
        return UIView.createLine()
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(detailLabel)
        self.contentView.addSubview(indicatorImageView)
        self.contentView.addSubview(lineView)

        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(16)
        }

        detailLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.right.equalTo(indicatorImageView.snp.left).offset(-20)
        }

        indicatorImageView.snp.makeConstraints { make in
            make.width.equalTo(6)
            make.height.equalTo(11)
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).offset(15)
        }

        lineView.snp.makeConstraints { make in
            make.height.equalTo(0.5)
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalTo(contentView)
        }

    }

    func buildData(title: String?) {
        if let titleValue = title {
            titleLabel.text = titleValue
        }

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
