//
//  CreateOrderView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/5.
//

import Foundation
import UIKit

class CreateOrderView: UIView {

    let submitBtn = UIButton.createPrimaryLarge("提交")

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
       
    }
    
    func setupUI() {
        addSubview(submitBtn)
        submitBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(50)

            make.bottom.equalToSuperview().offset(-15)
        }
        
        let scollV = UIScrollView()
        scollV.keyboardDismissMode = .interactive
        scollV.showsVerticalScrollIndicator = false
        addSubview(scollV)
        scollV.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth - 20)
            make.bottom.equalTo(submitBtn.snp.top).offset(-10)
        }
        
        let orderBV = UIView.createBase()
        scollV.addSubview(orderBV)
        orderBV.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth - 20)
        }
        
        let orderTV = TitleItemView(withTitle: "工单内容")
        orderBV.addSubview(orderTV)
        orderTV.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(46)
        }
        
        let writeTV = BSTextView()
        writeTV.placeholder = "请填写工单内容"
        writeTV.font = .systemFont(ofSize: 14)
        writeTV.backgroundColor = .hex("#FAFAFA")
        writeTV.layer.cornerRadius = 10
        writeTV.layer.masksToBounds = true
        writeTV.textContainerInset = UIEdgeInsets(top: 17, left: 18, bottom: 17, right: 18)
        orderBV.addSubview(writeTV)
        writeTV.snp.makeConstraints { make in
            make.top.equalTo(orderTV.snp.bottom)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(160)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        let imgBV = UIView.createBase()
        scollV.addSubview(imgBV)
        imgBV.snp.makeConstraints { make in
            make.top.equalTo(orderBV.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenWidth - 20)
            make.bottom.equalToSuperview().offset(-40)
        }
        
        
        let imgTV = TitleItemView(withTitle: "选填项")
        imgBV.addSubview(imgTV)
        imgTV.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(46)
        }
        
        imgBV.addSubview(imgPickerView)
        imgPickerView.snp.makeConstraints { make in
            make.top.equalTo(imgBV.snp.top).offset(20)
            make.left.equalTo(imgBV.snp.left)
            make.right.equalTo(imgBV.snp.right)
            make.width.equalTo(ScreenWidth - 20)
            make.bottom.equalToSuperview()
        }
    }
    
    lazy var imgPickerView: BSImagePickerView = {
        let picker = BSImagePickerView()
        picker.key = ""
        picker.maxCount = 9
        picker.rowCount = 3
        return picker
    }()
}
