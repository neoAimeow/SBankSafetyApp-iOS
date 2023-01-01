//
//  TaskCompletionRateDetailView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/29.
//

import Foundation
import UIKit

class TaskCompletionRateDetailView: UIScrollView {
    let calendarView = BSCalendarView()
    let itemV = TaskCompletionRateItemView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .bg
        setupUI()
        
        updateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI() {
//        itemV.reloadData(withModal: TaskDeptRateModal(zwcl: "93", wdmc: "各地网点营业安全检查任务"))
    }
    
    func setupUI() {
        calendarView.calendarView.isScrollEnabled = false
        calendarView.style = .Style4
        addSubview(calendarView)
        calendarView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth)
            make.height.equalTo(324)
        }
        calendarView.titleStackView.isHidden = true
        calendarView.titleStackView.snp.updateConstraints { make in
            make.height.equalTo(0)
        }
        
        let remindV = TaskCRRemindView()
        addSubview(remindV)
        remindV.snp.makeConstraints { make in
            make.top.equalTo(calendarView.snp.bottom).offset(-20)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
        }
        
        let baseV = UIView.createBase()
        baseV.addSubview(itemV)

        addSubview(baseV)
        itemV.snp.makeConstraints { make in
            make.top.equalTo(remindV.snp.bottom).offset(26)
            make.centerX.equalToSuperview()
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
        }
        
        itemV.dateL.text = "06:00~22:00"
        itemV.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(26)
            make.left.right.bottom.equalToSuperview().offset(-30)
            make.height.equalTo(30)
        }
    }
}
class TaskCRRemindView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    func setupUI() {
        let line1 = UIView()
        line1.backgroundColor = .hex("#B2B5B9")
        line1.layer.cornerRadius = 1.5
        line1.layer.masksToBounds = true
        addSubview(line1)
        line1.snp.makeConstraints { make in
            make.width.equalTo(15)
            make.height.equalTo(3)
            make.centerY.left.equalToSuperview()
        }
        
        let label1 = UILabel()
        label1.text = "完成"
        label1.textColor = .hex("#636871")
        label1.font = .systemFont(ofSize: 14)
        addSubview(label1)
        label1.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(40)
            make.left.equalTo(line1.snp.right).offset(5)
        }
        
        let line2 = UIView()
        line2.backgroundColor = .hex("#FF0000")
        line2.layer.cornerRadius = 1.5
        line2.layer.masksToBounds = true
        addSubview(line2)
        line2.snp.makeConstraints { make in
            make.width.equalTo(15)
            make.height.equalTo(3)
            make.centerY.equalToSuperview()
            make.left.equalTo(label1.snp.right).offset(40)
        }
        
        let label2 = UILabel()
        label2.text = "未完成"
        label2.textColor = .hex("#FF0000")
        label2.font = .systemFont(ofSize: 14)
        addSubview(label2)
        label2.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(line2.snp.right).offset(5)
            make.width.equalTo(40)
        }
    }
}

class TaskCompletionRateItemView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData(withModal modal: TaskDeptRateModal, hasWxds: Bool = false) {
        nameL.text = modal.wdmc

        valL.text = "\(modal.zwcl ?? "0")%\((hasWxds && modal.wxds != nil) ? "(\(modal.wxds!)条)" : "")"

        let width = (ScreenWidth - 139) * (Double(modal.zwcl ?? "0") ?? 0) / 100.0
        
        rateV.snp.updateConstraints { make in
            make.width.equalTo(width)
        }
    }
    
    func reloadData(withModal modal: WbWclModal?) {
        nameL.text = modal?.name

        valL.text = "\(modal?.wcl ?? "0")%)"

        let width = (ScreenWidth - 139) * (Double(modal?.wcl ?? "0") ?? 0) / 100.0
        
        rateV.snp.updateConstraints { make in
            make.width.equalTo(width)
        }
    }
    
    // MARK: - Setup
    
    func setupUI() {
        addSubview(nameL)
        nameL.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(self.snp.left).offset(10)
        }
        
        addSubview(dateL)
        dateL.snp.makeConstraints { make in
            make.centerY.equalTo(nameL.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-20)
        }
        
        addSubview(bgV)
        bgV.snp.makeConstraints { make in
            make.top.equalTo(nameL.snp.bottom).offset(12)
            make.left.equalTo(nameL.snp.left)
            make.width.equalTo(ScreenWidth - 139)
            make.height.equalTo(7)
        }
        
        addSubview(rateV)
        rateV.snp.makeConstraints { make in
            make.centerY.equalTo(bgV.snp.centerY)
            make.left.equalTo(nameL.snp.left)
            make.width.equalTo(0)
            make.height.equalTo(7)
        }
        
        addSubview(valL)
        valL.snp.makeConstraints { make in
            make.centerY.equalTo(bgV.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-10)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        addSubview(ctl)
        ctl.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    lazy var dateL: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14)
        l.textColor = .hex("#C2C2C2")
        l.textAlignment = .right
        return l
    }()
    
    lazy var nameL: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16)
        return l
    }()
    
    lazy var valL: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14)
        l.textAlignment = .right
        l.textColor = .hex("#306EC8")
        return l
    }()
    
    lazy var bgV: UIView = {
        let v = UIView()
        v.backgroundColor = .hex("#F8F8F8")
        v.layer.cornerRadius = 3.5
        v.layer.masksToBounds = true
        return v
    }()
    
    lazy var rateV: UIView = {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth - 109, height: 7))
        v.drawBG([UIColor.hex("#95BCF4").cgColor, UIColor.hex("#306EC8").cgColor], direction: .toRight)
        v.layer.cornerRadius = 3.5
        v.layer.masksToBounds = true
        return v
    }()
    
    lazy var ctl: UIControl = {
        let ct = UIControl()
        return ct
    }()
}
