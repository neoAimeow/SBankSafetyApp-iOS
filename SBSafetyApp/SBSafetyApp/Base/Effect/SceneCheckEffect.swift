//
//  SceneCheckEffect.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/17.
//

import Foundation
import UIKit

class SceneCheckEffect: UIControl {
    
    var checkR: CheckEffect!
        
    var title: String = "" {
        didSet {
            checkR.title = title
        }
    }

    init(withEnable enable: Bool = true) {
        super.init(frame: .zero)
        isEnabled = enable
        
        self.checkR = CheckEffect(withEnable: enable)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        checkR.delegate = self
        addSubview(checkR)
        checkR.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
    
    func addImagePicker() {
        checkR.snp.remakeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
        }
        
        if imgPicker.superview == nil {
            addSubview(imgPicker)
            imgPicker.snp.makeConstraints { make in
                make.top.equalTo(checkR.snp.bottom).offset(10)
                make.left.equalTo(self.snp.left)
                make.right.equalTo(self.snp.right)
                make.bottom.equalTo(self.snp.bottom)
            }
        }
    }
    
    func removeImagePicker() {
        if imgPicker.superview != nil {
            imgPicker.removeFromSuperview()
        }
        
        checkR.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(ScreenWidth - 20)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
    
    lazy var imgPicker: BSImagePickerView = {
        let picker = BSImagePickerView()
        return picker
    }()
}

extension SceneCheckEffect: CheckEffectDelegate {
    func valueChange(_ isCheck: Bool?) {
        if isCheck != nil && isCheck == false {
            addImagePicker()
        } else {
            removeImagePicker()
            imgPicker.images = []
            imgPicker.collectionView.reloadData()
        }
    }
}
