//
//  MyReviewsView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/25.
//

import Foundation
import UIKit

class MyReviewsView: UIScrollView {
    var enabled: Bool = true {
        didSet {
            updateView()
        }
    }
    
    let speedV = BSRateView()
    let effectV = BSRateView()
    let attitudeV = BSRateView()

    let tagV = TagListView()
    
    let commonTV = BSTextView()

    let submitBtn = UIButton.createPrimaryLarge("发送评价")

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
    
    func updateView() {
        isUserInteractionEnabled = enabled
        submitBtn.isHidden = !enabled
        commonTV.placeholder = enabled ? "请输入评价内容" : ""

    }
    
    func updateUI(withModal modal: YjwxEvaluateModal?) {
        speedV.ratingValue = modal?.xfsd ?? 0
        effectV.ratingValue = modal?.wxxg ?? 0
        attitudeV.ratingValue = modal?.fwtd ?? 0
        
        tagV.removeAllTags()
        
        tagV.addTag("五星好评").isSelected = modal?.wxhp == 1 ? true : false
        tagV.addTag("响应速度快").isSelected = modal?.xysdk == 1 ? true : false
        tagV.addTag("修复及时").isSelected = modal?.xfjs == 1 ? true : false
        tagV.addTag("服务态度好").isSelected = modal?.fwtdh == 1 ? true : false
        tagV.addTag("技术精湛").isSelected = modal?.jsjz == 1 ? true : false
        tagV.addTag("人长得帅").isSelected = modal?.rzds == 1 ? true : false
        
        commonTV.text = modal?.pjnr ?? "默认系统评价"
    }
    
    func setupUI() {
        speedV.title = "修复速度"
//        speedV.ratingValue = 5
        addSubview(speedV)
        speedV.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(26)
            make.left.equalToSuperview().offset(40)
            make.height.equalTo(40)
        }
        
        effectV.title = "维修效果"
//        effectV.ratingValue = 5
        addSubview(effectV)
        effectV.snp.makeConstraints { make in
            make.top.equalTo(speedV.snp.bottom).offset(6)
            make.left.equalTo(speedV.snp.left)
            make.height.equalTo(40)
        }
        
        attitudeV.title = "服务态度"
//        attitudeV.ratingValue = 5
        addSubview(attitudeV)
        attitudeV.snp.makeConstraints { make in
            make.top.equalTo(effectV.snp.bottom).offset(6)
            make.left.equalTo(speedV.snp.left)
            make.height.equalTo(40)
        }
        
        let line1 = UIView()
        line1.backgroundColor = .hex("#E8E8E8")
        addSubview(line1)
        line1.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(attitudeV.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.width.equalTo(ScreenWidth - 80)
            make.height.equalTo(0.5)
        }
        
        tagV.addTag("五星好评").isSelected = false
        tagV.addTag("响应速度快").isSelected = false
        tagV.addTag("修复及时").isSelected = false
        tagV.addTag("服务态度好").isSelected = false
        tagV.addTag("技术精湛").isSelected = false
        tagV.addTag("人长得帅").isSelected = false
        tagV.alignment = .left
        addSubview(tagV)
        tagV.snp.makeConstraints { make in
            make.top.equalTo(line1.snp.bottom).offset(32)
            make.left.equalTo(line1.snp.left)
            make.right.equalTo(line1.snp.right)
            make.height.equalTo(60)
        }
        
        let line2 = UIView()
        line2.backgroundColor = .hex("#E8E8E8")
        addSubview(line2)
        line2.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(tagV.snp.bottom).offset(40)
            make.left.equalTo(line1.snp.left)
            make.right.equalTo(line1.snp.right)
            make.height.equalTo(0.5)
        }
        
        let commonL = UILabel()
        commonL.text = "评价内容"
        commonL.font = .systemFont(ofSize: 17)
        addSubview(commonL)
        commonL.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(line2.snp.bottom).offset(40)
            make.left.equalTo(line1.snp.left)
            make.right.equalTo(line1.snp.right)
            make.height.equalTo(20)
        }
        
        commonTV.placeholder = "请输入评价内容"
        commonTV.font = .systemFont(ofSize: 14)
        commonTV.backgroundColor = .hex("#F8F8F8")
        commonTV.textContainerInset = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 10)
        addSubview(commonTV)
        commonTV.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(commonL.snp.bottom).offset(14)
            make.left.equalTo(line1.snp.left)
            make.right.equalTo(line1.snp.right)
            make.height.equalTo(100)
        }
        
        addSubview(submitBtn)
        submitBtn.snp.makeConstraints { make in
            make.top.equalTo(commonTV.snp.bottom).offset(40)
            make.left.equalTo(line1.snp.left)
            make.right.equalTo(line1.snp.right)
            make.height.equalTo(50)
        }
    }
}
