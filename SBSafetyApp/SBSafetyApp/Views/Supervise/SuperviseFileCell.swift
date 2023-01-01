//
//  SuperviseFileCell.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/22.
//

import Foundation
import UIKit

class SuperviseFileModel: NSObject {
    var title: String = ""
    var dateStr: String = ""
}

enum SuperviseFileStyleEnum: Int {
    case Folder = 3001
    case File = 3002
}

class SuperviseFileCell: UITableViewCell {
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        return imageView
    }()

    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .hex("#333333")
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .hex("#A4A4A4")
        return label
    }()
    
    lazy var indicatorImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage.init(named: "chevron.right"))
        imageView.tintColor = .hex("#AFAFAF")
        return imageView
    }()
    
    
    override init( style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.addSubview(iconImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(indicatorImageView)
        
        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(self.contentView).offset(16)
            make.left.equalTo(self.contentView).offset(10)
            make.height.equalTo(24)
            make.width.equalTo(19)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentView)
            make.left.equalTo(iconImageView.snp.right).offset(11)
            
        }
        
        dateLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.bottom.equalTo(self.contentView).offset(25)
        }
        
        indicatorImageView.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(self.contentView.snp.right).offset(10)
        }
    }
    
    func buildData(style:SuperviseFileStyleEnum, model: SuperviseFileModel) {
        titleLabel.text = model.title
        dateLabel.text = model.dateStr
        switch(style) {
            case SuperviseFileStyleEnum.Folder:
            
            break;
            case SuperviseFileStyleEnum.File:
            break;
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
