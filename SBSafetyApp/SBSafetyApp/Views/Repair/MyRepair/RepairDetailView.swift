//
//  RepairDetailView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/26.
//

import Foundation
import UIKit

public enum RepairRecordStatus: Int {
    case finished = 0
    case current  = 1
}

class RepairDetailModal: NSObject {
    var key: String = ""
    var val: String = ""
    var subVal: String?
    
    init(key: String, val: String, subVal: String? = nil) {
        self.key = key
        self.val = val
        self.subVal = subVal
    }
}

class RepairDetailView: UIScrollView {
    let basicBV = UIView.createBase()
    let basicItem = RepairDetailBasicView() // 基本信息

    let ckpjBtn = UIButton.createCornerPrimary("查看评价")

    let recordBV = UIView.createBase()
    
    let commonBV = UIView.createBase()
    let commonV = UIView()
    let commonTV = TitleItemView(withTitle: "评论", hasIcon: false)

    let writeTV = BSTextView()
    let submitBtn = UIButton.createPrimaryLarge("发送评论")
    
    var modal: YjwxListModal?

    override init(frame: CGRect) {
        super.init(frame: frame)
        keyboardDismissMode = .interactive
        showsVerticalScrollIndicator = false
        bounces = true
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(withModal modal: YjwxListModal) {
        self.modal = modal
        
        basicItem.updateUI(withModal: modal)
        
        if modal.sfpj == 1 {
            ckpjBtn.snp.remakeConstraints { make in
                make.top.equalTo(basicItem.snp.bottom).offset(12)
                make.centerX.equalToSuperview()
                make.height.equalTo(40)
                make.width.equalTo(145)
                make.bottom.equalTo(basicBV.snp.bottom).offset(-14)
            }
        } else {
            ckpjBtn.snp.remakeConstraints { make in
                make.top.equalTo(basicItem.snp.bottom)
                make.centerX.equalToSuperview()
                make.height.equalTo(0)
                make.width.equalTo(145)
                make.bottom.equalTo(basicBV.snp.bottom).offset(-14)
            }
        }
    }
    
    func updateRecordUI(withModal _records: [YjwxRecordModal?]) {
        let records = _records.sorted { modal1, modal2 in
            return modal1?.bxjlztdm ?? 0 > modal2?.bxjlztdm ?? 0
        }
        
        recordBV.removeAllSubViews()
        
        let recordTV = TitleItemView(withTitle: "报修记录", hasIcon: false)
        recordBV.addSubview(recordTV)
        recordTV.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(46)
        }
        
        let line1 = UIView()
        line1.backgroundColor = .hex("#ECECEC")
        recordBV.addSubview(line1)
        line1.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(recordTV.snp.bottom)
            make.left.equalToSuperview().offset(13)
            make.right.equalToSuperview().offset(-13)
            make.width.equalTo(ScreenWidth - 60)
            make.height.equalTo(0.5)
        }

