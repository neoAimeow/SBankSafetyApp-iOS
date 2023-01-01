//
//  BasePanel.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/28.
//

import Foundation
import UIKit
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif


class WeekModel {
    var text: String = ""
    var value: String = ""
    init(text: String, value: String) {
        self.text = text
        self.value = value
    }
}

class EditBizDateView: UIView {
    var selectWeekDays: Set<String> = []
    var disposeBag = DisposeBag()

    lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hex("#717D8F")
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "说明：勾选上的营业时间表均为开门营业的日期，如遇节假日或特殊例外的日期，可以单独设置营业或者不营业。"
        return label
    }()
    
    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hex("#306EC8")
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "选中即为营业"
        return label
    }()
    
    lazy var checkBoxView: UIView = {
        let view = UIView()
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually

        let stackView2 = UIStackView()
        stackView2.axis = .horizontal
        stackView2.distribution = .fillEqually

        let stackView3 = UIStackView()
        stackView3.axis = .horizontal
        stackView3.distribution = .fillEqually

        let arr: [WeekModel] = [WeekModel(text: "周一", value: "星期一"), WeekModel(text: "周二", value: "星期二"), WeekModel(text: "周三", value: "星期三")]
        let arr2: [WeekModel] = [WeekModel(text: "周四", value: "星期四"), WeekModel(text: "周五", value: "星期五"), WeekModel(text: "周六", value: "星期六")]
        let arr3: [WeekModel] = [WeekModel(text: "周日", value: "星期日")]

        arr.forEach { text in
            let checkbox = BSCheckbox()
            checkbox.buildData(title: text.text, enable: false)
            
            checkbox.rx.tapGesture().when(.recognized)
                    .subscribe(onNext: { [self] _ in
                        checkbox.buildData(title: text.text, enable: !checkbox.isSelect)
                        if checkbox.isSelect {
                            if !selectWeekDays.contains(text.value) {
                                selectWeekDays.insert(text.value)
                            }
                        } else {
                            selectWeekDays.remove(text.value)
                        }
                    })
                    .disposed(by: disposeBag)

            stackView.addArrangedSubview(checkbox)
            checkbox.snp.makeConstraints { make in
                make.height.equalTo(20)
            }
        }
        
        arr2.forEach { text in
            let checkbox = BSCheckbox()
            checkbox.buildData(title: text.text, enable: false)
            stackView2.addArrangedSubview(checkbox)
            checkbox.rx.tapGesture().when(.recognized)
                    .subscribe(onNext: { [self] _ in
                        checkbox.buildData(title: text.text, enable: !checkbox.isSelect)
                        if checkbox.isSelect {
                            if !selectWeekDays.contains(text.value) {
                                selectWeekDays.insert(text.value)
                            }
                        } else {
                            selectWeekDays.remove(text.value)
                        }
                    })
                    .disposed(by: disposeBag)

            checkbox.snp.makeConstraints { make in
                make.height.equalTo(20)
            }
        }
        
        arr3.forEach { text in
            let checkbox = BSCheckbox()
            checkbox.buildData(title: text.text, enable: false)
            stackView3.addArrangedSubview(checkbox)
            checkbox.rx.tapGesture().when(.recognized)
                    .subscribe(onNext: { [self] _ in
                        checkbox.buildData(title: text.text, enable: !checkbox.isSelect)
                        if checkbox.isSelect {
                            if !selectWeekDays.contains(text.value) {
                                selectWeekDays.insert(text.value)
                            }
                        } else {
                            selectWeekDays.remove(text.value)
                        }
                        print(selectWeekDays)
                    })
                    .disposed(by: disposeBag)

            checkbox.snp.makeConstraints { make in
                make.height.equalTo(20)
            }
        }
        
        view.addSubview(stackView)
        view.addSubview(stackView2)
        view.addSubview(stackView3)
        
        
        stackView.snp.makeConstraints { make in
            make.left.right.top.equalTo(view)
        }
        
        stackView2.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.top.equalTo(stackView.snp.bottom).offset(30)
        }
        
        stackView3.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.top.equalTo(stackView2.snp.bottom).offset(30)
        }
        
        return view
    }()
    
    lazy var skipLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hex("#000000")
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "智能跳过法定节假日"
        return label
    }()
    
    lazy var skipSwitchButton: UISwitch = {
        let switchBtn = UISwitch()
        return switchBtn
    }()
    
    init(withStyle style: SectionTitleStyleEnum, withTitle title: String) {
        super.init(frame: .zero)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        backgroundColor = .white
        
        let titleView = SectionTitleView(withStyle: style, title: title)
        let line = UIView.createLightLine()
        addSubview(titleView)
        addSubview(detailLabel)
        addSubview(line)
        addSubview(checkBoxView)
        addSubview(skipLabel)
        addSubview(skipSwitchButton)
        addSubview(commentLabel)
        
    
        titleView.snp.makeConstraints { make in
            make.left.top.equalTo(self).offset(20)
            make.top.equalTo(self).offset(20)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.right.equalTo(self).offset(-18)
            make.centerY.equalTo(titleView)
        }
        
        line.snp.makeConstraints { make in
            make.top.equalTo(detailLabel.snp.bottom).offset(18)
            make.height.equalTo(0.5)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
        }
        
        checkBoxView.snp.makeConstraints { make in
            make.left.equalTo(self).offset(30)
            make.right.equalTo(self).offset(-30)
            make.top.equalTo(line.snp.bottom).offset(30)
            make.height.equalTo(150)
        }
        
        skipLabel.snp.makeConstraints { make in
            make.top.equalTo(checkBoxView.snp.bottom).offset(10)
            make.left.equalTo(self).offset(20)
        }
        
        skipSwitchButton.snp.makeConstraints { make in
            make.right.equalTo(self).offset(-20)
            make.centerY.equalTo(skipLabel)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(skipLabel.snp.bottom).offset(32)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.bottom.equalTo(self).offset(-30)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
