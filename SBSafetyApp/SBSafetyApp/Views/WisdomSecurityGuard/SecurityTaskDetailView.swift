//
//  SecurityTaskDetailView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/17.
//

import Foundation
import UIKit

class SecurityTaskDetailView: UIScrollView {
    let submitBtn = UIButton.createPrimaryLarge("提交")

    let check1TF = SceneCheckEffect()
    let check2TF = SceneCheckEffect()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        keyboardDismissMode = .interactive
        showsVerticalScrollIndicator = false

        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//
//    func registerField(withValidator validator: Validator) {
//        validator.registerField(check1TF, rules: [RequiredRule(message: check1TF.title)])
//        validator.registerField(check2TF, rules: [RequiredRule(message: check2TF.title)])
//    }
    
    func setupUI() {
        let titleL = UILabel()
        titleL.font = UIFont.systemFont(ofSize: 18)
        titleL.textColor = .hex("#306EC8")
        titleL.text = "营业前安全检查1-保安员"
        addSubview(titleL)
        titleL.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(20)
            make.left.equalTo(self.snp.left).offset(10)
        }
        
        let desL = UILabel()
        desL.font = UIFont.systemFont(ofSize: 17)
        desL.textColor = .pmB3
        desL.text = "请巡检人员按要求认真检查"
        desL.textAlignment = .center
        addSubview(desL)
        desL.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleL.snp.bottom).offset(13)
            make.left.equalTo(self.snp.left).offset(10)
        }
        
        let subTitleL = UILabel()
        subTitleL.font = UIFont.systemFont(ofSize: 16)
        subTitleL.textColor = .black
        subTitleL.text = "营业大厅/工作区"
        subTitleL.textAlignment = .center
        addSubview(subTitleL)
        subTitleL.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(desL.snp.bottom).offset(38)
            make.left.equalTo(self.snp.left).offset(10)
        }

        check1TF.title = "帐箱是否进库"
        addSubview(check1TF)
        check1TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(subTitleL.snp.bottom).offset(18)
            make.centerX.equalTo(self.snp.centerX)
//            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check2TF.title = "重要凭证是否进库"
        addSubview(check2TF)
        check2TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check1TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
//            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
       
        
        let subTitle2L = UILabel()
        subTitle2L.font = UIFont.systemFont(ofSize: 16)
        subTitle2L.textColor = .black
        subTitle2L.text = "巡检人员信息"
        subTitle2L.textAlignment = .center
        addSubview(subTitle2L)
        subTitle2L.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check2TF.snp.bottom).offset(38)
            make.left.equalTo(self.snp.left).offset(10)
        }
        
        let nameV = BSLabel(withModal: nameLM)
        nameV.titleL.text = "周大爷"
        addSubview(nameV)
        nameV.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(subTitle2L.snp.bottom).offset(18)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.width.equalTo(ScreenWidth - 20)
            make.height.equalTo(46)
        }
        
        let phoneV = BSLabel(withModal: phoneLM)
        phoneV.titleL.text = "15023655322"
        addSubview(phoneV)
        phoneV.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(nameV.snp.bottom).offset(10)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.width.equalTo(ScreenWidth - 20)
            make.height.equalTo(46)
        }
        
        let locV = BSLabel(withModal: locLM)
        addSubview(locV)
        locV.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(phoneV.snp.bottom).offset(10)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.width.equalTo(ScreenWidth - 20)
            make.height.equalTo(46)
        }
        
        let remindV = UIView()
        remindV.backgroundColor = .hex("#F8F8F8")
        remindV.layer.cornerRadius = 10
        addSubview(remindV)
        remindV.snp.makeConstraints { make in
            make.top.equalTo(locV.snp.bottom).offset(31)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        let tipsL = UILabel()
        tipsL.font = UIFont.systemFont(ofSize: 14)
        tipsL.textColor = .black
        tipsL.text = "提交后，设备信息将发生以下变更："
        addSubview(tipsL)
        tipsL.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(remindV.snp.left).offset(18)
            make.top.equalTo(remindV.snp.top).offset(20)
        }
        
        let statusL = UILabel()
        statusL.font = UIFont.systemFont(ofSize: 14)
        statusL.textColor = .hex("#777777")
        statusL.text = "检查状态：正常➜异常"
        addSubview(statusL)
        statusL.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(remindV.snp.left).offset(18)
            make.top.equalTo(tipsL.snp.bottom).offset(24)
        }
        
        let dateL = UILabel()
        dateL.font = UIFont.systemFont(ofSize: 14)
        dateL.textColor = .hex("#777777")
        dateL.text = "更新时间：9月19日 17:25"
        addSubview(dateL)
        dateL.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(remindV.snp.left).offset(18)
            make.top.equalTo(statusL.snp.bottom).offset(10)
            make.bottom.equalTo(remindV.snp.bottom).offset(-18)
        }
    
        addSubview(submitBtn)
        submitBtn.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(remindV.snp.bottom).offset(26)
            make.height.equalTo(50)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        let bottomL = UILabel()
        bottomL.font = UIFont.systemFont(ofSize: 14)
        bottomL.textColor = .hex("#AFAEAE")
        bottomL.textAlignment = .center
        bottomL.text = "提交即授权该表单收集你填写的信息"
        addSubview(bottomL)
        bottomL.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(submitBtn.snp.bottom).offset(20)
            make.bottom.equalTo(self.snp.bottom).offset(-16)
            make.width.equalTo(ScreenWidth - 20)
        }
    }
}
