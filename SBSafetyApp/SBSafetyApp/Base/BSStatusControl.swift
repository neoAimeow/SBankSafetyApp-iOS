//
//  BSStatusControl.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/22.
//

import Foundation
import UIKit

enum BSStatusControlEnum: Int {
    case style1 = 1
    case style2 = 2
}

class BSStatusControl: UIView {
    var dataSource: [SelectPopModal] = []

    open var didSelectItemWith:((_ index: Int, _ item: SelectPopModal) -> ())?

    var key: String = "全部状态" {
        didSet {
            nameL.text = key
        }
    }
    
    let nameL = UILabel()
    let iconL = UIImageView(image: UIImage(systemName: "chevron.down"))
    
    var style: BSStatusControlEnum = .style1
    
    init(withStyle style: BSStatusControlEnum = .style1) {
        super.init(frame: .zero)
        self.style = style
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func actionTapped() {
        getFirstViewController()?.popup.bottomSheet(bgColor: .black.withAlphaComponent(0.65)) {
            let v = CornerView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 386))
            v.corners = SBRectCorner(topLeft: 12, topRight: 12, bottomLeft: 0, bottomRight: 0)
            v.backgroundColor = .white
            let rPopV = SelectPopView()
            rPopV.datas = dataSource
            rPopV.didSelectItemWith = { (index, modal) -> () in
                print("Selected item: \(modal) at index: \(index)")
                self.getFirstViewController()?.popup.dismissPopup()
                self.didSelectItemWith?(index, modal)
            }
            v.addSubview(rPopV)
            rPopV.snp.makeConstraints { (make) -> Void in
                make.top.right.left.bottom.equalToSuperview()
            }
            return v
        }
    }
    
    // MARK: - Setup
    
    func setupUI() {
        backgroundColor = .white
        
        if style == .style1 {
            let baseV = UIView()
            addSubview(baseV)
            baseV.snp.makeConstraints { make in
                make.height.centerX.centerY.equalToSuperview()
            }
            
            nameL.font = .systemFont(ofSize: 14)
            nameL.textColor = .hex("#666666")
            nameL.numberOfLines = 2
            nameL.adjustsFontSizeToFitWidth = true
            baseV.addSubview(nameL)
            nameL.snp.makeConstraints { make in
                make.centerY.left.equalToSuperview()
                make.width.lessThanOrEqualTo(self.snp.width).offset(-30)
            }

            iconL.contentMode = .scaleAspectFit
            iconL.tintColor = .hex("#D2D2D2")
            baseV.addSubview(iconL)
            iconL.snp.makeConstraints { make in
                make.centerY.right.equalToSuperview()
                make.left.equalTo(nameL.snp.right).offset(12)
                make.right.equalTo(baseV.snp.right)
                make.width.equalTo(10)
            }
        }
        
        if style == .style2 {
            nameL.font = .systemFont(ofSize: 15)
            nameL.numberOfLines = 2
            nameL.adjustsFontSizeToFitWidth = true
            addSubview(nameL)
            nameL.snp.makeConstraints { make in
                make.left.equalTo(self.snp.left).offset(12)
                make.centerY.equalTo(self.snp.centerY)
            }

            iconL.contentMode = .scaleAspectFit
            iconL.tintColor = .hex("#D2D2D2")
            addSubview(iconL)
            iconL.snp.makeConstraints { make in
                make.left.equalTo(nameL.snp.right).offset(4)
                make.right.equalTo(self.snp.right).offset(-6)
                make.centerY.equalTo(self.snp.centerY)
                make.width.height.equalTo(16)
            }
        }
        let ctl = UIControl()
        ctl.addTarget(self, action: #selector(actionTapped), for: .touchUpInside)
        addSubview(ctl)
        ctl.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}
