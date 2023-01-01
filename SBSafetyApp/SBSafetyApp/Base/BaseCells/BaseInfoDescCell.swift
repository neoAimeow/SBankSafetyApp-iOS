//
//  BaseInfoDescCell.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/19.
//
//

import Foundation
import UIKit

enum BaseInfoDescStyleEnum: Int {
    // https://pic1.58cdn.com.cn/nowater/webim/big/n_v23fdbf922b9fb428baf8f154acc2c8d0b.png
    case Normal = 1001
}


class BaseInfoDescModel: NSObject {
    var title: String
    var style: BaseInfoDescStyleEnum
    var detail: String
    
    init(style: BaseInfoDescStyleEnum, title: String, detail: String) {
        self.title = title
        self.detail = detail
        self.style = style
    }
}

class BaseInfoDescCell: UITableViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var detailLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var stateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var indicateImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage.init(systemName: "chevron.right"))
        return imageView
    }()
    
    override init( style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(detailLabel)
        self.contentView.addSubview(stateLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentView).offset(18)
            make.left.equalTo(self.contentView).offset(16)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp_bottomMargin).offset(12)
        }
        
        stateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView)
        }
    }
    
    func buildData(model: BaseInfoDescModel, isHighlight: Bool) {
        
        titleLabel.text = model.title
        detailLabel.text = model.detail
        
        switch(model.style) {
        case BaseInfoDescStyleEnum.Normal:
            titleLabel.textColor = UIColor.hex("#333333")
            titleLabel.font = UIFont.systemFont(ofSize: 17)
            
            detailLabel.textColor = UIColor.hex("#ACACAC")
            detailLabel.font = UIFont.systemFont(ofSize: 14)
            
            stateLabel.font = UIFont.systemFont(ofSize: 15)
            
            stateLabel.textColor = isHighlight ? .hex("#FF0000"): .hex("#0FA404")
        
            indicateImageView.tintColor = .hex("#A5A5A5")
            addSubview(indicateImageView)
            indicateImageView.snp.makeConstraints { make in
                make.centerY.equalTo(self.contentView)
                make.right.equalTo(self.contentView).offset(-15)
            }
            
            stateLabel.snp.makeConstraints { make in
                make.right.equalTo(self.indicateImageView.snp_leftMargin).offset(-11)
            }
            
            break;
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
