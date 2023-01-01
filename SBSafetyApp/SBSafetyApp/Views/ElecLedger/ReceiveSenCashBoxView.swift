//
//  ReceiveSenCashBoxView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/15.
//

import Foundation
import UIKit

class ReceiveSenCashBoxView: ElecCreateScrollView {
    let val0TF = DateEffect()
    let val1TF = TextFieldEffect()
    let val2TF = TextFieldEffect()
    let val3TF = TextFieldEffect()
    
    let val4TF = DateEffect(withEnable: false)
    let val5TF = TextFieldEffect()
    let val6TF = TextFieldEffect()
    let val7TF = TextFieldEffect()
    
    func registerField(withValidator validator: Validator) {
        validator.registerField(val4TF.valueL, rules: [RequiredRule(message: val4TF.placeholder)])
        validator.registerField(val5TF.valueTF, rules: [RequiredRule(message: val5TF.placeholder)])
        validator.registerField(val6TF.valueTF, rules: [RequiredRule(message: val6TF.placeholder)])
        validator.registerField(val7TF.valueTF, rules: [RequiredRule(message: val7TF.placeholder)])
    }
    
    override func setupUI() {
        super.setupUI()
        
        titleL.text = "接、送库款箱记录"
        subTitleL.text = "库款箱记录"
        
        let sendL = UILabel()
        sendL.font = UIFont.systemFont(ofSize: 16)
        sendL.textColor = .hex("#E76142")
        sendL.text = "送库"
        sendL.textAlignment = .center
        sendL.backgroundColor = .white
        addSubview(sendL)
        sendL.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(subTitleL.snp.bottom).offset(19)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(80)
        }
        
        let sendLine = UIView()
        sendLine.backgroundColor = .hex("#E76142")
        insertSubview(sendLine, belowSubview: sendL)
        sendLine.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(sendL.snp.centerX)
            make.centerY.equalTo(sendL.snp.centerY)
            make.width.equalTo(ScreenWidth - 20)
            make.height.equalTo(0.5)
        }
        
        val0TF.placeholder = "送库时间"
        val0TF.value = Date.todayDateCN()
        val0TF.maximumDate = Date()
        val0TF.isDarkBg = true
        val0TF.didSelectDateWith = { (dateStr) -> () in
            self.val4TF.value = dateStr
        }
        addSubview(val0TF)
        val0TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(sendL.snp.bottom).offset(16)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val1TF.placeholder = "领解现金额(元)"
        val1TF.isDarkBg = true
        val1TF.valueTF.keyboardType = .phonePad
        addSubview(val1TF)
        val1TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val0TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val2TF.placeholder = "款箱(只)"
        val2TF.isDarkBg = true
        val2TF.valueTF.keyboardType = .phonePad
        addSubview(val2TF)
        val2TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val1TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val3TF.placeholder = "送库交接人"
        val3TF.isDarkBg = true
        addSubview(val3TF)
        val3TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val2TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        let acceptL = UILabel()
        acceptL.font = UIFont.systemFont(ofSize: 16)
        acceptL.textColor = .hex("#E76142")
        acceptL.text = "接库"
        acceptL.textAlignment = .center
        acceptL.backgroundColor = .white
        addSubview(acceptL)
        acceptL.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val3TF.snp.bottom).offset(16)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(80)
        }
        
        let acceptLine = UIView()
        acceptLine.backgroundColor = .hex("#E76142")
        insertSubview(acceptLine, belowSubview: sendL)
        acceptLine.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(acceptL.snp.centerX)
            make.centerY.equalTo(acceptL.snp.centerY)
            make.width.equalTo(ScreenWidth - 20)
            make.height.equalTo(0.5)
        }

        val4TF.placeholder = "接库时间"
        val4TF.value = val0TF.value
        addSubview(val4TF)
        val4TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(acceptLine.snp.bottom).offset(16)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val5TF.placeholder = "领解现金额(元)"
        val5TF.valueTF.keyboardType = .phonePad
        addSubview(val5TF)
        val5TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val4TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val6TF.placeholder = "款箱(只)"
        val6TF.valueTF.keyboardType = .phonePad
        addSubview(val6TF)
        val6TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val5TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        val7TF.placeholder = "接库交接人"
        addSubview(val7TF)
        val7TF.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val6TF.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        addSubview(submitBtn)
        submitBtn.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(val7TF.snp.bottom).offset(30)
            make.height.equalTo(50)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        let bottomIV = UIImageView(image: UIImage(named: "elec_bottom"))
        addSubview(bottomIV)
        bottomIV.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(submitBtn.snp.bottom).offset(20)
            make.bottom.equalTo(self.snp.bottom).offset(-16)
            make.height.equalTo(24)
        }
    }
}
