//
//  UIButtonEx.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/14.
//

import Foundation
import UIKit

extension UIButton {
    func setBGColor(_ color: UIColor, for state: UIControl.State) {
        setBackgroundImage(UIImage(color: color, size: CGSize(width: 1, height: 1)), for: state)
    }
    
    func setGLBGColors(_ colors: [UIColor], direction: BSGLDirection, for state: UIControl.State) {
        if colors.count > 1 {
            // Gradient background
            setBackgroundImage(UIImage(size: CGSize(width: 1, height: 1), direction: direction, colors: colors), for: state)
        } else {
            if let color = colors.first {
                // Mono color background
                setBackgroundImage(UIImage(color: color, size: CGSize(width: 1, height: 1)), for: state)
            } else {
                // Default background color
                setBackgroundImage(nil, for: state)
            }
        }
    }
    
    class func createCornerPrimary(_ title: String) -> UIButton {
        let btn = UIButton(type: .custom)
        btn.layer.cornerRadius = 20
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitleColor(.white.withAlphaComponent(0.8), for: .highlighted)
        btn.setTitleColor(.white.withAlphaComponent(0.6), for: .disabled)
        btn.setBGColor(.primary, for: .normal)
        btn.setBGColor(.primaryH, for: .highlighted)
        btn.setBGColor(.primaryDis, for: .disabled)
        return btn
    }
    
    class func createDefaultLarge(_ title: String) -> UIButton {
        let btn = UIButton(type: .custom)
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.setTitleColor(.black.withAlphaComponent(0.8), for: .highlighted)
        btn.setTitleColor(.black.withAlphaComponent(0.6), for: .disabled)
        btn.setBGColor(.bg, for: .normal)
        btn.setBGColor(.bg.withAlphaComponent(0.8), for: .highlighted)
        btn.setBGColor(.bg.withAlphaComponent(0.6), for: .disabled)
        return btn
    }
    
    class func createPrimaryLarge(_ title: String) -> UIButton {
        let btn = UIButton(type: .custom)
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitleColor(.white.withAlphaComponent(0.8), for: .highlighted)
        btn.setTitleColor(.white.withAlphaComponent(0.6), for: .disabled)
        btn.setBGColor(.primary, for: .normal)
        btn.setBGColor(.primaryH, for: .highlighted)
        btn.setBGColor(.primaryDis, for: .disabled)
        return btn
    }
    
    class func createPrimaryBorderLarge(_ title: String) -> UIButton {
        let btn = UIButton(type: .custom)
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.primary, for: .normal)
        btn.setTitleColor(.primaryH, for: .highlighted)
        btn.setTitleColor(.primaryDis, for: .disabled)
        btn.layer.borderColor = UIColor.primary.cgColor
        btn.layer.borderWidth = 1
        return btn
    }
    
    class func createGLPrimary(_ title: String) -> UIButton {
        let btn = UIButton(type: .custom)
        btn.layer.cornerRadius = 18
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitleColor(.white.withAlphaComponent(0.8), for: .highlighted)
        btn.setTitleColor(.white.withAlphaComponent(0.6), for: .disabled)
        btn.setGLBGColors([UIColor.hex("#3573CE"), UIColor.primary], direction: .toRight, for: .normal)
        btn.setGLBGColors([UIColor.hex("#3573CE").withAlphaComponent(0.8), UIColor.primaryH], direction: .toRight, for: .highlighted)
        btn.setGLBGColors([UIColor.hex("#3573CE").withAlphaComponent(0.6), UIColor.primaryDis], direction: .toRight, for: .selected)
        return btn
    }
    
    class func createDefault(_ title: String) -> UIButton {
        let btn = UIButton(type: .custom)
        btn.layer.cornerRadius = 18
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.setTitleColor(.black.withAlphaComponent(0.8), for: .highlighted)
        btn.setTitleColor(.black.withAlphaComponent(0.6), for: .disabled)
        btn.setBGColor(.bg, for: .normal)
        btn.setBGColor(.bg.withAlphaComponent(0.8), for: .highlighted)
        btn.setBGColor(.bg.withAlphaComponent(0.6), for: .disabled)
        return btn
    }
    
    class func createCustom(_ title: String) -> UIButton {
        let btn = UIButton(type: .custom)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.primary, for: .normal)
        btn.setTitleColor(.primaryH, for: .highlighted)
        btn.setTitleColor(.primaryDis, for: .disabled)
        return btn
    }
    
    class func createCornerButton(_ title: String)-> UIButton {
        let btn = UIButton(type: .custom)
        btn.layer.cornerRadius = 25
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitleColor(.white.withAlphaComponent(0.8), for: .highlighted)
        btn.setTitleColor(.white.withAlphaComponent(0.6), for: .disabled)
        btn.setBGColor(.primary, for: .normal)
        btn.setBGColor(.primaryH, for: .highlighted)
        btn.setBGColor(.primaryDis, for: .disabled)
        return btn
    }
}

class RepairModalButton: UIButton {
    var modal: YjwxListModal? = nil
    var record: YjwxRecordModal? = nil
    var parItem: ParListModal? = nil

}
