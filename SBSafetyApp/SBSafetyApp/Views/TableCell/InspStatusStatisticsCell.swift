//
//  InspStatusStatisticsCell.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/25.
//

import Foundation
import UIKit

class InspStatusStatisticsCell: UICollectionViewCell {
    let dotL = UIView()
    let valL = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reload(withModal modal: InspStatusStatisticsModal) {
//        valL.text = "\(modal.key)\n\(modal.val) (\(modal.percent))"
        let pstyle = NSMutableParagraphStyle()
        pstyle.lineSpacing = 6
        valL.attributedText = NSAttributedString(string: "\(modal.key)\n\(modal.val) (\(modal.percent))", attributes: [.paragraphStyle : pstyle])        
        dotL.backgroundColor = .hex(modal.color)
    }
    
    func setupUI() {
        dotL.layer.masksToBounds = true
        dotL.layer.cornerRadius = 2
        addSubview(dotL)
        dotL.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(1)
            make.left.equalTo(self.snp.left)
            make.width.height.equalTo(9)
        }
        
        valL.font = .systemFont(ofSize: 13)
        valL.textColor = .hex("#626E8E")
        valL.numberOfLines = 0
        addSubview(valL)
        valL.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(dotL.snp.right).offset(6)
            make.right.equalTo(self.snp.right)
        }
    }
}
