//
//  LabelPickerEffect.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/29.
//

import Foundation
import UIKit

enum LabelPickerStyleEnum: Int {
    case normal = 1
    case loction = 2
}

class LabelPickerEffect: UIControl {
    var value: String? {
        set {
            valueL.text = newValue
            updatValue(newValue)
        }
        get {
            return valueL.text
        }
    }
    
    var isRequired: Bool = false {
        didSet {
            updatePlaceholder()
        }
    }
    
    var placeholder: String = "..." {
        didSet {
            updatePlaceholder()
        }
    }
    
    var style: LabelPickerStyleEnum = .normal

    var dataSource: [YjwxRestoreDictModal] = []
    open var didSelectItemWith:((_ title: String) -> ())?

    let keyL = UILabel()
    let valueL = UILabel()
    let arrowIV = UIImageView(image: UIImage(systemName: "chevron.down"))
    
    init(withPlaceholder _place: String, _style: LabelPickerStyleEnum = .normal) {
        super.init(frame: .zero)
        self.style = _style
        self.placeholder = _place
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updatePlaceholder() {
        keyL.text = placeholder
    }
    
    func updatValue(_ v: String? = nil) {
        if v == nil || v == "" {
            valueL.textColor = .hex("#C4C4C4")
            valueL.text = placeholder
        } else {
            valueL.textColor = .black
            valueL.text = v
        }
    }
    
    @objc func actionTapped() {
        if style == .normal {
            getFirstViewController()?.popup.bottomSheet(bgColor: .black.withAlphaComponent(0.65)) {
                let v = CornerView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 386))
                v.corners = SBRectCorner(topLeft: 12, topRight: 12, bottomLeft: 0, bottomRight: 0)
                v.backgroundColor = .white
                let rPopV = LabelPickerPopView()
                rPopV.datas = dataSource
                rPopV.didSelectItemWith = { (index, title) -> () in
                    print("Selected item: \(title) at index: \(index)")
                    self.value = title
                    self.getFirstViewController()?.popup.dismissPopup()
                    self.didSelectItemWith?(title)
                }
                v.addSubview(rPopV)
                rPopV.snp.makeConstraints { (make) -> Void in
                    make.top.right.left.bottom.equalToSuperview()
                }
                return v
            }
        } else if style == .loction {
            let vc = LocationVC()
            vc.didSelectLocWith = { (loc) -> () in
                self.value = loc
                self.didSelectItemWith?(loc!)
            }
            getFirstViewController()?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func setupUI() {
        backgroundColor = .white
        layer.borderColor = UIColor.hex("#E1E1E1").cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 10
        
        keyL.text = placeholder
        keyL.textColor = .hex("#666666")
        keyL.font = UIFont.systemFont(ofSize: 14)
        addSubview(keyL)
        keyL.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.snp.left).offset(11)
        }
        
        arrowIV.tintColor = .hex("#C4C4C4")
        arrowIV.contentMode = .scaleAspectFit
        addSubview(arrowIV)
        arrowIV.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-15)
            make.width.equalTo(14)
        }
        
        valueL.font = UIFont.systemFont(ofSize: 15)
        addSubview(valueL)
        valueL.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(arrowIV.snp.left).offset(-10)
        }
        
        let ctl = UIControl()
        ctl.addTarget(self, action: #selector(actionTapped), for: .touchUpInside)
        addSubview(ctl)
        ctl.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        updatValue()
    }
}
