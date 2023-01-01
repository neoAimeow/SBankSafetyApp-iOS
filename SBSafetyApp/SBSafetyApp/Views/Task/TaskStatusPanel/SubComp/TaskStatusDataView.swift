//
//  TaskStatusDataView.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/18.
//
// https://pic6.58cdn.com.cn/nowater/webim/big/n_v2f03cf523349e4c74a3fad16de95ab6a0.png

import Foundation
import UIKit

class TaskStatusData: NSObject {
    var descText: String = ""
    var dataText: String = ""
    var symbalText: String = ""
    
    init(descText: String, dataText: String, symbalText: String) {
        self.descText = descText
        self.dataText = dataText
        self.symbalText = symbalText
    }
}

class TaskStatusDataView: UIView {
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .hex("FBFBFB")
        return imageView
    }()
    
    
    lazy var dataLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    lazy var dataSymbolLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
        
    } ()
    
    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .hex("#333333")
        return label
    } ()
    
    
    init(isMainPanel: Bool) {
        super.init(frame: .zero)
        setupUI(isMainPanel: isMainPanel);
    }
    
    func buildData(data: TaskStatusData) {
        dataLabel.text = data.dataText
        dataSymbolLabel.text = data.symbalText
        detailLabel.text = data.descText
//        self.sesetNeedsUpdateConstraints
        self.setNeedsUpdateConstraints()
        self.updateConstraintsIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(isMainPanel: Bool) {
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        self.backgroundColor = .randomColor
        
        if (isMainPanel) {
            dataLabel.textColor = .hex("#0F499E")
            dataSymbolLabel.textColor = .hex("#BEBEBE")
            detailLabel.textColor = .hex("#333333")
        } else {
            dataLabel.textColor = .hex("#FFFFFF")
            dataSymbolLabel.textColor = .hex("#FFFFFF")
            detailLabel.textColor = .hex("#FFFFFF")
            backgroundImageView.image = UIImage.init(named: "task_data_background")
        }
        
        addSubview(backgroundImageView)
        backgroundImageView.addSubview(dataLabel)
        backgroundImageView.addSubview(dataSymbolLabel)
        backgroundImageView.addSubview(detailLabel)
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        dataLabel.snp.makeConstraints { make in
            make.left.equalTo(backgroundImageView).offset(31)
            make.top.equalTo(backgroundImageView).offset(30)
        }
        
        dataSymbolLabel.snp.makeConstraints { make in
            make.left.equalTo(dataLabel.snp_rightMargin).offset(8)
            make.bottom.equalTo(dataLabel).offset(-2)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.left.equalTo(dataLabel)
            make.bottom.equalTo(backgroundImageView.snp_bottomMargin).offset(-20)
        }
    }

}
