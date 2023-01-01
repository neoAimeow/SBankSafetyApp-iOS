//
//  ConfirmRepairDetailRestoreView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/9.
//

import Foundation
import UIKit

class ConfirmRepairDetailRestoreView: UIView {
    let fwlxItem = RepairDetailItem(placeholder: "服务类型:")   /// 服务类型
    let fwmsItem = RepairDetailItem(placeholder: "服务描述:")   /// 服务描述
    let gzppItem = RepairDetailItem(placeholder: "故障品牌:")   /// 故障品牌
    let gzlxItem = RepairDetailItem(placeholder: "故障类型:")   /// 故障类型
    let gzsbItem = RepairDetailItem(placeholder: "故障设备:")   /// 故障设备
    let gzxxItem = RepairDetailItem(placeholder: "故障现象:")   /// 故障现象
    let gzyyItem = RepairDetailItem(placeholder: "故障原因:")   /// 故障原因
    let wzxxItem = RepairDetailItem(placeholder: "位置信息:")   /// 位置信息
    let wxmsItem = RepairDetailItem(placeholder: "维修描述:")   /// 维修描述
    let xfcgItem = RepairDetailItem(placeholder: "修复成功:")   /// 修复成功
    let ghsbItem = RepairDetailItem(placeholder: "更换设备:")   /// 更换设备
   
    let signBV = UIView.createBase()
    let imgV = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(withRestore restore: YjwxRestoreModal?) {
        fwlxItem.value = restore?.fwlx
        fwmsItem.value = restore?.fwms
        gzppItem.value = restore?.gzpp
        gzlxItem.value = restore?.gzlx
        gzsbItem.value = restore?.gzsb
        gzxxItem.value = restore?.gzxx
        gzyyItem.value = restore?.gzyy
        wzxxItem.value = restore?.wzxx
        wxmsItem.value = restore?.wxms
        xfcgItem.value = restore?.xfcg
        ghsbItem.value = restore?.ghsb
    }

    func setupUI() {
        addSubview(fwlxItem)
        fwlxItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(30)
        }
        
        addSubview(fwmsItem)
        fwmsItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(fwlxItem.snp.bottom)
            make.height.equalTo(fwlxItem.snp.height)
        }
        
        addSubview(gzppItem)
        gzppItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(fwmsItem.snp.bottom)
            make.height.equalTo(fwlxItem.snp.height)
        }
        
        addSubview(gzlxItem)
        gzlxItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(gzppItem.snp.bottom)
            make.height.equalTo(fwlxItem.snp.height)
        }
        
        addSubview(gzsbItem)
        gzsbItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(gzlxItem.snp.bottom)
            make.height.equalTo(fwlxItem.snp.height)
        }
        
        addSubview(gzxxItem)
        gzxxItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(gzsbItem.snp.bottom)
            make.height.equalTo(fwlxItem.snp.height)
        }
        
        addSubview(gzyyItem)
        gzyyItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(gzxxItem.snp.bottom)
            make.height.equalTo(fwlxItem.snp.height)
        }
        
        addSubview(wzxxItem)
        wzxxItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(gzyyItem.snp.bottom)
            make.height.equalTo(fwlxItem.snp.height)
        }

        addSubview(wxmsItem)
        wxmsItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(wzxxItem.snp.bottom)
            make.height.equalTo(fwlxItem.snp.height)
        }
        
        addSubview(xfcgItem)
        xfcgItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(wxmsItem.snp.bottom)
            make.height.equalTo(fwlxItem.snp.height)
        }
        
        addSubview(ghsbItem)
        ghsbItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(xfcgItem.snp.bottom)
            make.height.equalTo(fwlxItem.snp.height)
            make.bottom.equalToSuperview().offset(-14)
        }
    }
}
