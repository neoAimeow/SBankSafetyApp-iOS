//
//  InspListResultView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/23.
//

import Foundation
import UIKit

class InspListResultView: UIScrollView {
    let titleBV = UIView.createBase()
    let nameL = UILabel()
    let desL = UILabel()

    let line = UIView()
    // 巡检结果
    let basicBV = UIView.createBase()
    let xjztItem = LabelPickerEffect(withPlaceholder: "巡检状态")   // 巡检状态
    
    let ycBV = UIView()
    let ycqksmItem = TextViewEditEffect(withPlaceholder: "异常情况说明")  // 异常情况说明
    let collectionV = SEImageCollectionView()
    let itemHeight =  (ScreenWidth - 80) / 4

    override init(frame: CGRect) {
        super.init(frame: frame)
        keyboardDismissMode = .interactive
        showsVerticalScrollIndicator = false
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(withModal modal: PatrolRecordModal?) {
        nameL.text = modal?.tmplName
        desL.text = modal?.remark
                
        var imgs: [String] = []
        
        let images = modal?.images ?? []
        
        for img in images {
            if img["imgUrl"] != nil {
                imgs.append(img["imgUrl"]!)
            }
        }
        
        collectionV.imgs = imgs

        if modal?.status == 0 {
            xjztItem.value = "正常"
            ycBV.layer.opacity = 0.0
            ycBV.snp.makeConstraints { make in
                make.left.equalTo(line.snp.left)
                make.right.equalTo(line.snp.right)
                make.top.equalTo(xjztItem.snp.bottom).offset(10)
                make.bottom.equalToSuperview()
                make.height.equalTo(0)
            }
        } else {
            xjztItem.value = "异常"
            ycBV.layer.opacity = 1.0
            ycBV.snp.makeConstraints { make in
                make.left.equalTo(line.snp.left)
                make.right.equalTo(line.snp.right)
                make.top.equalTo(xjztItem.snp.bottom).offset(10)
                make.bottom.equalToSuperview().offset(-14)
            }
        }
    }
    
    // MARK: - Setup
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
        
        desL.textColor = .hex("#306EC8")
        desL.font = .systemFont(ofSize: 16)
        titleBV.addSubview(desL)
        desL.snp.makeConstraints { make in
            make.top.equalTo(nameL.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    func setupBasicView() {
        addSubview(basicBV)
        basicBV.snp.makeConstraints { make in
            make.top.equalTo(titleBV.snp.bottom).offset(10)
            make.centerX.bottom.equalToSuperview()
            make.width.equalTo(ScreenWidth - 20)
        }
        
        let basicTV = TitleItemView(withTitle: "巡检结果", hasIcon: false)
        basicBV.addSubview(basicTV)
        basicTV.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(46)
        }
        
        line.backgroundColor = .hex("#ECECEC")
        basicBV.addSubview(line)
        line.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(basicTV.snp.bottom)
            make.left.equalToSuperview().offset(13)
            make.right.equalToSuperview().offset(-13)
            make.height.equalTo(0.5)
        }
        
        xjztItem.isUserInteractionEnabled = false
        xjztItem.value = "异常"
        basicBV.addSubview(xjztItem)
        xjztItem.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(13)
            make.right.equalToSuperview().offset(-13)
            make.top.equalTo(line.snp.bottom).offset(15)
            make.height.equalTo(45)
        }
        
        basicBV.addSubview(ycBV)
        ycBV.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(xjztItem.snp.bottom).offset(10)
        }
        
        ycqksmItem.backgroundColor = .bg
        ycqksmItem.isUserInteractionEnabled = false
        ycBV.addSubview(ycqksmItem)
        ycqksmItem.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(13)
            make.right.equalToSuperview().offset(-13)
            make.height.equalTo(120)
        }
                
        let ycTV = TitleItemView(withTitle: "设备图片", hasIcon: false)
        ycBV.addSubview(ycTV)
        ycTV.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(ycqksmItem.snp.bottom)
            make.height.equalTo(46)
        }
        
        collectionV.itemHeight = itemHeight
        collectionV.maxCount = 4
        ycBV.addSubview(collectionV)
        collectionV.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(13)
            make.right.equalToSuperview().offset(-13)
            make.top.equalTo(ycTV.snp.bottom)
        }
    }
    
    func setupUI() {
        setupTitleView()
        
        // 巡检结果
        setupBasicView()
    }
}
