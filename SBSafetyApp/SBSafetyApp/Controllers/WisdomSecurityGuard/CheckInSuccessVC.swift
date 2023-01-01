//
//  CheckInStateVC.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/16.
//  保安管理-签到、签退成功页面

import Foundation
import UIKit

class CheckInSuccessVC: SubLevelViewController {
    lazy var checkInImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage.init(named: "checkin_success")
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        return imageView
    }()
    
    lazy var checkInTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40)
        label.textColor = UIColor.hex("#0F499E")
        label.text = "17:09"
        return label
    }()
    
    lazy var checkSuccessLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.hex("#0F499E")
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "签退成功"
        return label
    }()
    
    lazy var doTaskButton: UIButton = {
        let button = UIButton.createCornerButton("去做任务")
        return button
    }()
    
    lazy var tipLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.hex("#CBD0D9")
        label.text = "3S自动返回任务列表"
        return label
    }()
    
    lazy var addressPanel: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.hex("#F3F5F8")
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.hex("#8D99AC")
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "上海市浦东新区银城中路158号"

        return label
    }()
    
    lazy var addressDetailLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.hex("#000000")
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "(上海银行总行)"
        
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
        self.view.addSubview(checkInTimeLabel)
        self.view.addSubview(checkSuccessLabel)
        self.view.addSubview(doTaskButton)
        self.view.addSubview(tipLabel)
        self.view.addSubview(addressPanel)
        addressPanel.addSubview(addressLabel)
        addressPanel.addSubview(addressDetailLabel)
        
        
        
        checkInImageView.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(188)

        }
        
        checkInTimeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(checkInImageView.snp_bottomMargin).offset(50)
        }
        
        checkSuccessLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.checkInTimeLabel.snp_bottomMargin).offset(34)
        }
        
        doTaskButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.checkSuccessLabel.snp_bottomMargin).offset(94)
            make.height.equalTo(50)
            make.width.equalTo(220)
        }
        
        tipLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(doTaskButton.snp_bottomMargin).offset(25)
        }
        
        addressPanel.snp.makeConstraints { make in
            make.height.equalTo(94)
            make.width.equalTo(318)
            make.centerX.equalTo(self.view)
            make.top.equalTo(tipLabel.snp_bottomMargin).offset(49)
        }
        
        
         addressLabel.snp.makeConstraints { make in
             make.centerX.equalTo(addressPanel)
             make.top.equalTo(addressPanel).offset(25.5)
         }
         
         addressDetailLabel.snp.makeConstraints { make in
             make.centerX.equalTo(addressPanel)
             make.top.equalTo(addressLabel).offset(18)
             make.bottom.equalTo(addressPanel).offset(-26)
         }
        
    }
}
