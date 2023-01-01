//
//  SelfCheckExcelView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/15.
//

import Foundation
import UIKit

class SelfCheckExcelView: ElecCreateScrollView {
    let val0TF = CheckEffect()
    let val1TF = CheckEffect()
    let val2TF = CheckEffect()
    let val3TF = CheckEffect()
    let val4TF = CheckEffect()
    let val5TF = CheckEffect()
    let val6TF = CheckEffect()
    let val7TF = CheckEffect()
    let val8TF = CheckEffect()
    let val9TF = CheckEffect()
    let val10TF = CheckEffect()
    let val11TF = DateEffect()
    let val12TF = DateEffect()
    let val13TF = SignEffect()
    let val14TF = SignEffect()
  
    func registerField(withValidator validator: Validator) {
        validator.registerField(val0TF, rules: [RequiredRule(message: val0TF.title)])
        validator.registerField(val1TF, rules: [RequiredRule(message: val1TF.title)])
        validator.registerField(val2TF, rules: [RequiredRule(message: val2TF.title)])
        validator.registerField(val3TF, rules: [RequiredRule(message: val3TF.title)])
        validator.registerField(val4TF, rules: [RequiredRule(message: val4TF.title)])
        validator.registerField(val5TF, rules: [RequiredRule(message: val5TF.title)])
        validator.registerField(val6TF, rules: [RequiredRule(message: val6TF.title)])
        validator.registerField(val7TF, rules: [RequiredRule(message: val7TF.title)])
        validator.registerField(val8TF, rules: [RequiredRule(message: val8TF.title)])
        validator.registerField(val9TF, rules: [RequiredRule(message: val9TF.title)])
        validator.registerField(val10TF, rules: [RequiredRule(message: val10TF.title)])
        validator.registerField(val11TF.valueL, rules: [RequiredRule(message: val11TF.placeholder)])
        validator.registerField(val12TF.valueL, rules: [RequiredRule(message: val12TF.placeholder)])
        validator.registerField(val13TF, rules: [RequiredRule(message: val13TF.placeholder)])
        validator.registerField(val14TF, rules: [RequiredRule(message: val14TF.placeholder)])
    }
    
    override func setupUI() {
        super.setupUI()
        
        titleL.text = "营业结束安全保卫自查表"
        subTitleL.text = "保卫自查"

        val0TF.title = "帐箱是否进库"
        addSubview(val0TF)
        val0TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(subTitleL.snp.bottom).offset(18)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val1TF.title = "重要凭证是否进库"
        addSubview(val1TF)
        val1TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val0TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val2TF.title = "银箱及库门是否锁好"
        addSubview(val2TF)
        val2TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val1TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val3TF.title = "银箱钥匙是否带好"
        addSubview(val3TF)
        val3TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val2TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val4TF.title = "现金库箱封包是否遗漏"
        addSubview(val4TF)
        val4TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val3TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val5TF.title = "库箱交接是否记录"
        addSubview(val5TF)
        val5TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val4TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val6TF.title = "公、私章有否遗漏在外"
        addSubview(val6TF)
        val6TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val5TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val7TF.title = "水、电、煤是否关好"
        addSubview(val7TF)
        val7TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val6TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val8TF.title = "门窗是否关好"
        addSubview(val8TF)
        val8TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val7TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val9TF.title = "电脑机房电器设备是否切断电源"
        addSubview(val9TF)
        val9TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val8TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }

        val10TF.title = "红外线是否布设防"
        addSubview(val10TF)
        val10TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val9TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val11TF.placeholder = "自查日期"
        val11TF.value = Date.todayDateCN()
        val11TF.maximumDate = Date()
        addSubview(val11TF)
        val11TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val10TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val12TF.placeholder = "离行时间"
        val12TF.value = Date.nowCN()
        val12TF.dateMode = .time
        addSubview(val12TF)
        val12TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val11TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val13TF.placeholder = "检查人一签章"
        addSubview(val13TF)
        val13TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val12TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val14TF.placeholder = "检查人二签章"
        addSubview(val14TF)
        val14TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val13TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        let tipsL = UILabel()
        tipsL.font = UIFont.systemFont(ofSize: 14)
        tipsL.textColor = .hex("#E76142")
        tipsL.text = "注："
        addSubview(tipsL)
        tipsL.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val14TF.snp.bottom).offset(14)
            make.left.equalTo(val14TF.snp.left).offset(10)
            make.width.equalTo(25)
        }
        
        let remindL = UILabel()
        remindL.numberOfLines = 0
        remindL.font = UIFont.systemFont(ofSize: 14)
        remindL.textColor = .hex("#E76142")
        remindL.text = "1、每天营业结束离行前由值班人员负责检查上述项目，并在检查内容选择相应状态，同时在检查人一栏双人签章。\n2、在检查时要根据内容逐项进行检查，检查划号需按当日进行，不得提前或后补。"
        addSubview(remindL)
        remindL.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(tipsL.snp.top)
            make.left.equalTo(tipsL.snp.right)
            make.right.equalTo(val14TF.snp.right).offset(-10)
        }
        
        addSubview(submitBtn)
        submitBtn.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(remindL.snp.bottom).offset(34)
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
