//
//  InspListDetailView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/18.
//

import Foundation
import UIKit

class InspListDetailView: UIScrollView {
    let detailV = InspListDetailParView()
    let inspSignV = SignDetailView()
    let inspCSignV = SignDetailView()

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
        
        // 巡检人签名
        inspSignV.signTV.title = "巡检人签名"
        addSubview(inspSignV)
        inspSignV.snp.makeConstraints { make in
            make.top.equalTo(detailV.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth - 20)
        }
        
        // 巡检确认签名
        addSubview(inspCSignV)
        inspCSignV.snp.makeConstraints { make in
            make.top.equalTo(inspSignV.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth - 20)
            make.bottom.equalTo(self.snp.bottom).offset(-20)
        }
    }
}

class SignDetailView: UIView {
    let signTV = TitleItemView(withTitle: "巡检确认签名", hasIcon: false)

    let imgV = UIImageView()
    var img: UIImage? {
        didSet {
            let urlStr = "https://www.zhxqgl.top/bosc-ydaf" + "/modal.bxqm!"
            imgV.kf.setImage(with: URL(string: urlStr))
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
        
        imgV.contentMode = .scaleAspectFit
        addSubview(imgV)
        imgV.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(line.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}
