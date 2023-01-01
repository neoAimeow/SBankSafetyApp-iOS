//
//  HomeSituationView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/21.
//

import Foundation
import UIKit

class HomeSituationView: UIView {
    let deptallBtn = BSDeptallControl()
    let dateSegV = HomeDateView()

    let titleL = UILabel()

    let yglzlV = HomeSituationItemView()
    let dywbwcV = HomeSituationItemView()
    let balzlV = HomeSituationItemView()
    let repairV = HomeSituationItemView()
    let tzdjwclV = HomeSituationItemView()
    let bazglV = HomeSituationItemView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData(withModal modal: HomeTallModal?) {
        // 员工履职率
        yglzlV.val = modal?.lzPercent?.wcl
        yglzlV.subVal = modal?.lzPercent?.qsbl

        // 维修完成率
        repairV.val = modal?.repairPercent?.wcl
        repairV.subVal = modal?.repairPercent?.qsbl

        // 当月维保完成率
        dywbwcV.val = modal?.patorlPercent?.wcl
        dywbwcV.subVal = modal?.patorlPercent?.qsbl

        // 台账登记完成率
        tzdjwclV.val = modal?.bookPercent?.wcl
        tzdjwclV.subVal = modal?.bookPercent?.qsbl

        // 保安履职率
        balzlV.val = modal?.baPercent?.wcl
        balzlV.subVal = modal?.baPercent?.qsbl

        // 保安在岗率
        bazglV.val = modal?.bazgl?.wcl
        bazglV.subVal = modal?.bazgl?.qsbl

        let role = UserDefaults.standard.string(forKey: SafetyUserRole)
        if (role == UserRole.HeadOffice.rawValue) {
            titleL.text = "全行态势"
        } else if (role == UserRole.SubBranchOffice.rawValue ||
                   role == UserRole.BranchOffice.rawValue ||
                   role == UserRole.Lattice.rawValue) {
            titleL.text = "\(BSUser.currentUser.deptName ?? "")态势"
        }
    }
    
    func setupUI() {
        backgroundColor = .white
        layer.masksToBounds = true
        layer.cornerRadius = 10
        
        let yhIV = UIImageView(image: UIImage(named: "ic_yh"))
        addSubview(yhIV)
        yhIV.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(16)
            make.top.equalTo(self.snp.top).offset(17)
            make.width.height.equalTo(18)
        }
        
        titleL.text = "全行态势"
        titleL.textColor = .black
        titleL.font = .systemFont(ofSize: 17)
        addSubview(titleL)
        titleL.snp.makeConstraints { make in
            make.left.equalTo(yhIV.snp.right).offset(7)
            make.centerY.equalTo(yhIV.snp.centerY)
        }
        
        addSubview(deptallBtn)
        deptallBtn.snp.makeConstraints { make in
            make.right.equalTo(self.snp.right).offset(-12)
            make.centerY.equalTo(yhIV.snp.centerY)
            make.width.greaterThanOrEqualTo(180)
            make.height.equalTo(24)
        }
        
        addSubview(dateSegV)
        dateSegV.snp.makeConstraints { make in
            make.top.equalTo(yhIV.snp.bottom).offset(12)
            make.left.right.equalToSuperview()
            make.height.equalTo(24)
        }
        
