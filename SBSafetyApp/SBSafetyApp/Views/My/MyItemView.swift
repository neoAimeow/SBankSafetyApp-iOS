//
//  MyItemView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/24.
//

import Foundation
import UIKit

public enum MyItemStatus: Int {
    case single = 0
    case top = 1
    case middle = 2
    case bottom = 3
}

public enum MyItemLineType: Int {
    case line_none = 0
    case full = 1
    case inset = 2
}

class MyItemModal: NSObject {
    var icon: String?
    var name: String = ""
    var status: MyItemStatus? = .single
    var lineType: MyItemLineType? = .line_none

    init(icon: String? = nil, name: String, status: MyItemStatus? = nil, lineType: MyItemLineType? = nil) {
        self.icon = icon
        self.name = name
        self.status = status
        self.lineType = lineType
    }
}

class MyItemView: CornerControl {
    init(withModal modal: MyItemModal) {
        super.init(frame: .zero)
        setupUI(withModal: modal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(withModal modal: MyItemModal) {
        
        backgroundColor = .white
        
        switch modal.status {
        case .single:
            self.corners = SBRectCorner(all: 10)
            break
        case .top:
            self.corners = SBRectCorner(topLeft: 10, topRight: 10)
            break
        case .middle:
            self.corners = SBRectCorner(all: 0)
            break
        case .bottom:
            self.corners = SBRectCorner(bottomLeft: 10, bottomRight: 10)
            break
        case .none:
            self.corners = SBRectCorner(all: 0)
            break
        }
                
        if modal.icon != nil {
            iconIV.image = UIImage(named: modal.icon!)
            iconIV.contentMode = .center
            addSubview(iconIV)
            iconIV.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset(11)
                make.width.height.equalTo(24)
            }
        }
        
        nameL.text = modal.name
        addSubview(nameL)
        nameL.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(modal.icon == nil ? self.snp.left : iconIV.snp.right).offset(15)
        }
        
        addSubview(arrowIV)
        arrowIV.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
            make.width.equalTo(8)
        }
        
        if modal.lineType != .none {
            let padding = modal.lineType == .full ? 0 : 10.0
            addSubview(line)
            line.snp.makeConstraints { (make) -> Void in
                make.bottom.equalToSuperview()
                make.left.equalTo(self.snp.left).offset(padding)
                make.right.equalTo(self.snp.right).offset(-padding)
                make.height.equalTo(0.5)
            }
        }
        
    }
    
    lazy var iconIV: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    lazy var nameL: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16)
        l.textColor = .hex("#333333")
        return l
    }()
    
    lazy var arrowIV: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "chevron.right"))
        iv.tintColor = .hex("#A5A5A5")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var line: UIView = {
        let li = UIView()
        li.backgroundColor = .hex("#F4F4F4")
        return li
    }()
}
