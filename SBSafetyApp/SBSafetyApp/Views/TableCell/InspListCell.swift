//
//  InspListCell.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/22.
//

import Foundation
import UIKit

class InspListCell: UITableViewCell {
    let baseV = UIView()
    let branchL = UILabel()
    let orderNumL = InspListItem(withWidth: 80)
    let moduleL = InspListItem(withWidth: 80)
    let cycleL = InspListItem(withWidth: 80)
    let createAtL = InspListItem(withWidth: 80)
    let statusL = PaddingLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .bg
        setupUI()
    }
    
    func reload(withModal modal: ParListModal?) {
        startBtn.isHidden = true
        closeBtn.isHidden = true
        confirmedBtn.isHidden = true
        
        startBtn.parItem = modal
        closeBtn.parItem = modal
        confirmedBtn.parItem = modal

        branchL.text = modal?.deptName
        orderNumL.update(withKey: "巡检单号:", value: modal?.formSn)
        moduleL.update(withKey: "巡检模块:", value: modal?.tmplLable)
        var cycle: String = "--"
        
        if modal?.startTime != nil || modal?.endTime != nil {
            cycle = "\(modal?.startTime ?? "无") ~ \(modal?.endTime ?? "无")"
        }
        
        cycleL.update(withKey: "巡检周期:", value: cycle)
        createAtL.update(withKey: "创建时间:", value: modal?.createTime)
        switch modal?.status {
        case 0:
            statusL.backgroundColor = .hex("#666666", alpha: 0.08)
            statusL.textColor = .hex("#666666")
            statusL.text = "未开始"
            if (UserDefaults.standard.string(forKey: SafetyUserRole) == UserRole.Engineer.rawValue) {
                startBtn.isHidden = false
            }
            break
        case 1:
            statusL.backgroundColor = .hex("#007105", alpha: 0.08)
            statusL.textColor = .hex("#007105")
            statusL.text = "进行中"
            if (UserDefaults.standard.string(forKey: SafetyUserRole) == UserRole.Engineer.rawValue) {
                closeBtn.isHidden = false
            }
            break
        case 2:
            statusL.backgroundColor = .hex("#1EA200", alpha: 0.08)
            statusL.textColor = .hex("#1EA200")
            statusL.text = "待确认"
            if (BSUser.currentUser.deptId == modal?.deptId) {
                confirmedBtn.isHidden = false
            }
            break
        case 3:
            statusL.backgroundColor = .hex("#306EC8", alpha: 0.08)
            statusL.textColor = .hex("#306EC8")
            statusL.text = "运行正常"
            break
        case 4:
            statusL.backgroundColor = .hex("#FF0000", alpha: 0.08)
            statusL.textColor = .hex("#FF0000")
            statusL.text = "运行异常"
            break
        case 5:
            statusL.backgroundColor = .hex("#FF0000", alpha: 0.08)
            statusL.textColor = .hex("#FF0000")
            statusL.text = "超时未提交"
            break
        case 6:
            statusL.backgroundColor = .hex("#FF0000", alpha: 0.08)
            statusL.textColor = .hex("#FF0000")
            statusL.text = "已取消"
            break
        default: break
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        baseV.backgroundColor = .white
        baseV.layer.cornerRadius = 10
        baseV.layer.masksToBounds = true
        contentView.addSubview(baseV)
        baseV.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(5)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
        }

        let iconIV = UIImageView(image: UIImage(named: "ic_yh"))
        baseV.addSubview(iconIV)
        iconIV.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(baseV.snp.left).offset(15)
            make.top.equalTo(baseV.snp.top).offset(15)
            make.height.width.equalTo(15)
        }
        
        branchL.textColor = .hex("#333333")
        branchL.font = .systemFont(ofSize: 16)
        baseV.addSubview(branchL)
        branchL.snp.makeConstraints { make in
            make.centerY.equalTo(iconIV.snp.centerY)
            make.left.equalTo(iconIV.snp.right).offset(8)
        }
        
        baseV.addSubview(orderNumL)
        orderNumL.snp.makeConstraints { make in
            make.top.equalTo(branchL.snp.bottom).offset(12)
            make.left.equalTo(branchL.snp.left)
            make.height.equalTo(25)
        }
        
        baseV.addSubview(moduleL)
        moduleL.snp.makeConstraints { make in
            make.top.equalTo(orderNumL.snp.bottom)
            make.left.equalTo(orderNumL.snp.left)
            make.height.equalTo(25)
        }
        
        baseV.addSubview(cycleL)
        cycleL.snp.makeConstraints { make in
            make.top.equalTo(moduleL.snp.bottom)
            make.left.equalTo(orderNumL.snp.left)
            make.height.equalTo(25)
        }
        
        baseV.addSubview(createAtL)
        createAtL.snp.makeConstraints { make in
            make.top.equalTo(cycleL.snp.bottom)
            make.left.equalTo(orderNumL.snp.left)
            make.height.equalTo(25)
        }
        
        statusL.insets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        statusL.font = .systemFont(ofSize: 12)
        statusL.layer.masksToBounds = true
        statusL.layer.cornerRadius = 2
        baseV.addSubview(statusL)
        statusL.snp.makeConstraints { make in
            make.centerY.equalTo(iconIV.snp.centerY)
            make.left.equalTo(branchL.snp.right).offset(12)
            make.height.equalTo(20)
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            baseV.backgroundColor = .hex("#ECECEC")
        } else {
            baseV.backgroundColor = .white
        }
    }
    
    lazy var confirmedBtn: RepairModalButton = {
        let btn = RepairModalButton(type: .custom)
        btn.setTitle("确认巡检", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 12)
        btn.setBGColor(.primary, for: .normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 10
        return btn
    }()

    lazy var startBtn: RepairModalButton = {
        let btn = RepairModalButton(type: .custom)
        btn.setTitle("开始巡检", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 12)
        btn.setBGColor(.primary, for: .normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 10
        return btn
    }()

    lazy var closeBtn: RepairModalButton = {
        let btn = RepairModalButton(type: .custom)
        btn.setTitle("结束巡检", for: .normal)
        btn.setTitleColor(.primary, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 12)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor.primary.cgColor
        return btn
    }()
}

class InspListItem: UIView {
    let keyL = UILabel()
    let valueL = UILabel()
    
    init(withWidth width: CGFloat? = 90) {
        super.init(frame: .zero)
        setupUI(withWidth: width)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(withKey key: String, value: String?) {
        keyL.text = key
        valueL.text = value
    }
    
    // MARK: - Setup
    func setupUI(withWidth width: CGFloat? = 90) {
        keyL.textColor = .hex("#999999")
        keyL.font = .systemFont(ofSize: 13)
        addSubview(keyL)
        keyL.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.snp.left)
            make.width.equalTo(width ?? 90)
        }
        
        valueL.textColor = .hex("#333333")
        valueL.font = .systemFont(ofSize: 13)
        addSubview(valueL)
        valueL.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(keyL.snp.right)
        }
    }
}

