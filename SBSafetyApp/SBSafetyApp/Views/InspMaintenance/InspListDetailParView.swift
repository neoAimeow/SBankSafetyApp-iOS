//
//  InspListDetailParView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/23.
//

import Foundation
import UIKit

class InspRecordModal: NSObject {
    var key: String = ""
    var val: String = ""
    
    init(key: String, val: String) {
        self.key = key
        self.val = val
    }
}

// MARK: - InspListDetailParView
class InspListDetailParView: UIView {
    let titleBV = UIView.createBase()
    let nameL = UILabel()
  
    let basicBV = InspListDetailBasicView()
    let recordBV = UIView.createBase()
   
    var records: [PatrolRecordModal?] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(withModal modal: ParListModal?) {
        nameL.text = modal?.serviceCompanyName
        
        basicBV.updateUI(withModal: modal)
        
        records = modal?.patrolRecord ?? []
        updateRecordView(withRecords: modal?.patrolRecord ?? [])
    }
    
    @objc func recordTapped(_ sender: InspListDetailItem) {
        let vc = InspListResultVC(withModal: records[sender.tag]!)
        getFirstViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateRecordView(withRecords records: [PatrolRecordModal?]) {
        recordBV.removeAllSubViews()
        
        let recordTV = TitleItemView(withTitle: "巡检记录")
        recordBV.addSubview(recordTV)
        recordTV.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(46)
        }

        var lastI: InspListRecordItem?
        for (index, record) in records.enumerated() {
            let itemV = InspListRecordItem()    // 网点名称
            itemV.update(withModal: record)
            itemV.tag = index
            itemV.addTarget(self, action: #selector(recordTapped), for: .touchUpInside)
            recordBV.addSubview(itemV)
            itemV.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalTo(lastI == nil ? recordTV.snp.bottom : lastI!.snp.bottom)
                if index == records.count - 1 {
                    make.bottom.equalToSuperview().offset(-10)
                }
            }
            lastI = itemV
        }
    }
    
    func setupTitleView() {
        addSubview(titleBV)
        titleBV.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth - 20)
        }
        
        nameL.font = .systemFont(ofSize: 17)
        titleBV.addSubview(nameL)
        nameL.snp.makeConstraints { make in
            make.top.equalTo(titleBV.snp.top).offset(18)
            make.centerX.equalToSuperview()
        }
        
        let desL = UILabel()
        desL.text = "巡检服务单"
        desL.textColor = .hex("#306EC8")
        desL.font = .systemFont(ofSize: 16)
        titleBV.addSubview(desL)
        desL.snp.makeConstraints { make in
            make.top.equalTo(nameL.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    func setupUI() {
        setupTitleView()
        
        // 基本信息
        addSubview(basicBV)
        basicBV.snp.makeConstraints { make in
            make.top.equalTo(titleBV.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth - 20)
        }
        
        // 巡检记录
        addSubview(recordBV)
        recordBV.snp.makeConstraints { make in
            make.top.equalTo(basicBV.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth - 20)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
}

// MARK: - InspListRecordItem

class InspListRecordItem: UIControl {
    let keyL = UILabel()
    let valueL = UILabel()
    let line = UIView()

    let statusL = UILabel()
    let arrowL = UIImageView(image: UIImage(systemName: "chevron.right"))

    var keyWidth = 134.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(withModal modal: PatrolRecordModal? ) {
        keyL.text = "\(modal?.tmplName ?? ""):"
        valueL.text = modal?.remark
        switch modal?.status {
        case 0:
            statusL.text = "未完成"
            statusL.textColor = .hex("#FF0000")
            break
        case 1:
            statusL.text = "异常"
            statusL.textColor = .hex("#FF0000")
            break
        case 2:
            statusL.text = "正常"
            statusL.textColor = .hex("#306EC8")
            break
        default: break
        }
    }
    
    func setupUI() {
        line.backgroundColor = .hex("#F5F5F5")
        addSubview(line)
        line.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(0.5)
        }
        
        keyL.textColor = .hex("#666666")
        keyL.font = .systemFont(ofSize: 14)
        keyL.adjustsFontSizeToFitWidth = true
        addSubview(keyL)
        keyL.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(12)
            make.width.equalTo(keyWidth)
            make.height.equalTo(20)
        }
        
        arrowL.tintColor = .hex("#A5A5A5")
        arrowL.contentMode = .scaleAspectFit
        addSubview(arrowL)
        arrowL.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-12)
            make.width.equalTo(9)
        }
        
        statusL.textColor = .hex("#306EC8")
        statusL.font = .systemFont(ofSize: 13)
        addSubview(statusL)
        statusL.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(arrowL.snp.left).offset(-4)
            make.width.equalTo(40)
        }
        
        valueL.textColor = .hex("#444444")
        valueL.font = .systemFont(ofSize: 14)
        valueL.numberOfLines = 0
        addSubview(valueL)
        valueL.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalTo(keyL.snp.right)
            make.right.equalTo(statusL.snp.left).offset(-12)
            make.height.greaterThanOrEqualTo(20)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
}

