//
//  SignEffect.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/16.
//

import Foundation
import UIKit
import Kingfisher

class SignEffect: BaseEffect {
    
    var img: UIImage? {
        set {
            valueIV.image = newValue
            ctl.isHidden = img != nil
        }
        get {
            return valueIV.image
        }
    }
    
    var urlStr: String? {
        didSet {
            if urlStr != nil {
                let url = "https://www.zhxqgl.top/bosc-ydaf" + urlStr!
                valueIV.kf.setImage(with: URL(string: url))
                ctl.isHidden = urlStr != nil
            }
        }
    }
    
    let valueIV = UIImageView()
    let yesIV = UIImageView(image: UIImage(systemName: "checkmark"))

    override func updateTextEntry() {
        if isEdited {
            UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: .beginFromCurrentState, animations: ({
                self.ctl.placeL.layer.opacity = 0.0
                self.ctl.backgroundColor = .clear
            }), completion: { _ in })
            yesIV.isHidden = (img != nil) ? false : true
        } else {
            UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: .beginFromCurrentState, animations: ({
                self.ctl.placeL.layer.opacity = 1.0
                self.ctl.backgroundColor = .white
            }), completion: { _ in })
            yesIV.isHidden = true
        }
    }
    
    override func editTapped() {
        self.isEdited = true
        
        let vc = SignVC()
        vc.delegate = self
        getFirstViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func setupUI() {
        super.setupUI()
        
        keyL.snp.remakeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.snp.left).offset(11)
        }
        
        valueIV.contentMode = .scaleAspectFit
        addSubview(valueIV)
        valueIV.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(50)
            make.width.equalTo(100)
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-20)
        }
        
        yesIV.isHidden = true
        yesIV.tintColor = .hex("#2AAD67")
        ctl.addSubview(yesIV)
        yesIV.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(self.snp.right).offset(-6)
            make.width.height.equalTo(20)
        }
    }
}

extension SignEffect: SignVCDelegate {
    func handleConfirm(_ canvas: UIImage?) {
        img = canvas
        yesIV.isHidden = (img != nil) ? false : true
    }
    
    func handleClose() {
        img = nil
        self.isEdited = false
    }
}
