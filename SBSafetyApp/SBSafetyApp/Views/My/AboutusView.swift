//
//  AboutusView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/24.
//

import Foundation
import UIKit

class AboutusView: UIView {
    let downloadItem = MyItemView(withModal: MyItemModal(name: "下载更新", status: .top, lineType: .full))
    let serviceItem = MyItemView(withModal: MyItemModal(name: "免责条款", status: .bottom, lineType: .line_none))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        let iv = UIImageView(image: UIImage(named: "AppIcon"))
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        addSubview(iv)
        iv.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(95)
            make.top.equalTo(self.snp.top).offset(64)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        let appDisplayName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as! String
        
        let label = UILabel()
        label.text = appDisplayName
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        addSubview(label)
        label.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(iv.snp.bottom).offset(28)
            make.left.equalTo(self.snp.left).offset(12)
            make.right.equalTo(self.snp.right).offset(-12)
        }
        
        let versionL = UILabel()
        versionL.text = "版本: V \(appVersion!)（\(build)）"
        versionL.textAlignment = .center
        versionL.font = .systemFont(ofSize: 15)
        addSubview(versionL)
        versionL.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(label.snp.bottom).offset(16)
            make.left.equalTo(self.snp.left).offset(12)
            make.right.equalTo(self.snp.right).offset(-12)
        }
        
        addSubview(downloadItem)
        downloadItem.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(versionL.snp.bottom).offset(69)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.height.equalTo(60)
        }
        
        addSubview(serviceItem)
        serviceItem.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(downloadItem.snp.bottom)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.height.equalTo(60)
        }
        
        let bottomnL = UILabel()
        bottomnL.text = "软件许可及服务协议\n\n上海银行 版权所有"
        bottomnL.textAlignment = .center
        bottomnL.font = .systemFont(ofSize: 14)
        bottomnL.textColor = .hex("#CDCDCD")
        bottomnL.numberOfLines = 0
        addSubview(bottomnL)
        bottomnL.snp.makeConstraints { (make) -> Void in
            make.bottom.equalToSuperview().offset(-16)
            make.centerX.equalToSuperview()
        }
    }
}
