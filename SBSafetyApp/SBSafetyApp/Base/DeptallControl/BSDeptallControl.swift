//
//  BSDeptallControl.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/7.
//

import Foundation
import UIKit
import JFPopup

protocol BSDeptallControlDelegate: AnyObject {
    func handleSelected(_ dept: DeptModal?)
}

class BSDeptallControl: UIControl {
    let titleL = UILabel()
    let imgV = UIImageView()
    
    var deptName: String? = "" {
        didSet {
            titleL.text = deptName
        }
    }
    weak var delegate: BSDeptallControlDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func subBranchTapped() {
        getFirstViewController()?.popup.bottomSheet(bgColor: .black.withAlphaComponent(0.65)) {
            let v = CornerView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight * 0.9))
            v.corners = SBRectCorner(topLeft: 12, topRight: 12, bottomLeft: 0, bottomRight: 0)
            v.backgroundColor = .white
            
            let rPopV = BSDeptallPopView(withDeptName: "")
            rPopV.delegate = self
            v.addSubview(rPopV)
            rPopV.snp.makeConstraints { (make) -> Void in
                make.top.right.left.bottom.equalToSuperview()
            }
            return v
        }
    }
    
//    func reloadData() {
//        if deptName == "" {
//            self.isHidden = false
//            let role = UserDefaults.standard.string(forKey: SafetyUserRole)
//            if (role == UserRole.HeadOffice.rawValue) {
//                title = "分行态势"
//            } else if (role == UserRole.BranchOffice.rawValue) {
//                title = "支行态势"
//            } else if (role == UserRole.SubBranchOffice.rawValue) {
//                title = "网点态势"
//            } else {
//                self.isHidden = true
//            }
//            titleL.text = title
//        }
//    }
    
    func setupUI() {
        backgroundColor = .white
        layer.masksToBounds = true
        layer.cornerRadius = 4
        layer.borderColor = UIColor.hex("#E3E3E3").cgColor
        layer.borderWidth = 0.5
                
        imgV.image = UIImage(named: "ic_search_small")
        imgV.contentMode = .scaleAspectFit
        addSubview(imgV)
        imgV.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(7)
            make.centerY.equalTo(self.snp.centerY)
            make.width.height.equalTo(12)
        }
        
        let vLine1 = UIView()
        vLine1.backgroundColor = .hex("#F4F4F4")
        addSubview(vLine1)
        vLine1.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(imgV.snp.right).offset(7)
            make.width.equalTo(0.5)
        }
        
        titleL.text = deptName
        titleL.textColor = .hex("#306EC8")
        titleL.font = .systemFont(ofSize: 15)
        addSubview(titleL)
        titleL.snp.makeConstraints { make in
            make.left.equalTo(vLine1.snp.right).offset(7)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        addTarget(self, action: #selector(subBranchTapped), for: .touchUpInside)

    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                backgroundColor = .white.withAlphaComponent(0.6)
            } else {
                backgroundColor = .white
            }
        }
    }
}

extension BSDeptallControl: BSDeptallPopViewDelegate {
    func handleSelected(_ dept: DeptModal?) {
        self.deptName = dept?.deptName ?? ""
        delegate?.handleSelected(dept)
        getFirstViewController()?.popup.dismissPopup()
    }
}
