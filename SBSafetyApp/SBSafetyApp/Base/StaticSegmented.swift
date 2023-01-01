//
//  StaticSegmented.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/23.
//

import Foundation
import UIKit

class StaticSegmented: UIView {
    
    var selectedFont: UIFont = .systemFont(ofSize: 13)
    var font: UIFont = .systemFont(ofSize: 13)
    var textColor: UIColor = .black
    var selectedTextColor: UIColor = .white
    var useGradient: Bool = true
    
    var bgColor: UIColor = .clear
    var selectedBgColor: UIColor = .primary
    
    var itemTitles: [String] = [] {
        didSet {
            configureItems()
        }
    }
    var allItemBtns: [UIButton] = []

    var didSelectItemWith:((_ index: Int, _ title: String?) -> ())?

    var currentSelectedIndex = 0 {
        didSet {
            updateSelected()
        }
    }
        
    var sectionWidth: CGFloat = 21.0 {
        didSet {
            configureItems()
        }
    }
    
    var padding: CGFloat = 2 {
        didSet {
            configureItems()
        }
    }
    
    var cornerRadius: CGFloat = 10.5 {
        didSet {
            configureItems()
        }
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .bg
        layer.cornerRadius = 12
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UIConfiguration

extension StaticSegmented {
    fileprivate func configureItems() {
        layer.cornerRadius = cornerRadius + padding

        self.removeAllSubViews()
                
        var lastBtn: UIButton? = nil
        for (i, title) in itemTitles.enumerated() {
            let btn = createButtonlWithTitle(title, tag: i)
            addSubview(btn)
            btn.snp.makeConstraints { make in
                make.left.equalTo(lastBtn == nil ? self.snp.left: lastBtn!.snp.right).offset(padding)
                make.top.equalTo(self.snp.top).offset(padding)
                make.bottom.equalTo(self.snp.bottom).offset(-padding)
                make.width.equalTo(sectionWidth)
                if i == itemTitles.count - 1 {
                    make.right.equalTo(self.snp.right).offset(-padding)
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
                btn.setBGColor(selectedBgColor, for: .normal)
                btn.setBGColor(selectedBgColor.withAlphaComponent(0.8), for: .highlighted)
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
