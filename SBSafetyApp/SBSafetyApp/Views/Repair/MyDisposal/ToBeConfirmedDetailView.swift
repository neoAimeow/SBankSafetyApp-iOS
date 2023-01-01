//
//  ToBeConfirmedDetailView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/28.
//

import Foundation
import UIKit

class ToBeConfirmedDetailView: UIScrollView {

    let basicBV = ConfirmRepairDetailBaseView()
    
    let restoreBV = UIView.createBase()
    let restoreTV = TitleItemView(withTitle: "维修记录", hasIcon: false)
    let restoreItem = ConfirmRepairDetailRestoreView() /// 维修记录
    
    let signBV = UIView.createBase()
    let imgBV = UIControl()
    
    let imgV = UIImageView()

    var img: UIImage? {
        set {
            imgV.image = newValue
            imgV.backgroundColor = img == nil ? .clear : .white
        }
        get {
            return imgV.image
        }
    }

    let submitBtn = UIButton.createPrimaryLarge("提交")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        keyboardDismissMode = .interactive
        showsVerticalScrollIndicator = false
        bounces = true
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(withModal modal: YjwxListModal) {
        basicBV.updateUI(withModal: modal)
    }
    
    func updateUI(withRestore restore: YjwxRestoreModal?) {
        restoreTV.rightTitle = "本次维修费用\(restore?.wxbj ?? 0)元"
        restoreItem.update(withRestore: restore)
    }
    
    func setupRecordView() {
        addSubview(restoreBV)
        restoreBV.snp.makeConstraints { make in
            make.top.equalTo(basicBV.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth - 20)
        }
        
        restoreBV.addSubview(restoreTV)
        restoreTV.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(46)
        }
        
        let line = UIView()
        line.backgroundColor = .hex("#ECECEC")
        restoreBV.addSubview(line)
        line.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(restoreTV.snp.bottom)
            make.left.equalToSuperview().offset(13)
            make.right.equalToSuperview().offset(-13)
            make.height.equalTo(0.5)
        }
        
        restoreBV.addSubview(restoreItem)
        restoreItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(line.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-14)
        }
    }
    
    func setupSignView() {
        addSubview(signBV)
        signBV.snp.makeConstraints { make in
            make.top.equalTo(restoreBV.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth - 20)
        }
        
        let signTV = TitleItemView(withTitle: "签名确认", hasIcon: false)
        signBV.addSubview(signTV)
        signTV.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(46)
        }
        
        let line = UIView()
        line.backgroundColor = .hex("#ECECEC")
        signBV.addSubview(line)
        line.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(signTV.snp.bottom)
            make.left.equalToSuperview().offset(13)
            make.right.equalToSuperview().offset(-13)
            make.height.equalTo(0.5)
        }
        
        imgBV.layer.cornerRadius = 10
        imgBV.layer.borderColor = UIColor.hex("#E1E1E1").cgColor
        imgBV.layer.borderWidth = 0.5
        signBV.addSubview(imgBV)
        imgBV.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(line.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(116)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        let signTipL = UILabel()
        signTipL.text = "本人签名"
        signTipL.textAlignment = .center
        signTipL.textColor = .hex("#D0D0D0")
        signTipL.font = .systemFont(ofSize: 14)
        imgBV.addSubview(signTipL)
        signTipL.snp.makeConstraints { (make) -> Void in
            make.centerY.centerX.equalToSuperview()
        }
        
        imgV.contentMode = .scaleAspectFit
        imgBV.addSubview(imgV)
        imgV.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview().offset(18)
            make.bottom.equalToSuperview().offset(-18)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupUI() {
        // 基本信息
        addSubview(basicBV)
        basicBV.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth - 20)
        }
        
        // 报修记录
        setupRecordView()
        
        // 签名
        setupSignView()
        
        addSubview(submitBtn)
        submitBtn.snp.makeConstraints { make in
            make.top.equalTo(signBV.snp.bottom).offset(20)
            make.bottom.equalTo(self.snp.bottom).offset(-20)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth - 20)
            make.height.equalTo(50)
        }
    }
}
