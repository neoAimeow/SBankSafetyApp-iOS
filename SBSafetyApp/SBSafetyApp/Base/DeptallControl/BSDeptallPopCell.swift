//
//  BSDeptallPopCell.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/16.
//

import Foundation
import UIKit

class BSDeptallPopCell: UITableViewCell {
    let arrowIV = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reload(withModal node: Node, curId: Int64?) {
        textLabel?.text = node.name
        if node.id == curId {
            imageView?.image = UIImage(systemName: "checkmark.circle.fill")
            imageView?.tintColor = .primary
        } else {
            imageView?.image = UIImage(systemName: "circle")
            imageView?.tintColor = .hex("#EDEDED")
        }
        if !node.isLeaf {
            if node.isExpand {
                arrowIV.image = UIImage(systemName: "chevron.down")
            } else {
                arrowIV.image = UIImage(systemName: "chevron.right")
            }
        } else {
            arrowIV.image = nil
        }
        
        let inset = 25 * node.depth
        layoutMargins = UIEdgeInsets(top: 0, left: CGFloat(inset), bottom: 0, right: CGFloat(-inset))
    }
    
    func setupUI() {
        arrowIV.image = UIImage(systemName: "chevron.down")
        arrowIV.tintColor = .hex("#EDEDED")
        addSubview(arrowIV)
        arrowIV.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-20)
        }
        
        let line = UIView()
        line.backgroundColor = .hex("#F3F3F3")
        addSubview(line)
        line.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.height.equalTo(0.5)
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
    }
}
