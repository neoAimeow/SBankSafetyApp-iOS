//
//  FeedbackDetailView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/5.
//
// 【首页-工单及反馈】我的反馈列表

import Foundation
import UIKit

class FeedbackDetailView: UIView {
    let typeItem = RepairDetailItem(withKeyWidth: 70)    // 反馈类型
    let nameItem = RepairDetailItem(withKeyWidth: 70)    // 反馈标题
    let dateItem = RepairDetailItem(withKeyWidth: 70)    // 反馈时间

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
        let txt = "更新最新版后，很卡，每一个选项、菜单点进去要3秒左右才有反应，扫码摄像头也是，要对焦好久才能用，使用体验不是很方便。"
        let pstyle = NSMutableParagraphStyle()
        pstyle.lineSpacing = 6
        valueL.attributedText = NSAttributedString(string: txt, attributes: [.paragraphStyle : pstyle])
        
        typeItem.update(withModal: RepairDetailModal(key: "反馈类型", val: "FAQ"))
        nameItem.update(withModal: RepairDetailModal(key: "反馈标题", val: "为什么版本更新后，反而更卡"))
        dateItem.update(withModal: RepairDetailModal(key: "反馈时间", val: "2022-07-23 19:09"))
    }
    
    func setupUI() {
        addSubview(baseV)
        baseV.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
        }
        
        baseV.addSubview(valueL)
        valueL.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(20)
        }
        
        baseV.addSubview(line)
        line.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(valueL.snp.bottom).offset(25)
            make.left.equalTo(valueL.snp.left)
            make.right.equalTo(valueL.snp.right)
            make.height.equalTo(0.5)
        }
        
        typeItem.keyL.textAlignment = .left
        baseV.addSubview(typeItem)
        typeItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(line.snp.bottom).offset(20)
            make.height.equalTo(35)
        }
        
        nameItem.keyL.textAlignment = .left
        baseV.addSubview(nameItem)
        nameItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(typeItem.snp.bottom)
            make.height.equalTo(35)
        }
        
        dateItem.keyL.textAlignment = .left
        baseV.addSubview(dateItem)
        dateItem.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(nameItem.snp.bottom)
            make.height.equalTo(35)
            make.bottom.equalToSuperview().offset(-25)
        }
    }
    
    lazy var valueL: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.numberOfLines = 0
        return lab
    }()
    
    lazy var line: UIView = {
        let li = UIView()
        li.backgroundColor = .hex("#F3F3F3")
        return li
    }()
    
    lazy var baseV: UIView = {
        let v = UIView()
        v.layer.masksToBounds = true
        v.layer.cornerRadius = 10
        v.backgroundColor = .white
        return v
    }()
}
