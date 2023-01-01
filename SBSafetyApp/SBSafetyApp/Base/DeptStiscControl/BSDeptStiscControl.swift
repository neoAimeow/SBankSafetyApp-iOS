//
//  BSDeptStiscControl.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/14.
//

import Foundation
import UIKit
import JFPopup

protocol BSDeptStiscControlDelegate: AnyObject {
    func handleSelected(_ dept: TaskDeptRateModal?)
}

class BSDeptStiscControl: UIControl {
    let titleL = UILabel()
    let imgV = UIImageView()
    
    var deptName: String = "" {
        didSet {
            titleL.text = deptName
        }
    }
    weak var delegate: BSDeptStiscControlDelegate?
    
    var depts: [TaskDeptRateModal?] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func subBranchTapped() {
        getFirstViewController()?.popup.bottomSheet(bgColor: .black.withAlphaComponent(0.65)) {
            let v = CornerView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 386))
            v.corners = SBRectCorner(topLeft: 12, topRight: 12, bottomLeft: 0, bottomRight: 0)
            v.backgroundColor = .white
            let rPopV = BSDeptStiscPopView(withDepts: depts)
            rPopV.delegate = self
            v.addSubview(rPopV)
            rPopV.snp.makeConstraints { (make) -> Void in
                make.top.right.left.bottom.equalToSuperview()
            }
            return v
        }
    }
    
    func setupUI() {
        backgroundColor = .white
        layer.masksToBounds = true
        layer.cornerRadius = 4
        layer.borderColor = UIColor.hex("#E4E4E4").cgColor
        layer.borderWidth = 0.5

        titleL.text = deptName
        titleL.textColor = .black
        titleL.font = .systemFont(ofSize: 15)
        addSubview(titleL)
        titleL.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(12)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        imgV.image = UIImage(systemName: "chevron.down")
        imgV.tintColor = .hex("#BEBEBE")
        imgV.contentMode = .scaleAspectFit
        addSubview(imgV)
        imgV.snp.makeConstraints { make in
            make.left.equalTo(titleL.snp.right).offset(4)
            make.right.equalTo(self.snp.right).offset(-6)
            make.centerY.equalTo(self.snp.centerY)
            make.width.height.equalTo(16)
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

extension BSDeptStiscControl: BSDeptStiscPopViewDelegate {
    func handleSelected(_ dept: TaskDeptRateModal?) {
        self.deptName = dept?.wdmc ?? ""
        delegate?.handleSelected(dept)
        getFirstViewController()?.popup.dismissPopup()
    }
}
