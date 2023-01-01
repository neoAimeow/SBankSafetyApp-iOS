//
//  SETaskHallCell.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/29.
//

import Foundation
import UIKit

class SETaskHallCell: UITableViewCell {
    let baseV = UIView()
    let branchL = UILabel()
    let orderNumL = InspListItem(withWidth: 80)
    let createAtL = InspListItem(withWidth: 80)
    let errorL = InspListItem(withWidth: 80)
    let statusL = PaddingLabel()
    
    let collectionV = SEImageCollectionView()

    let itemHeight = (ScreenWidth - 100) / 5
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .bg
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func allHidden(withModal modal: YjwxListModal) {
        acceptBtn.modal = modal
        confirmedArrivalBtn.modal = modal
        startRepairBtn.modal = modal
        reviewsBtn.modal = modal
        
        acceptBtn.isHidden = true
        confirmedArrivalBtn.isHidden = true
        startRepairBtn.isHidden = true
        reviewsBtn.isHidden = true
    }
    
    func reload(withModal modal: YjwxListModal) {
        
        allHidden(withModal: modal)
        
        switch modal.ddzt {
        case RepairStatus.pendingOrder.rawValue:
            statusL.layer.borderColor = UIColor.hex("#BF02EE").cgColor
            statusL.textColor = .hex("#BF02EE")
            statusL.text = "待接单"
            acceptBtn.isHidden = false
            break
        case RepairStatus.readyToGo.rawValue:
            statusL.layer.borderColor = UIColor.hex("#666666").cgColor
            statusL.textColor = .hex("#666666")
            statusL.text = "待出发"
            break
        case RepairStatus.pendingArrival.rawValue:
            statusL.layer.borderColor = UIColor.hex("#00C0FF").cgColor
            statusL.textColor = .hex("#00C0FF")
            statusL.text = "待到达"
            confirmedArrivalBtn.isHidden = false
            break
        case RepairStatus.toBeFixed.rawValue:
            statusL.layer.borderColor = UIColor.hex("#F19F00").cgColor
            statusL.textColor = .hex("#F19F00")
            statusL.text = "待修复"
            startRepairBtn.isHidden = false
            break
        case RepairStatus.toBeConfirmed.rawValue:
            statusL.layer.borderColor = UIColor.hex("#1EA200").cgColor
            statusL.textColor = .hex("#1EA200")
            statusL.text = "待确认"
            break
        case RepairStatus.completed.rawValue:
            statusL.layer.borderColor = UIColor.hex("#0F499E").cgColor
            statusL.textColor = .hex("#0F499E")
            statusL.text = "已完工"
            if modal.sfpj != nil && modal.sfpj == 1 {
                reviewsBtn.isHidden = false
            }
            break
        case RepairStatus.cancelled.rawValue:
            statusL.layer.borderColor = UIColor.hex("#FF0000").cgColor
            statusL.textColor = .hex("#FF0000")
            statusL.text = "已取消"
            break
        default: break
        }

        branchL.text = modal.wdmc
        orderNumL.update(withKey: "报修单号：", value: modal.bxdh)
        createAtL.update(withKey: "报修时间：", value: modal.bxsj)
        errorL.update(withKey: "报修故障：", value: modal.bxgzmc)

        collectionV.imgs = modal.enclosureListStr ?? []
        let count = CGFloat(collectionV.imgs.count / 5 + 1)
        baseV.snp.updateConstraints { make in
            make.height.equalTo(110 + (itemHeight + 10) * count)
        }
    }
    
    func cellHeight(withModal modal: YjwxListModal) -> CGFloat {
        let imgs = modal.enclosureListStr ?? []

        let count = imgs.count == 0 ? 0 : CGFloat(imgs.count / 5 + 1)
        return 120 + (itemHeight + 10) * count
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
            make.height.equalTo(186)
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
            make.top.equalTo(iconIV.snp.bottom).offset(12)
            make.left.equalTo(branchL.snp.left)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(25)
        }
        
