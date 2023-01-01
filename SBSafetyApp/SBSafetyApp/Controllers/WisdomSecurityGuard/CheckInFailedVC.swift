//
//  CheckInFailedVC.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/16.
//  保安管理-签到、签退失败页面

import Foundation
import UIKit

class CheckInFailedVC: SubLevelViewController {

    lazy var checkInImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage.init(named: "checkin_failed")
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        return imageView
    }()
    
    lazy var checkInFailedLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.hex("#F72E16")
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "签退失败"
        return label
    }()
    
    lazy var checkInReasonLabel: UILabel = {
        let label = UILabel()
        label.text = "比对人脸不符合"
        label.textColor = UIColor.hex("#000000")
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    lazy var reidentifyButton: UIButton = {
        let button = UIButton.createCornerButton("重新识别")
        return button
    }()
    
    lazy var tipLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.hex("#CBD0D9")
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "3S自动退出"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "签到"
        setupUI()
        
    }
    
    
    // MARK: - Setup
    
    func setupUI() {
        self.view.addSubview(checkInImageView)
        self.view.addSubview(checkInFailedLabel)
        self.view.addSubview(checkInReasonLabel)
        self.view.addSubview(reidentifyButton)
        self.view.addSubview(tipLabel)
        
        checkInImageView.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.height.equalTo(141.5)
            make.width.equalTo(155.5)
            make.top.equalTo(self.view).offset(188)
        }
        
        checkInFailedLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(checkInImageView.snp_bottomMargin).offset(86.5)
        }
        
        checkInReasonLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(checkInFailedLabel.snp_bottomMargin).offset(40)
        }
        
        reidentifyButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(checkInReasonLabel.snp_bottomMargin).offset(107)
            make.width.equalTo(220)
            make.height.equalTo(50)
        }
        
        tipLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(reidentifyButton.snp_bottomMargin).offset(25)
        }
    }
}