// MARK: - InspListDetailBasicView

class InspListDetailBasicView: UIView {
    let branchItem = InspListDetailItem()    // 网点名称
    let orderNumItem = InspListDetailItem()  // 巡检单号
    let serialNumItem = InspListDetailItem() // 巡检流水号
    let cycleItem = InspListDetailItem()     // 巡检周期
    let startItem = InspListDetailItem()     // 巡检开始时间
    let endItem = InspListDetailItem()       // 巡检结束时间
    let sponsorItem = InspListDetailItem()   // 巡检发起人
    let liableItem = InspListDetailItem()    // 网点负责人
    let contractorItem = InspListDetailItem() // 巡检工程商
    let engineerItem = InspListDetailItem()  // 巡检工程师
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        layer.masksToBounds = true
        backgroundColor = .white
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(withModal modal: ParListModal?) {
        branchItem.update(withKey: "网点名称:", value: modal?.deptName)
        orderNumItem.update(withKey: "巡检单号:", value: modal?.formSn)
        serialNumItem.update(withKey: "巡检流水号:", value: "84146")
        var cycle: String = "--"
        
        if modal?.startTime != nil || modal?.endTime != nil {
            cycle = "\(modal?.startTime ?? "无") ~ \(modal?.endTime ?? "无")"
        }
        cycleItem.update(withKey: "巡检周期:", value: cycle)
        startItem.update(withKey: "巡检开始时间:", value: modal?.startTime ?? "--")
        endItem.update(withKey: "巡检结束时间:", value: modal?.endTime ?? "--")
        sponsorItem.update(withKey: "巡检发起人:", value: modal?.operator ?? "--")
        liableItem.update(withKey: "网点负责人:", value: modal?.pcpName ?? "--")
        contractorItem.update(withKey: "巡检工程商:", value: modal?.serviceCompanyName ?? "--")
        engineerItem.update(withKey: "巡检工程师:", value: modal?.serviceEngineerName ?? "--")
    }
    
    func setupUI() {
        let basicTV = TitleItemView(withTitle: "基本信息")
        addSubview(basicTV)
        basicTV.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(46)
        }
                
        addSubview(branchItem)
        branchItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(basicTV.snp.bottom)
            make.height.equalTo(46)
        }

        addSubview(orderNumItem)
        orderNumItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(branchItem.snp.bottom)
            make.height.equalTo(branchItem.snp.height)
        }
        
        addSubview(serialNumItem)
        serialNumItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(orderNumItem.snp.bottom)
            make.height.equalTo(branchItem.snp.height)
        }
        
        addSubview(cycleItem)
        cycleItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(serialNumItem.snp.bottom)
            make.height.equalTo(branchItem.snp.height)
        }
        
        addSubview(startItem)
        startItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(cycleItem.snp.bottom)
            make.height.equalTo(branchItem.snp.height)
        }
        
        addSubview(endItem)
        endItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(startItem.snp.bottom)
            make.height.equalTo(branchItem.snp.height)
        }
        
        addSubview(sponsorItem)
        sponsorItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(endItem.snp.bottom)
            make.height.equalTo(branchItem.snp.height)
        }
        
        addSubview(liableItem)
        liableItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(sponsorItem.snp.bottom)
            make.height.equalTo(branchItem.snp.height)
        }
        
        addSubview(contractorItem)
        contractorItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(liableItem.snp.bottom)
            make.height.equalTo(branchItem.snp.height)
        }
        
        addSubview(engineerItem)
        engineerItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(contractorItem.snp.bottom)
            make.height.equalTo(branchItem.snp.height)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}

// MARK: - InspListDetailItem

class InspListDetailItem: UIView {
    var key: String? {
        didSet {
            keyL.text = key
        }
    }
    
    var val: String? {
        didSet {
            valueL.text = val
        }
    }
    
    let keyL = UILabel()
    let valueL = UILabel()
    let line = UIView()

    var keyWidth = 120.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    init(withKeyWidth width: CGFloat = 90.0) {
        super.init(frame: .zero)
        self.keyWidth = width
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(withKey key: String, value: String?) {
        keyL.text = key
        valueL.text = value
    }
    
    func setupUI() {
        line.backgroundColor = .hex("#F5F5F5")
        addSubview(line)
        line.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(self.snp.left).offset(12)
            make.right.equalTo(self.snp.right).offset(-12)
            make.height.equalTo(0.5)
        }
        
        keyL.textColor = .hex("#666666")
        keyL.font = .systemFont(ofSize: 14)
        addSubview(keyL)
        keyL.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(self.snp.left).offset(12)
            make.width.equalTo(keyWidth)
        }
        
        valueL.textColor = .hex("#444444")
        valueL.font = .systemFont(ofSize: 14)
        valueL.numberOfLines = 0
        addSubview(valueL)
        valueL.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(keyL.snp.right)
            make.right.equalTo(self.snp.right).offset(-12)
        }
    }
}

extension UIView {
    static func createBase() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        return view
    }
}
