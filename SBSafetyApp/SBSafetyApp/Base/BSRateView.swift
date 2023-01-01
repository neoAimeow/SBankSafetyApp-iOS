//
//  BSRateView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/25.
//

import Foundation
import UIKit

class BSRateView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateView()
    }
        
    // MARK: - Properties
    var btnList = [UIButton]()
    open var didSelectRateWith:((_ ratingValue: Int) -> ())?
    
    var maxCount: Int = 5 {
        didSet {
            updateView()
        }
    }
    
    var fillImage: UIImage = UIImage(named: "ic_shapeFill")! {
        didSet {
            updateView()
        }
    }
    
    var emptyImage: UIImage = UIImage(named: "ic_shapeEmpty")! {
        didSet {
            updateView()
        }
    }
    
    var title: String = "" {
        didSet {
            titleL.text = title
        }
    }
    
    var ratingValue: Int = -1 {
        didSet {
            updateViewAppearance(ratingValue)
        }
    }
    
    @objc func starTapped(_ sender: UIButton) {
        updateViewAppearance(sender.tag)
    }
    
    func updateViewAppearance(_ xPoint: Int) {
        var tag = 0
        for btn in btnList {
            if xPoint == tag {
                btn.setImage(emptyImage, for: .normal)
                setNeedsDisplay()
            } else {
                btn.setImage(fillImage, for: .normal)
                tag = tag + 1
                setNeedsDisplay()
            }
        }
        
       didSelectRateWith?(tag)
    }

    // MAKR: - View
    func updateView() {
        btnList.removeAll()
        removeAllSubViews()
        
        for index in 1...maxCount {
            let btn: UIButton = UIButton(type: .custom)
            btn.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            btn.setImage(emptyImage, for: .normal)
            btn.tag = index
            btn.addTarget(self, action: #selector(starTapped), for: .touchUpInside)
            btnList.append(btn)
        }
        
        addSubview(titleL)
        titleL.snp.makeConstraints { make in
            make.left.centerY.equalToSuperview()
            make.width.equalTo(70)
        }
        
        let stackView = UIStackView(arrangedSubviews: btnList)
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10.0
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview()
            make.left.equalTo(titleL.snp.right)
        }
    }
    
    lazy var titleL: UILabel = {
        let l = UILabel()
        l.textColor = .hex("#333333")
        l.font = .systemFont(ofSize: 15)
        return l
    }()
}
