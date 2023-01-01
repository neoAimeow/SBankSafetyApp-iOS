//
//  InspListDetailConfirmView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/17.
//

import Foundation
import UIKit

class InspListDetailConfirmView: UIScrollView {
    let detailV = InspListDetailParView()
    let signV = SignConfirmView()
    let submitBtn = UIButton.createPrimaryLarge("提交")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        showsVerticalScrollIndicator = false
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(withModal modal: ParListModal?) {
        detailV.updateUI(withModal: modal)
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

class SignConfirmView: UIView {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        backgroundColor = .white
        
        let signTV = TitleItemView(withTitle: "签名确认", hasIcon: false)
        addSubview(signTV)
        signTV.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(46)
        }
        
        let line = UIView()
        line.backgroundColor = .hex("#ECECEC")
        addSubview(line)
        line.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(signTV.snp.bottom)
            make.left.equalToSuperview().offset(13)
            make.right.equalToSuperview().offset(-13)
            make.height.equalTo(0.5)
        }
        
        imgBV.layer.cornerRadius = 10
        imgBV.layer.borderColor = UIColor.hex("#E1E1E1").cgColor
        imgBV.layer.borderWidth = 0.5
        addSubview(imgBV)
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
}
