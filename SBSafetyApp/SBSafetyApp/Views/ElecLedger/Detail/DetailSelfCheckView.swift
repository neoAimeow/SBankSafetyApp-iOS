//
//  DetailSelfCheckView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/17.
//

import Foundation
import UIKit

class DetailSelfCheckView: UIScrollView {
    let check1TF = CheckEffect(withEnable: false)
    let check2TF = CheckEffect(withEnable: false)
    let check3TF = CheckEffect(withEnable: false)
    let check4TF = CheckEffect(withEnable: false)
    let check5TF = CheckEffect(withEnable: false)
    let check6TF = CheckEffect(withEnable: false)
    let check7TF = CheckEffect(withEnable: false)
    let check8TF = CheckEffect(withEnable: false)
    let check9TF = CheckEffect(withEnable: false)
    let check10TF = CheckEffect(withEnable: false)
    let check11TF = CheckEffect(withEnable: false)
    let checkDateTF = DateEffect(withEnable: false)
    let leaveTimeTF = DateEffect(withEnable: false)
    let sign1TF = SignEffect(withEnable: false)
    let sign2TF = SignEffect(withEnable: false)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        showsVerticalScrollIndicator = false
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData(_ modal: StandingBookModal) {
        check1TF.isCheck = modal.attrValue0 == "1" ? true : false
        check2TF.isCheck = modal.attrValue1 == "1" ? true : false
        check3TF.isCheck = modal.attrValue2 == "1" ? true : false
        check4TF.isCheck = modal.attrValue3 == "1" ? true : false
        check5TF.isCheck = modal.attrValue4 == "1" ? true : false
        check6TF.isCheck = modal.attrValue5 == "1" ? true : false
        check7TF.isCheck = modal.attrValue6 == "1" ? true : false
        check8TF.isCheck = modal.attrValue7 == "1" ? true : false
        check9TF.isCheck = modal.attrValue8 == "1" ? true : false
        check10TF.isCheck = modal.attrValue9 == "1" ? true : false
        check11TF.isCheck = modal.attrValue10 == "1" ? true : false
        
        checkDateTF.value = Date.momentDate(modal.attrValue11 ?? "")
        leaveTimeTF.value = modal.attrValue12
        
        sign1TF.urlStr = modal.attrValue13
        sign2TF.urlStr = modal.attrValue14
    }
    
    func setupUI() {
        let titleL = UILabel()
        titleL.font = UIFont.systemFont(ofSize: 16)
        titleL.textColor = .black
        titleL.text = "保卫自查"
        addSubview(titleL)
        titleL.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(20)
            make.left.equalTo(self.snp.left).offset(10)
        }

        check1TF.title = "帐箱是否进库"
        addSubview(check1TF)
        check1TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleL.snp.bottom).offset(18)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check2TF.title = "重要凭证是否进库"
        addSubview(check2TF)
        check2TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check1TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check3TF.title = "银箱及库门是否锁好"
        addSubview(check3TF)
        check3TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check2TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check4TF.title = "银箱钥匙是否带好"
        addSubview(check4TF)
        check4TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check3TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check5TF.title = "现金库箱封包是否遗漏"
        addSubview(check5TF)
        check5TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check4TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check6TF.title = "库箱交接是否记录"
        addSubview(check6TF)
        check6TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check5TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check7TF.title = "公、私章有否遗漏在外"
        addSubview(check7TF)
        check7TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check6TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check8TF.title = "水、电、煤是否关好"
        addSubview(check8TF)
        check8TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check7TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check9TF.title = "门窗是否关好"
        addSubview(check9TF)
        check9TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check8TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check10TF.title = "电脑机房电器设备是否切断电源"
        addSubview(check10TF)
        check10TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check9TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }

        check11TF.title = "红外线是否布设防"
        addSubview(check11TF)
        check11TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check10TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        checkDateTF.placeholder = "自查日期"
        addSubview(checkDateTF)
        checkDateTF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check11TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        leaveTimeTF.placeholder = "离行时间"
        leaveTimeTF.dateMode = .time
        addSubview(leaveTimeTF)
        leaveTimeTF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(checkDateTF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        sign1TF.placeholder = "检查人一签章"
        addSubview(sign1TF)
        sign1TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(leaveTimeTF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        sign2TF.placeholder = "检查人二签章"
        addSubview(sign2TF)
        sign2TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(sign1TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }

        let bottomIV = UIImageView(image: UIImage(named: "elec_bottom"))
        addSubview(bottomIV)
        bottomIV.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(sign2TF.snp.bottom).offset(40)
            make.bottom.equalTo(self.snp.bottom).offset(-16)
            make.height.equalTo(24)
        }
    }
}

