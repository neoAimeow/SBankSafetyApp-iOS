//
//  DocumentDetailView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/27.
//

import Foundation
import UIKit

class DocumentDetailView: UIScrollView {
    
    let basicBV = ConfirmRepairDetailBaseView()
    
    let restoreBV = UIView.createBase()
    let restoreTV = TitleItemView(withTitle: "维修记录", hasIcon: false)
    let restoreItem = ConfirmRepairDetailRestoreView() /// 维修记录
   
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
        basicBV.updateUI(withModal: modal)
    }
    
    func updateUI(withRestore restore: YjwxRestoreModal?) {
        restoreTV.rightTitle = "本次维修费用\(restore?.wxbj ?? 0)元"
        restoreItem.update(withRestore: restore)
    }

    func setupRecordView() {
        addSubview(restoreBV)
        restoreBV.snp.makeConstraints { make in
            make.top.equalTo(basicBV.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth - 20)
            make.bottom.equalToSuperview().offset(-40)
        }
        
        restoreBV.addSubview(restoreTV)
        restoreTV.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(46)
        }
        
        let line = UIView()
        line.backgroundColor = .hex("#ECECEC")
        restoreBV.addSubview(line)
        line.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(restoreTV.snp.bottom)
            make.left.equalToSuperview().offset(13)
            make.right.equalToSuperview().offset(-13)
            make.height.equalTo(0.5)
        }
        
        restoreBV.addSubview(restoreItem)
        restoreItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(line.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-14)
        }
    }
    
    func setupUI() {
        // 基本信息
        addSubview(basicBV)
        basicBV.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth - 20)
        }
        
        // 报修记录
        setupRecordView()
    }
}

//class DocumentDetailView: UIScrollView {
//
//    let basicBV = UIView.createBase()
//    let gzppItem = RepairDetailItem()    // 故障品牌
//    let gzlxItem = RepairDetailItem() // 故障类型
//    let gzsbItem = RepairDetailItem()     // 故障设备
//    let gzxxItem = RepairDetailItem()    // 故障现象
//    let gzyyItem = RepairDetailItem()     // 故障原因
//    let wzxxItem = RepairDetailItem() // 位置信息
//    let wxmsItem = RepairDetailItem()  // 维修描述
//    let xfcgItem = RepairDetailItem()       // 修复成功
//    let ghsbItem = RepairDetailItem()   // 更换设备
//
//    let quotationVC = UIView.createBase()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        keyboardDismissMode = .onDrag
//        showsVerticalScrollIndicator = false
//        bounces = true
//        setupUI()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func updateUI() {
//        gzppItem.update(withModal: RepairDetailModal(key: "故障品牌:", val: "--"))
//        gzlxItem.update(withModal: RepairDetailModal(key: "故障类型:", val: "门禁故障"))
//        gzsbItem.update(withModal: RepairDetailModal(key: "故障设备:", val: "开门按钮"))
//        gzxxItem.update(withModal: RepairDetailModal(key: "故障现象:", val: "不开门"))
//        gzyyItem.update(withModal: RepairDetailModal(key: "故障原因:", val: "故障"))
//        wzxxItem.update(withModal: RepairDetailModal(key: "位置信息:", val: "--"))
//        wxmsItem.update(withModal: RepairDetailModal(key: "维修描述:", val: "澄弹簧松动"))
//        xfcgItem.update(withModal: RepairDetailModal(key: "修复成功:", val: "是"))
//        ghsbItem.update(withModal: RepairDetailModal(key: "更换设备:", val: "--"))
//    }
//
//    func setupBasicView() {
//        addSubview(basicBV)
//        basicBV.snp.makeConstraints { make in
//            make.top.equalTo(self.snp.top).offset(10)
//            make.centerX.equalToSuperview()
//            make.width.equalTo(ScreenWidth - 20)
//        }
//
//        let basicTV = TitleItemView(withTitle: "设备故障", hasIcon: false, rightTitle: "维修单价：0.0元")
//        basicBV.addSubview(basicTV)
//        basicTV.snp.makeConstraints { make in
//            make.top.left.right.equalToSuperview()
//            make.height.equalTo(46)
//        }
//
//        let line = UIView()
//        line.backgroundColor = .hex("#ECECEC")
//        basicBV.addSubview(line)
//        line.snp.makeConstraints { (make) -> Void in
//            make.top.equalTo(basicTV.snp.bottom)
//            make.left.equalToSuperview().offset(13)
//            make.right.equalToSuperview().offset(-13)
//            make.height.equalTo(0.5)
//        }
//
//        gzppItem.textAlignment = .left
//        basicBV.addSubview(gzppItem)
//        gzppItem.snp.makeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.top.equalTo(line.snp.top).offset(10)
//            make.height.equalTo(25)
//        }
//
//        gzlxItem.textAlignment = .left
//        basicBV.addSubview(gzlxItem)
//        gzlxItem.snp.makeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.top.equalTo(gzppItem.snp.bottom)
//            make.height.equalTo(25)
//        }
//
//        gzsbItem.textAlignment = .left
//        basicBV.addSubview(gzsbItem)
//        gzsbItem.snp.makeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.top.equalTo(gzlxItem.snp.bottom)
//            make.height.equalTo(25)
//        }
//
//        gzyyItem.textAlignment = .left
//        basicBV.addSubview(gzyyItem)
//        gzyyItem.snp.makeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.top.equalTo(gzsbItem.snp.bottom)
//            make.height.equalTo(25)
//        }
//
//        gzxxItem.textAlignment = .left
//        basicBV.addSubview(gzxxItem)
//        gzxxItem.snp.makeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.top.equalTo(gzyyItem.snp.bottom)
//            make.height.equalTo(25)
//        }
//
//        wzxxItem.textAlignment = .left
//        basicBV.addSubview(wzxxItem)
//        wzxxItem.snp.makeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.top.equalTo(gzxxItem.snp.bottom)
//            make.height.equalTo(25)
//        }
//
//        wxmsItem.textAlignment = .left
//        basicBV.addSubview(wxmsItem)
//        wxmsItem.snp.makeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.top.equalTo(wzxxItem.snp.bottom)
//            make.height.equalTo(25)
//        }
//
//        xfcgItem.textAlignment = .left
//        basicBV.addSubview(xfcgItem)
//        xfcgItem.snp.makeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.top.equalTo(wxmsItem.snp.bottom)
//            make.height.equalTo(25)
//        }
//
//        ghsbItem.textAlignment = .left
//        basicBV.addSubview(ghsbItem)
//        ghsbItem.snp.makeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.top.equalTo(xfcgItem.snp.bottom)
//            make.height.equalTo(25)
//            make.bottom.equalTo(basicBV.snp.bottom).offset(-14)
//        }
//    }
//
//    func setupQuotationView() {
//        addSubview(quotationVC)
//        quotationVC.snp.makeConstraints { make in
//            make.top.equalTo(basicBV.snp.bottom).offset(10)
//            make.centerX.equalToSuperview()
//            make.width.equalTo(ScreenWidth - 20)
//            make.bottom.equalToSuperview().offset(-40)
//        }
//
//        let quotationTV = TitleItemView(withTitle: "维修报价", hasIcon: false, rightTitle: "本次维修费用：0.0元")
//        quotationVC.addSubview(quotationTV)
//        quotationTV.snp.makeConstraints { make in
//            make.bottom.top.left.right.equalToSuperview()
//            make.height.equalTo(49)
//        }
//    }
//
//    func setupUI() {
//        // 基本信息
//        setupBasicView()
//
//        // 签名
//        setupQuotationView()
//    }
//}
