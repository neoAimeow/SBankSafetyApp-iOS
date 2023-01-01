//
//  LabelEffect.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/27.
//

import Foundation
import UIKit

class LabelEffect: BaseEffect {
    var value: String? {
        set {
            valueL.text = newValue
            self.isEdited = (newValue == nil || newValue == "") ? false : true
        }
        get {
            return valueL.text
        }
    }
    
    let valueL = UILabel()
    let arrowIV = UIImageView(image: UIImage(systemName: "chevron.right"))
    
//    open var didSelectItemWith:((_ title: String?) -> ())?

    override func updateTextEntry() {
        if isEdited {
            UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: .beginFromCurrentState, animations: ({
                self.ctl.placeL.layer.opacity = 0.0
                self.ctl.backgroundColor = .clear
            }), completion: { _ in })
        } else {
            UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: .beginFromCurrentState, animations: ({
                self.ctl.placeL.layer.opacity = 1.0
                self.ctl.backgroundColor = .white
            }), completion: { _ in})
        }
    }


    override func setupUI() {
        super.setupUI()
        
        valueL.textColor = .black
        valueL.font = UIFont.systemFont(ofSize: 16)
        valueL.numberOfLines = 0

        insertSubview(valueL, aboveSubview: keyL)
        valueL.snp.makeConstraints { (make) -> Void in
            make.height.greaterThanOrEqualTo(20)
            make.top.equalTo(keyL.snp.bottom)
            make.left.equalTo(self.snp.left).offset(12)
            make.right.equalTo(self.snp.right).offset(-12)
            make.bottom.equalTo(self.snp.bottom).offset(-2)
        }
        
        arrowIV.tintColor = .hex("#CCCCCC")
        arrowIV.contentMode = .scaleAspectFit
        addSubview(arrowIV)
        arrowIV.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-15)
            make.width.equalTo(8)
        }
    }
}

//extension LabelEffect: LabelEffectVCDelegate {
//    func handleConfirm(_ modal: String?) {
//        valueL.text = modal
//        handleClose()
//        didSelectItemWith?(modal)
//    }
//    
//    func handleClose() {
//        isEdited = (valueL.text == nil || valueL.text == "") ? false : true
//    }
//}
