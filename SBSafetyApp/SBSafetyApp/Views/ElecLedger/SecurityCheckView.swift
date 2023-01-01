//
//  SecurityCheckView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/16.
//

import Foundation
import UIKit

class SecurityCheckView: ElecCreateScrollView {
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
    let val11TF = CheckEffect()
    let val12TF = CheckEffect()
    let val13TF = CheckEffect()
    let val14TF = CheckEffect()
    let val15TF = CheckEffect()
    let val16TF = CheckEffect()
    let val17TF = CheckEffect()
    let val18TF = CheckEffect()
    let val19TF = CheckEffect()
    let val20TF = CheckEffect()
    let val21TF = CheckEffect()
    let val22TF = CheckEffect()
    let val23TF = CheckEffect()
    let val24TF = CheckEffect()
    let val25TF = CheckEffect()
    let val26TF = CheckEffect()
    let val27TF = CheckEffect()
    let val28TF = CheckEffect()
    let val29TF = CheckEffect()
    let val30TF = CheckEffect()
    
    let val31TV = TextViewEffect()
    let val32TV = TextViewEffect()
    let val33TF = DateEffect()
    let val34TF = TextFieldEffect(withEnable: false)
    
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
        validator.registerField(val11TF, rules: [RequiredRule(message: val11TF.title)])
        validator.registerField(val12TF, rules: [RequiredRule(message: val12TF.title)])
        validator.registerField(val13TF, rules: [RequiredRule(message: val13TF.title)])
        validator.registerField(val14TF, rules: [RequiredRule(message: val14TF.title)])
        validator.registerField(val15TF, rules: [RequiredRule(message: val15TF.title)])
        validator.registerField(val16TF, rules: [RequiredRule(message: val16TF.title)])
        validator.registerField(val17TF, rules: [RequiredRule(message: val17TF.title)])
        validator.registerField(val18TF, rules: [RequiredRule(message: val18TF.title)])
        validator.registerField(val19TF, rules: [RequiredRule(message: val19TF.title)])
        validator.registerField(val20TF, rules: [RequiredRule(message: val20TF.title)])
        validator.registerField(val21TF, rules: [RequiredRule(message: val21TF.title)])
        validator.registerField(val22TF, rules: [RequiredRule(message: val22TF.title)])
        validator.registerField(val23TF, rules: [RequiredRule(message: val23TF.title)])
        validator.registerField(val24TF, rules: [RequiredRule(message: val24TF.title)])
        validator.registerField(val25TF, rules: [RequiredRule(message: val25TF.title)])
        validator.registerField(val26TF, rules: [RequiredRule(message: val26TF.title)])
        validator.registerField(val27TF, rules: [RequiredRule(message: val27TF.title)])
        validator.registerField(val28TF, rules: [RequiredRule(message: val28TF.title)])
        validator.registerField(val29TF, rules: [RequiredRule(message: val29TF.title)])
        validator.registerField(val30TF, rules: [RequiredRule(message: val30TF.title)])
        
