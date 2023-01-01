//
//  RepairDetailBasicView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/9.
//

import Foundation
import UIKit

class RepairDetailBasicView: UIView {
    let orderNoItem = RepairDetailItem(placeholder: "报修单号:")    // 报修单号
    let branchItem = RepairDetailItem(placeholder: "网点名称:")     // 网点名称
    let createAtItem = RepairDetailItem(placeholder: "报修时间:") // 报修时间
    let personItem = RepairDetailItem(placeholder: "报修人:")     // 报修人
    let liableItem = RepairDetailItem(placeholder: "网点责任人:")    // 网点责任人
    let contractorItem = RepairDetailItem(placeholder: "维修工程商:") // 维修工程商
    let engineerItem = RepairDetailItem(placeholder: "维修工程师:")  // 维修工程师
    let errorItem = RepairDetailItem(placeholder: "报修故障:")       // 报修故障
    let detailItem = RepairDetailItem(placeholder: "报修详情:")   // 报修详情
    let fujianItem = RepairFujianItem(placeholder: "附件:")   // 报修详情
  
    var modal: YjwxListModal?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(withModal modal: YjwxListModal) {
        self.modal = modal
        
        orderNoItem.value = modal.bxdh
        branchItem.value = modal.wdmc
        createAtItem.value = modal.bxsj
        personItem.value = modal.bxrmc
        liableItem.value = modal.wdzrr
        contractorItem.value = modal.wxgcs
        engineerItem.value = modal.wxgcsmc
        errorItem.value = modal.bxgzmc
        detailItem.value = modal.bxgzms
        
        fujianItem.update(withImgs: modal.enclosureListStr ?? [])
        
        if modal.enclosureListStr != nil && modal.enclosureListStr!.count > 0 {
            fujianItem.isHidden = false
            fujianItem.snp.remakeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalTo(detailItem.snp.bottom).offset(6)
                make.bottom.equalToSuperview()
            }
        } else {
            fujianItem.isHidden = true
            fujianItem.snp.remakeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalTo(detailItem.snp.bottom)
                make.height.equalTo(0)
                make.bottom.equalToSuperview()
            }
        }
    }
    
    func setupUI() {
        addSubview(orderNoItem)
        orderNoItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.snp.top).offset(5)
            make.height.equalTo(35)
        }

        addSubview(branchItem)
        branchItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(orderNoItem.snp.bottom)
            make.height.equalTo(35)
        }
        
        addSubview(createAtItem)
        createAtItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(branchItem.snp.bottom)
            make.height.equalTo(35)
        }
        
        addSubview(personItem)
        personItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(createAtItem.snp.bottom)
            make.height.equalTo(35)
        }
        
        addSubview(liableItem)
        liableItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(personItem.snp.bottom)
            make.height.equalTo(35)
        }
        
        addSubview(contractorItem)
        contractorItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(liableItem.snp.bottom)
            make.height.equalTo(35)
        }
        
        addSubview(engineerItem)
        engineerItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(contractorItem.snp.bottom)
            make.height.equalTo(35)
        }
        
        addSubview(errorItem)
        errorItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(engineerItem.snp.bottom)
            make.height.equalTo(35)
        }
        
        addSubview(detailItem)
        detailItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(errorItem.snp.bottom)
            make.height.equalTo(35)
        }
        
        addSubview(fujianItem)
        fujianItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(detailItem.snp.bottom).offset(6)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
}

class RepairDetailItem: UIView {
    let keyL = UILabel()
    let valueL = UILabel()
    
    let subValueBtn = UIButton(type: .custom)

    var keyWidth = 96.0
    var placeholder: String = "" {
        didSet {
            keyL.text = placeholder
        }
    }
    
    var value: String? = "--" {
        didSet {
            valueL.text = value ?? "--"
        }
    }

    var textAlignment: NSTextAlignment = NSTextAlignment.right {
        didSet {
            keyL.textAlignment = textAlignment
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    init(withKeyWidth width: CGFloat? = nil, placeholder: String? = nil) {
        super.init(frame: .zero)
        if width != nil { self.keyWidth = width! }
        setupUI()
        if placeholder != nil {
            self.placeholder = placeholder!
            keyL.text = placeholder!
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(withModal modal: RepairDetailModal) {
        keyL.text = modal.key
        valueL.text = modal.val
        subValueBtn.isHidden = modal.subVal == nil
        if modal.subVal != nil {
            subValueBtn.setTitle("\(modal.subVal!)", for: .normal)
        }
    }
    
    // MARK: - Setup
    func setupUI() {
        keyL.textColor = .hex("#666666")
        keyL.font = .systemFont(ofSize: 14)
        keyL.textAlignment = .right
        addSubview(keyL)
        keyL.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.snp.left).offset(20)
            make.width.equalTo(keyWidth)
        }
        
        valueL.text = placeholder
        valueL.font = .systemFont(ofSize: 15)
        valueL.numberOfLines = 0
        addSubview(valueL)
        valueL.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(keyL.snp.right).offset(14)
        }
        
        subValueBtn.titleLabel?.font = .systemFont(ofSize: 15)
        subValueBtn.setTitleColor(.primary, for: .normal)
        addSubview(subValueBtn)
        subValueBtn.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(valueL.snp.right).offset(10)
            make.height.equalTo(40)
        }
    }
}

class RepairFujianItem: UIView {
    let keyL = UILabel()
    let collectionV = SEImageCollectionView()

    var keyWidth = 96.0
    var placeholder: String = "附件" {
        didSet {
            keyL.text = placeholder
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    init(withKeyWidth width: CGFloat? = nil, placeholder: String? = nil) {
        super.init(frame: .zero)
        if width != nil { self.keyWidth = width! }
        setupUI()
        if placeholder != nil {
            self.placeholder = placeholder!
            keyL.text = placeholder!
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(withImgs imgs: [String]) {
        collectionV.imgs = imgs
        let count = CGFloat(imgs.count / 5 + 1)
        collectionV.snp.updateConstraints { make in
            make.height.equalTo(65 * count)
        }
    }
    
    // MARK: - Setup
    func setupUI() {
        keyL.textColor = .hex("#666666")
        keyL.font = .systemFont(ofSize: 14)
        keyL.textAlignment = .right
        addSubview(keyL)
        keyL.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left).offset(20)
            make.width.equalTo(keyWidth)
//            make.height.equalTo(20)
        }
        
        collectionV.itemHeight = 55
        addSubview(collectionV)
        collectionV.snp.makeConstraints { (make) in
            make.top.equalTo(keyL.snp.top)
            make.left.equalTo(keyL.snp.right).offset(14)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview()
            make.height.equalTo(55)
        }
    }
}
