//
//  SEInspListDetailView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/11.
//
// 工程师结束巡检

import Foundation
import UIKit

class SEInspListDetailView: UIScrollView {
    let detailV = InspListDetailParView()
    let signV = SignConfirmView()
    let submitBtn = UIButton.createPrimaryLarge("提交")
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        keyboardDismissMode = .interactive
        showsVerticalScrollIndicator = false
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(withModal modal: ParListModal?) {
        detailV.updateUI(withModal: modal)
    }
    
    @objc func recordTapped(_ sender: InspListDetailItem) {
//        print("recordTapped", records[sender.tag])
        let vc = SEInspListResultVC()
        getFirstViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupUI() {
        // 基本信息
        addSubview(detailV)
        detailV.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth - 20)
        }
        
        // 签名
        addSubview(signV)
        signV.snp.makeConstraints { make in
            make.top.equalTo(detailV.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth - 20)
        }
        
        addSubview(submitBtn)
        submitBtn.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(50)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(ScreenWidth - 20)
            make.top.equalTo(signV.snp.bottom).offset(10)
            make.bottom.equalTo(self.snp.bottom).offset(-20)
        }
    }
}