        baseV.addSubview(createAtL)
        createAtL.snp.makeConstraints { make in
            make.top.equalTo(orderNumL.snp.bottom)
            make.left.equalTo(orderNumL.snp.left)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(25)

        }
        
        baseV.addSubview(errorL)
        errorL.snp.makeConstraints { make in
            make.top.equalTo(createAtL.snp.bottom)
            make.left.equalTo(orderNumL.snp.left)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(25)
        }
        
        statusL.insets = UIEdgeInsets(top: 5, left: 7, bottom: 5, right: 7)
        statusL.font = .systemFont(ofSize: 12)
        statusL.layer.masksToBounds = true
        statusL.layer.cornerRadius = 2
        statusL.layer.borderWidth = 0.5
        statusL.layer.borderColor = UIColor.hex("#BF02EE").cgColor
        statusL.textColor = .hex("#BF02EE")
        statusL.text = "待接单"
        baseV.addSubview(statusL)
        statusL.snp.makeConstraints { make in
            make.centerY.equalTo(iconIV.snp.centerY)
            make.left.equalTo(branchL.snp.right).offset(9)
            make.height.equalTo(20)
        }
        
        collectionV.itemHeight = itemHeight
        baseV.addSubview(collectionV)
        collectionV.snp.makeConstraints { (make) in
            make.top.equalTo(errorL.snp.bottom).offset(4)
            make.left.equalTo(orderNumL.snp.left)
            make.right.equalToSuperview().offset(-12)
        }
        
        acceptBtn.isHidden = true
        baseV.addSubview(acceptBtn)
        acceptBtn.snp.makeConstraints { make in
            make.centerY.equalTo(branchL.snp.centerY)
            make.right.equalTo(baseV.snp.right).offset(-13)
            make.height.equalTo(20)
            make.width.equalTo(60)
        }
        
        confirmedArrivalBtn.isHidden = true
        baseV.addSubview(confirmedArrivalBtn)
        confirmedArrivalBtn.snp.makeConstraints { make in
            make.centerY.equalTo(branchL.snp.centerY)
            make.right.equalTo(baseV.snp.right).offset(-13)
            make.height.equalTo(20)
            make.width.equalTo(60)
        }

        startRepairBtn.isHidden = true
        baseV.addSubview(startRepairBtn)
        startRepairBtn.snp.makeConstraints { make in
            make.centerY.equalTo(branchL.snp.centerY)
            make.right.equalTo(baseV.snp.right).offset(-13)
            make.height.equalTo(20)
            make.width.equalTo(60)
        }

        reviewsBtn.isHidden = true
        baseV.addSubview(reviewsBtn)
        reviewsBtn.snp.makeConstraints { make in
            make.centerY.equalTo(branchL.snp.centerY)
            make.right.equalTo(baseV.snp.right).offset(-13)
            make.height.equalTo(20)
            make.width.equalTo(60)
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
    
    lazy var acceptBtn: RepairModalButton = {
        let btn = RepairModalButton(type: .custom)
        btn.setTitle("接单", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 12)
        btn.setBGColor(.primary, for: .normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    lazy var confirmedArrivalBtn: RepairModalButton = {
        let btn = RepairModalButton(type: .custom)
        btn.setTitle("确认到达", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 12)
        btn.setBGColor(.primary, for: .normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 10
        return btn
    }()

    lazy var startRepairBtn: RepairModalButton = {
        let btn = RepairModalButton(type: .custom)
        btn.setTitle("开始修复", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 12)
        btn.setBGColor(.primary, for: .normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 10
        return btn
    }()

    lazy var reviewsBtn: RepairModalButton = {
        let btn = RepairModalButton(type: .custom)
        btn.setTitle("查看评价", for: .normal)
        btn.setTitleColor(.primary, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 12)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor.primary.cgColor
        return btn
    }()
}