        let hLine1 = UIView()
        hLine1.backgroundColor = .hex("#F0F0F0")
        addSubview(hLine1)
        hLine1.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(dateSegV.snp.bottom).offset(12)
            make.height.equalTo(1)
        }

        yglzlV.key = "员工履职率"
        yglzlV.val = 0.0
        yglzlV.subVal = 0.0
        addSubview(yglzlV)
        yglzlV.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(hLine1.snp.bottom)
        }
        
        let hLine2 = UIView()
        hLine2.backgroundColor = .hex("#F4F4F4")
        addSubview(hLine2)
        hLine2.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(yglzlV.snp.bottom)
            make.height.equalTo(0.5)
        }
        
        dywbwcV.key = "当月维保完成率"
        dywbwcV.val = 0.0
        dywbwcV.subVal = 0.0
        addSubview(dywbwcV)
        dywbwcV.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(hLine2.snp.bottom)
        }
        
        let hLine3 = UIView()
        hLine3.backgroundColor = .hex("#F4F4F4")
        addSubview(hLine3)
        hLine3.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(dywbwcV.snp.bottom)
            make.height.equalTo(0.5)
        }
        
        balzlV.key = "保安履职率"
        balzlV.val = 0.0
        balzlV.subVal = 0.0
        addSubview(balzlV)
        balzlV.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(hLine3.snp.bottom)
        }
        
        let vLine1 = UIView()
        vLine1.backgroundColor = .hex("#F4F4F4")
        addSubview(vLine1)
        vLine1.snp.makeConstraints { make in
            make.top.equalTo(hLine1.snp.bottom)
            make.centerX.bottom.equalToSuperview()
            make.width.equalTo(0.5)
        }

        repairV.key = "维修完成率"
        repairV.val = 0.0
        repairV.subVal = 0.0
        addSubview(repairV)
        repairV.snp.makeConstraints { make in
            make.left.equalTo(vLine1.snp.right)
            make.top.equalTo(hLine1.snp.bottom)
            make.right.equalToSuperview()
        }
        
        tzdjwclV.key = "台账登记完成率"
        tzdjwclV.val = 0.0
        tzdjwclV.subVal = 0.0
        addSubview(tzdjwclV)
        tzdjwclV.snp.makeConstraints { make in
            make.left.equalTo(vLine1.snp.right)
            make.top.equalTo(hLine2.snp.bottom)
            make.right.equalToSuperview()
        }
        
        bazglV.key = "保安在岗率"
        bazglV.val = 0.0
        bazglV.subVal = 0.0
        addSubview(bazglV)
        bazglV.snp.makeConstraints { make in
            make.left.equalTo(vLine1.snp.right)
            make.top.equalTo(hLine3.snp.bottom)
            make.right.equalToSuperview()
        }
    }
}

class HomeSituationItemView: UIView {
    
    var key: String? {
        didSet {
            keyL.text = key
        }
    }
    
    var val: Double? {
        didSet {
            valL.text = "\(val ?? 0.0)%"
        }
    }
    
    var subVal: Double? {
        didSet {
            updateEntry()
        }
    }
    
    let keyL = UILabel()
    let valL = UILabel()
    let subValL = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateEntry() {
        if subVal != nil {
            if subVal! > 0 {
                subValL.text = "较前日 ↑ \(subVal!)%"
                subValL.textColor = .hex("#FF6C54")
            } else if subVal! < 0 {
                subValL.text = "较前日 ↓ \(subVal!)%"
                subValL.textColor = .hex("#00AB44")
            } else {
                subValL.text = "较前日 - \(subVal!)%"
                subValL.textColor = .hex("#AAAAAA")
            }
        } else {
            subValL.text = "较前日 - 0.0%"
            subValL.textColor = .hex("#AAAAAA")
        }
    }
    
    func setupUI() {
        keyL.text = "保安在岗率"
        keyL.textColor = .hex("#AAAAAA")
        keyL.font = .systemFont(ofSize: 14)
        addSubview(keyL)
        keyL.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(16)
            make.top.equalTo(self.snp.top).offset(14)
        }
        
        valL.text = "0.0%"
        valL.textColor = .hex("#333333")
        valL.font = .systemFont(ofSize: 16)
        valL.adjustsFontSizeToFitWidth = true
        addSubview(valL)
        valL.snp.makeConstraints { make in
            make.left.equalTo(keyL.snp.left)
            make.top.equalTo(keyL.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(-13)
            make.width.equalTo(60)
        }
        
        subValL.text = "较前日 - 0.0%"
        subValL.textColor = .hex("#AAAAAA")
        subValL.font = .systemFont(ofSize: 14)
        subValL.adjustsFontSizeToFitWidth = true
        addSubview(subValL)
        subValL.snp.makeConstraints { make in
            make.left.equalTo(valL.snp.right)
            make.centerY.equalTo(valL.snp.centerY)
        }
    }
}
