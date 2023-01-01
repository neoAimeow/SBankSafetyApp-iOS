//
//  BSSegmentedControl.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/18.
//

import Foundation
import UIKit

open class BSSegmentedControl: UIView {
    
    open var selectedFont: UIFont = .systemFont(ofSize: 17)
    open var font: UIFont = .systemFont(ofSize: 15)
    open var textColor: UIColor = .black
    open var selectedTextColor: UIColor = .white
    open var useGradient: Bool = true
    
    open var bgColor: UIColor = .bg
    open var selectedBgColors: [UIColor] = [.hex("#3573CE"), .primary]
    open var cornerRadius: CGFloat = 18
    open var padding: CGFloat = 44

    open var itemTitles: [String] = [] {
        didSet {
            configureItems()
        }
    }
    open var allItemBtns: [UIButton] = []

    open var didSelectItemWith:((_ index: Int, _ title: String?) -> ())?

    var currentSelectedIndex = 0 {
        didSet {
            updateSelected()
        }
    }
        
    //MARK: - Getters
    
    fileprivate var sectionWidth: CGFloat {
        return ((ScreenWidth - padding) - 16 * CGFloat(itemTitles.count - 1)) / CGFloat(itemTitles.count)
    }
}

//MARK: - UIConfiguration

extension BSSegmentedControl {
    fileprivate func configureItems() {
        self.removeAllSubViews()
                
        var lastBtn: UIButton? = nil
        for (i, title) in itemTitles.enumerated() {
            let btn = createButtonlWithTitle(title, tag: i)
            addSubview(btn)
            if lastBtn == nil {
                btn.snp.makeConstraints { make in
                    make.left.equalTo(self.snp.left)
                    make.top.equalTo(self.snp.top)
                    make.bottom.equalTo(self.snp.bottom)
                    make.width.equalTo(sectionWidth)
                }
            } else {
                btn.snp.makeConstraints { make in
                    make.left.equalTo(lastBtn!.snp.right).offset(16)
                    make.top.equalTo(self.snp.top)
                    make.bottom.equalTo(self.snp.bottom)
                    make.width.equalTo(sectionWidth)
                }
            }
            allItemBtns.append(btn)
            lastBtn = btn
        }
        updateSelected()
    }
    
    fileprivate func updateSelected() {
        for (i, btn) in allItemBtns.enumerated() {
            if currentSelectedIndex == i {
                btn.titleLabel?.font = selectedFont
                btn.setTitleColor(selectedTextColor, for: .normal)
                btn.setTitleColor(selectedTextColor.withAlphaComponent(0.8), for: .highlighted)
                btn.setGLBGColors(selectedBgColors, direction: .toRight, for: .normal)
                btn.setGLBGColors([.hex("#3573CE").withAlphaComponent(0.8), .primaryH], direction: .toRight, for: .highlighted)
            } else {
                btn.titleLabel?.font = font
                btn.setTitleColor(textColor, for: .normal)
                btn.setTitleColor(textColor.withAlphaComponent(0.8), for: .highlighted)
                btn.setBGColor(bgColor, for: .normal)
                btn.setBGColor(bgColor.withAlphaComponent(0.8), for: .highlighted)
            }
        }
    }
    
    fileprivate func createButtonlWithTitle(_ title: String, tag: Int) -> UIButton {
        let btn = UIButton(type: .custom)
        btn.layer.cornerRadius = cornerRadius
        btn.layer.masksToBounds = true
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = font
        btn.tag = tag
        btn.addTarget(self, action: #selector(selectItemAt), for: .touchUpInside)
        return btn
    }
    
    @objc func selectItemAt(_ sender: UIButton) {
        currentSelectedIndex = sender.tag
        didSelectItemWith?(currentSelectedIndex, itemTitles[sender.tag])
    }
}
