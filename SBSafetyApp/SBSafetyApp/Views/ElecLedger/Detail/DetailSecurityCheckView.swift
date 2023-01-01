//
//  DetailSecurityCheckView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/17.
//

import Foundation
import UIKit

class DetailSecurityCheckView: UIScrollView {
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
    let check12TF = CheckEffect(withEnable: false)
    let check13TF = CheckEffect(withEnable: false)
    let check14TF = CheckEffect(withEnable: false)
    let check15TF = CheckEffect(withEnable: false)
    let check16TF = CheckEffect(withEnable: false)
    let check17TF = CheckEffect(withEnable: false)
    let check18TF = CheckEffect(withEnable: false)
    let check19TF = CheckEffect(withEnable: false)
    let check20TF = CheckEffect(withEnable: false)
    let check21TF = CheckEffect(withEnable: false)
    let check22TF = CheckEffect(withEnable: false)
    let check23TF = CheckEffect(withEnable: false)
    let check24TF = CheckEffect(withEnable: false)
    let check25TF = CheckEffect(withEnable: false)
    let check26TF = CheckEffect(withEnable: false)
    let check27TF = CheckEffect(withEnable: false)
    let check28TF = CheckEffect(withEnable: false)
    let check29TF = CheckEffect(withEnable: false)
    let check30TF = CheckEffect(withEnable: false)
    let check31TF = CheckEffect(withEnable: false)
    let noteTV = TextViewEffect(withEnable: false)
    let questionTV = TextViewEffect(withEnable: false)
    let inputDateTF = DateEffect(withEnable: false)
    let inputNameTF = TextFieldEffect(withEnable: false)
    
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
        check12TF.isCheck = modal.attrValue11 == "1" ? true : false
        check13TF.isCheck = modal.attrValue12 == "1" ? true : false
        check14TF.isCheck = modal.attrValue13 == "1" ? true : false
        check15TF.isCheck = modal.attrValue14 == "1" ? true : false
        check16TF.isCheck = modal.attrValue15 == "1" ? true : false
        check17TF.isCheck = modal.attrValue16 == "1" ? true : false
        check18TF.isCheck = modal.attrValue17 == "1" ? true : false
        check19TF.isCheck = modal.attrValue18 == "1" ? true : false
        check20TF.isCheck = modal.attrValue19 == "1" ? true : false
        check21TF.isCheck = modal.attrValue20 == "1" ? true : false
        check22TF.isCheck = modal.attrValue21 == "1" ? true : false
        check23TF.isCheck = modal.attrValue22 == "1" ? true : false
        check24TF.isCheck = modal.attrValue23 == "1" ? true : false
        check25TF.isCheck = modal.attrValue24 == "1" ? true : false
        check26TF.isCheck = modal.attrValue25 == "1" ? true : false
        check27TF.isCheck = modal.attrValue26 == "1" ? true : false
        check28TF.isCheck = modal.attrValue27 == "1" ? true : false
        check29TF.isCheck = modal.attrValue28 == "1" ? true : false
        check30TF.isCheck = modal.attrValue29 == "1" ? true : false
        check31TF.isCheck = modal.attrValue30 == "1" ? true : false
        noteTV.value = modal.attrValue31
        questionTV.value = modal.attrValue32
        inputDateTF.value = Date.momentDate(modal.attrValue33 ?? "")
        inputNameTF.value = modal.attrValue34
    }
    
    func setupUI() {
        let titleL = UILabel()
        titleL.font = UIFont.systemFont(ofSize: 16)
        titleL.textColor = .black
        titleL.text = "技防设施"
        titleL.textAlignment = .center
        addSubview(titleL)
        titleL.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(20)
            make.left.equalTo(self.snp.left).offset(10)
        }
        
        check1TF.title = "红外线报警探头是否完好"
        addSubview(check1TF)
        check1TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleL.snp.bottom).offset(18)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check2TF.title = "110劫持按钮是否完好"
        addSubview(check2TF)
        check2TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check1TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check3TF.title = "震动报警装置是否完好"
        addSubview(check3TF)
        check3TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check2TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check4TF.title = "公安报警测试是否每月一次"
        addSubview(check4TF)
        check4TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check3TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check5TF.title = "声响报警设备是否完好"
        addSubview(check5TF)
        check5TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check4TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check6TF.title = "摄像监控探头是否完好"
        addSubview(check6TF)
        check6TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check5TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check7TF.title = "电视监控操作界面是否完整"
        addSubview(check7TF)
        check7TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check6TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check8TF.title = "电视监控图象回放是否清晰"
        addSubview(check8TF)
        check8TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check7TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check9TF.title = "录像资料保存是否31天以上"
        addSubview(check9TF)
        check9TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check8TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check10TF.title = "声音符合装置回放是否完好"
        addSubview(check10TF)
        check10TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check9TF.snp.bottom).offset(10)
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
            make.top.equalTo(check10TF.snp.bottom).offset(28)
            make.left.equalTo(self.snp.left).offset(10)
        }
        
        check11TF.title = "监控设备维护是否每月两次"
        addSubview(check11TF)
        check11TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(subTitle2L.snp.bottom).offset(18)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
                
        check12TF.title = "门窗防盗栅是否牢固"
        addSubview(check12TF)
        check12TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check11TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check13TF.title = "联动门是否完好"
        addSubview(check13TF)
        check13TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check12TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check14TF.title = "联动门闭门器是否完好"
        addSubview(check14TF)
        check14TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check13TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check15TF.title = "联动门未关报警装置是否完好"
        addSubview(check15TF)
        check15TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check14TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check16TF.title = "防卫武器是否配备齐全"
        addSubview(check16TF)
        check16TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check15TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check17TF.title = "灭火机是否在有效期内"
        addSubview(check17TF)
        check17TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check16TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check18TF.title = "烟感报警设备是否完好"
        addSubview(check18TF)
        check18TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check17TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check19TF.title = "营业场所内是否存放汽、柴油"
        addSubview(check19TF)
        check19TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check18TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check20TF.title = "应急照明灯是否完好"
        addSubview(check20TF)
        check20TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check19TF.snp.bottom).offset(10)
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
            make.top.equalTo(check20TF.snp.bottom).offset(28)
            make.left.equalTo(self.snp.left).offset(10)
        }
        
        check21TF.title = "安全保卫制度熟悉情况"
        addSubview(check21TF)
        check21TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(subTitle3L.snp.bottom).offset(18)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check22TF.title = "进入营业室内登记记录"
        addSubview(check22TF)
        check22TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check21TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check23TF.title = "营业结束自查记录"
        addSubview(check23TF)
        check23TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check22TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check24TF.title = "库箱交接记录"
        addSubview(check24TF)
        check24TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check23TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check25TF.title = "技防物防设施维修保养记录"
        addSubview(check25TF)
        check25TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check24TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }

        check26TF.title = "红外线布撤防记录"
        addSubview(check26TF)
        check26TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check25TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check27TF.title = "监控录像操作记录"
        addSubview(check27TF)
        check27TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check26TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check28TF.title = "每月一次法制教育记录"
        addSubview(check28TF)
        check28TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check27TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }

        check29TF.title = "应季预案应知应会情况"
        addSubview(check29TF)
        check29TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check28TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check30TF.title = "应季预案演练情况"
        addSubview(check30TF)
        check30TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check29TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        check31TF.title = "经警人员执勤是否规范"
        addSubview(check31TF)
        check31TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(check30TF.snp.bottom).offset(10)
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
            make.top.equalTo(check31TF.snp.bottom).offset(28)
            make.left.equalTo(self.snp.left).offset(10)
        }
        
        addSubview(noteTV)
        noteTV.snp.makeConstraints { (make) -> Void in
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
            make.top.equalTo(noteTV.snp.bottom).offset(25)
            make.left.equalTo(self.snp.left).offset(10)
        }
        
        addSubview(questionTV)
        questionTV.snp.makeConstraints { (make) -> Void in
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
            make.top.equalTo(questionTV.snp.bottom).offset(25)
            make.left.equalTo(self.snp.left).offset(10)
        }

        inputDateTF.placeholder = "填表日期"
        addSubview(inputDateTF)
        inputDateTF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(subTitle6L.snp.bottom).offset(15)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        inputNameTF.placeholder = "填表人姓名"
        addSubview(inputNameTF)
        inputNameTF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(inputDateTF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        let bottomIV = UIImageView(image: UIImage(named: "elec_bottom"))
        addSubview(bottomIV)
        bottomIV.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(inputNameTF.snp.bottom).offset(40)
            make.bottom.equalTo(self.snp.bottom).offset(-16)
            make.height.equalTo(24)
        }
    }
}