        var lastI: RepairRecordItem?
        for (index, record) in records.enumerated() {
            let itemV = RepairRecordItem()    // 网点名称
            itemV.update(withModal: record, status: index == 0 ? .current : .finished, isLast: index == records.count - 1)
            itemV.detailBtn.addTarget(self, action: #selector(recordTapped), for: .touchUpInside)
            itemV.detailBtn.record = record
            recordBV.addSubview(itemV)
            itemV.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                if lastI == nil {
                    make.top.equalTo(line1.snp.bottom).offset(20)
                } else {
                    make.top.equalTo(lastI!.snp.bottom)
                }
                make.height.equalTo(80)
                if index == records.count - 1 {
                    make.bottom.equalToSuperview()
                }
            }
            lastI = itemV
        }
    }
    
    func updateCommonUI(withCommons commons: [YjwxCommonModal?]) {
        commonV.removeAllSubViews()
        writeTV.text = ""
        commonTV.subTitle = "（\(commons.count)）"

        var lastI: RepairCommonView?
        for (index, common) in commons.enumerated() {
            let itemV = RepairCommonView()
            itemV.updateUI(withCommon: common!)
            commonV.addSubview(itemV)
            if index == commons.count - 1 {
                itemV.snp.makeConstraints { make in
                    make.left.right.equalToSuperview()
                    if lastI == nil {
                        make.top.equalTo(commonV.snp.top)
                    } else {
                        make.top.equalTo(lastI!.snp.bottom)
                    }
                    make.bottom.equalToSuperview()
                }
            } else {
                itemV.snp.makeConstraints { make in
                    make.left.right.equalToSuperview()
                    if lastI == nil {
                        make.top.equalTo(commonV.snp.top)
                    } else {
                        make.top.equalTo(lastI!.snp.bottom)
                    }
                }
            }
            lastI = itemV
        }
    }

    @objc func recordTapped(_ sender: RepairModalButton) {
        let record = sender.record
        
        if record?.bxjlztdm == RepairStatus.completed.rawValue { // 确认修复详情
            getFirstViewController()?.navigationController?.pushViewController(ConfirmRepairDetailVC(withModal: modal!), animated: true)
            
        } else if record?.bxjlztdm == RepairStatus.toBeConfirmed.rawValue { // 单据详情
            getFirstViewController()?.navigationController?.pushViewController(DocumentDetailVC(withModal: modal!), animated: true)
        }
    }
    
    func setupBasicView() {
        addSubview(basicBV)
        basicBV.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth - 20)
        }
            
        basicBV.addSubview(basicItem)
        basicItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(basicBV.snp.top).offset(5)
        }
        
        basicBV.addSubview(ckpjBtn)
        ckpjBtn.snp.makeConstraints { make in
            make.top.equalTo(basicItem.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(145)
            make.bottom.equalTo(basicBV.snp.bottom).offset(-14)
        }
    }
    
    func setupCommonView() {
        addSubview(commonBV)
        commonBV.snp.makeConstraints { make in
            make.top.equalTo(recordBV.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth - 20)
            make.bottom.equalToSuperview().offset(-40)
        }
        
        commonBV.addSubview(commonTV)
        commonTV.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(46)
        }
        
        commonBV.addSubview(commonV)
        commonV.snp.makeConstraints { make in
            make.top.equalTo(commonTV.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
        }
        
        writeTV.placeholder = "写评论"
        writeTV.backgroundColor = .hex("#F9F9F9")
        writeTV.layer.cornerRadius = 10
        writeTV.layer.masksToBounds = true
        writeTV.textContainerInset = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 10)
        commonBV.addSubview(writeTV)
        writeTV.snp.makeConstraints { make in
            make.top.equalTo(commonV.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(80)
        }
        
        commonBV.addSubview(submitBtn)
        submitBtn.snp.makeConstraints { make in
            make.top.equalTo(writeTV.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    func setupUI() {
        // 基本信息
        setupBasicView()
        
        // 报修记录
        addSubview(recordBV)
        recordBV.snp.makeConstraints { make in
            make.top.equalTo(basicBV.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth - 20)
        }
        
        // 评论
        setupCommonView()

    }
}

class RepairRecordStatusView: UIView {

    var status: RepairRecordStatus = .finished {
        didSet {
            updateUI()
        }
    }
    
    var title: String = "" {
        didSet {
            updateUI()
        }
    }

    let titleL = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    init(withStatus status: RepairRecordStatus) {
        super.init(frame: .zero)
        self.status = status
        setupUI()
    }
    
    func updateUI() {
        titleL.text = title
        titleL.textColor = status == .finished ? .hex("#506A91") : .white
        titleL.backgroundColor = status == .finished ? .hex("#F1F3F6") : .primary
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        layer.borderColor = UIColor.hex("#E2E8F1").cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 21
        layer.masksToBounds = true

        titleL.numberOfLines = 0
        titleL.font = .systemFont(ofSize: 12)
        titleL.textColor = .hex("#506A91")
        titleL.layer.cornerRadius = 17.5
        titleL.layer.masksToBounds = true
        titleL.textAlignment = .center
        addSubview(titleL)
        titleL.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(35)

        }
    }
}

class RepairRecordItem: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(withModal modal: YjwxRecordModal?, status: RepairRecordStatus, isLast: Bool) {
        statusV.status = status
        detailBtn.isHidden = true

        nameL.text = modal?.bxjlwz
        dateL.text = modal?.bxjlsj
        
        switch modal?.bxjlztdm {
            
        case RepairStatus.pendingOrder.rawValue:
            statusV.title = "报修";
            break
        case RepairStatus.readyToGo.rawValue:
            statusV.title = "接单";
            break
        case RepairStatus.pendingArrival.rawValue:
            statusV.title = "出发";
            break
        case RepairStatus.toBeFixed.rawValue:
            statusV.title = "到达";
            break
        case RepairStatus.toBeConfirmed.rawValue:
            statusV.title = "修复";
            detailBtn.isHidden = false
            break
        case RepairStatus.completed.rawValue:
            statusV.title = "确认修复";
            detailBtn.isHidden = false
            break
        default: break
        }
        
        arrowIV.isHidden = isLast
    }
    
    // MARK: - Setup
    func setupUI() {
        addSubview(statusV)
        statusV.snp.makeConstraints { make in
            make.width.height.equalTo(41)
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(20)
        }
        
        addSubview(nameL)
        nameL.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.left.equalTo(statusV.snp.right).offset(10)
            make.right.equalToSuperview().offset(-20)
        }
        
        addSubview(dateL)
        dateL.snp.makeConstraints { make in
            make.top.equalTo(nameL.snp.bottom).offset(10)
            make.left.equalTo(nameL.snp.left)
        }
        
        addSubview(arrowIV)
        arrowIV.snp.makeConstraints { make in
            make.centerX.equalTo(statusV.snp.centerX)
            make.top.equalTo(statusV.snp.bottom).offset(7)
        }
        
        addSubview(detailBtn)
        detailBtn.snp.makeConstraints { make in
            make.right.equalTo(self.snp.right).offset(-20)
            make.centerY.equalTo(dateL.snp.centerY)
            make.height.equalTo(20)
            make.width.equalTo(41)
        }
    }
    
    lazy var statusV: RepairRecordStatusView = {
        let v = RepairRecordStatusView()
        return v
    }()
    
    lazy var nameL: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 15)
        return lab
    }()
    
    lazy var dateL: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 13)
        lab.textColor = .hex("#9E9E9E")
        return lab
    }()
    
    lazy var arrowIV: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "ic_repair_toparrow"))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var detailBtn: RepairModalButton = {
        let btn = RepairModalButton(type: .custom)
        btn.setTitle("详情", for: .normal)
        btn.setTitleColor(.hex("#F28D58"), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize:11)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor.hex("#F28D58").cgColor
        return btn
    }()
}