        validator.registerField(val31TV.valueTV, rules: [RequiredRule(message: "备注")])
        validator.registerField(val32TV.valueTV, rules: [RequiredRule(message: "发现问题及整改情况")])
        validator.registerField(val33TF.valueL, rules: [RequiredRule(message: val33TF.placeholder)])
        validator.registerField(val34TF.valueTF, rules: [RequiredRule(message: val34TF.placeholder)])
    }
    
    override func setupUI() {
        super.setupUI()
        
        titleL.text = "营业网点安全防范检查"
        subTitleL.text = "技防设施"
        
        val0TF.title = "红外线报警探头是否完好"
        addSubview(val0TF)
        val0TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(subTitleL.snp.bottom).offset(18)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val1TF.title = "110劫持按钮是否完好"
        addSubview(val1TF)
        val1TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val0TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val2TF.title = "震动报警装置是否完好"
        addSubview(val2TF)
        val2TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val1TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val3TF.title = "公安报警测试是否每月一次"
        addSubview(val3TF)
        val3TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val2TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val4TF.title = "声响报警设备是否完好"
        addSubview(val4TF)
        val4TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val3TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val5TF.title = "摄像监控探头是否完好"
        addSubview(val5TF)
        val5TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val4TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val6TF.title = "电视监控操作界面是否完整"
        addSubview(val6TF)
        val6TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val5TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val7TF.title = "电视监控图象回放是否清晰"
        addSubview(val7TF)
        val7TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val6TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val8TF.title = "录像资料保存是否31天以上"
        addSubview(val8TF)
        val8TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val7TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val9TF.title = "声音符合装置回放是否完好"
        addSubview(val9TF)
        val9TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val8TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        let subTitle2L = UILabel()
        subTitle2L.font = UIFont.systemFont(ofSize: 16)
        subTitle2L.textColor = .black
        subTitle2L.text = "营业场所及柜台设施"
        subTitle2L.textAlignment = .center
        addSubview(subTitle2L)
        subTitle2L.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val9TF.snp.bottom).offset(28)
            make.left.equalTo(self.snp.left).offset(10)
        }
        
        val10TF.title = "监控设备维护是否每月两次"
        addSubview(val10TF)
        val10TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(subTitle2L.snp.bottom).offset(18)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
                
        val11TF.title = "门窗防盗栅是否牢固"
        addSubview(val11TF)
        val11TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val10TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val12TF.title = "联动门是否完好"
        addSubview(val12TF)
        val12TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val11TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val13TF.title = "联动门闭门器是否完好"
        addSubview(val13TF)
        val13TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val12TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val14TF.title = "联动门未关报警装置是否完好"
        addSubview(val14TF)
        val14TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val13TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val15TF.title = "防卫武器是否配备齐全"
        addSubview(val15TF)
        val15TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val14TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val16TF.title = "灭火机是否在有效期内"
        addSubview(val16TF)
        val16TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val15TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val17TF.title = "烟感报警设备是否完好"
        addSubview(val17TF)
        val17TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val16TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val18TF.title = "营业场所内是否存放汽、柴油"
        addSubview(val18TF)
        val18TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val17TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val19TF.title = "应急照明灯是否完好"
        addSubview(val19TF)
        val19TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val18TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        let subTitle3L = UILabel()
        subTitle3L.font = UIFont.systemFont(ofSize: 16)
        subTitle3L.textColor = .black
        subTitle3L.text = "人防制度"
        subTitle3L.textAlignment = .center
        addSubview(subTitle3L)
        subTitle3L.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val19TF.snp.bottom).offset(28)
            make.left.equalTo(self.snp.left).offset(10)
        }
        
        val20TF.title = "安全保卫制度熟悉情况"
        addSubview(val20TF)
        val20TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(subTitle3L.snp.bottom).offset(18)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val21TF.title = "进入营业室内登记记录"
        addSubview(val21TF)
        val21TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val20TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val22TF.title = "营业结束自查记录"
        addSubview(val22TF)
        val22TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val21TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val23TF.title = "库箱交接记录"
        addSubview(val23TF)
        val23TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val22TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val24TF.title = "技防物防设施维修保养记录"
        addSubview(val24TF)
        val24TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val23TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }

        val25TF.title = "红外线布撤防记录"
        addSubview(val25TF)
        val25TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val24TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val26TF.title = "监控录像操作记录"
        addSubview(val26TF)
        val26TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val25TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val27TF.title = "每月一次法制教育记录"
        addSubview(val27TF)
        val27TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val26TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }

        val28TF.title = "应季预案应知应会情况"
        addSubview(val28TF)
        val28TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val27TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val29TF.title = "应季预案演练情况"
        addSubview(val29TF)
        val29TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val28TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val30TF.title = "经警人员执勤是否规范"
        addSubview(val30TF)
        val30TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val29TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        let subTitle4L = UILabel()
        subTitle4L.font = UIFont.systemFont(ofSize: 16)
        subTitle4L.textColor = .black
        subTitle4L.text = "备注"
        subTitle4L.textAlignment = .center
        addSubview(subTitle4L)
        subTitle4L.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val30TF.snp.bottom).offset(28)
            make.left.equalTo(self.snp.left).offset(10)
        }
        
        addSubview(val31TV)
        val31TV.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(subTitle4L.snp.bottom).offset(15)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(100)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        let subTitle5L = UILabel()
        subTitle5L.font = UIFont.systemFont(ofSize: 16)
        subTitle5L.textColor = .black
        subTitle5L.text = "发现问题及整改情况"
        subTitle5L.textAlignment = .center
        addSubview(subTitle5L)
        subTitle5L.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val31TV.snp.bottom).offset(25)
            make.left.equalTo(self.snp.left).offset(10)
        }
        
        addSubview(val32TV)
        val32TV.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(subTitle5L.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(100)
            make.width.equalTo(ScreenWidth - 20)
        }

        let subTitle6L = UILabel()
        subTitle6L.font = UIFont.systemFont(ofSize: 16)
        subTitle6L.textColor = .black
        subTitle6L.text = "填表信息"
        subTitle6L.textAlignment = .center
        addSubview(subTitle6L)
        subTitle6L.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val32TV.snp.bottom).offset(25)
            make.left.equalTo(self.snp.left).offset(10)
        }

        val33TF.placeholder = "填表日期"
        val33TF.value = Date.todayDateCN()
        val33TF.maximumDate = Date()
        addSubview(val33TF)
        val33TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(subTitle6L.snp.bottom).offset(15)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val34TF.placeholder = "填表人姓名"
        val34TF.value = BSUser.currentUser.nickName
        addSubview(val34TF)
        val34TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val33TF.snp.bottom).offset(10)
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
            make.top.equalTo(val34TF.snp.bottom).offset(25)
            make.left.equalTo(val34TF.snp.left).offset(10)
            make.width.equalTo(25)
        }
        
        let remindL = UILabel()
        remindL.numberOfLines = 0
        remindL.font = UIFont.systemFont(ofSize: 14)
        remindL.textColor = .hex("#E76142")
        remindL.text = "1、此表用于网点负责人每月对本网点的日常检查。\n2、请根据实际情况填写是否。\n3、保卫干部根据此表至少每季度对辖属网点进行一次复查。"
        addSubview(remindL)
        remindL.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(tipsL.snp.top)
            make.left.equalTo(tipsL.snp.right)
            make.right.equalTo(val34TF.snp.right).offset(-10)
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
