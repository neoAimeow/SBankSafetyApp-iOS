//
//  SecurityHomeCheckInCell.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/16.
//
// https://pic2.58cdn.com.cn/nowater/webim/big/n_v23cc162a5bc8c49cc821ae8f951ee1c80.png

import Foundation
import UIKit

class CheckInListModel: NSObject {
    var timeStr: String = ""
    var checkInStateStr: String = ""
    var address: String = ""
    var subBranchStr: String
    
    init(timeStr: String, checkInStateStr: String, address: String, subBranchStr: String) {
        self.timeStr = timeStr
        self.checkInStateStr = checkInStateStr
        self.address = address
        self.subBranchStr = subBranchStr
    }
}

class SecurityCheckInCell: UIView {
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "14:24"
        return label
    }()
    
    lazy var checkInStateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "签到"
        return label
    }()
    
    lazy var addressIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage.init(named: "ic_loc"))
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        return imageView;
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "上海市浦东新区银城中路111号"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .hex("#7E8AA3")
        
        return label
    } ()
    
    lazy var subBranchLabel: UILabel = {
        let label = UILabel()
        label.text = "世博家园支行"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .hex("#0F499E")
        return label
    }()

    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor.white
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func buildData(model: CheckInListModel) {
        timeLabel.text = model.timeStr
        checkInStateLabel.text = model.checkInStateStr
        addressLabel.text = model.address
        subBranchLabel.text = model.subBranchStr;
    }
    
    func setupUI() {
        addSubview(timeLabel);
        addSubview(checkInStateLabel)
        addSubview(addressIconImageView)
        addSubview(addressLabel);
        addSubview(subBranchLabel)
        
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(self).offset(17)
            make.top.equalTo(self).offset(20)
        }
        
        checkInStateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(timeLabel)
            make.left.equalTo(timeLabel.snp_rightMargin).offset(10)
        }
        
        addressIconImageView.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp_bottomMargin).offset(16)
            make.left.equalTo(18)
            make.height.equalTo(15)
            make.width.equalTo(11)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.centerY.equalTo(addressIconImageView)
            make.left.equalTo(addressIconImageView.snp_rightMargin).offset(15)
        }
        
        subBranchLabel.snp.makeConstraints { make in
            make.top.equalTo(addressIconImageView.snp_bottomMargin).offset(16)
            make.left.equalTo(addressLabel)
        }
    }
}
