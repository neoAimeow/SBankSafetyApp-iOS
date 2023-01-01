//
//  OrderListCell.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/5.
//

import Foundation
import UIKit

class OrderListCell: UITableViewCell {
    let dateL = UILabel()
    let contentL = UILabel()
    let statusL = UILabel()
    
    let collectionV = SEImageCollectionView()

    var imgs: [Any] = [1, 2, 3, 4, 5, 6, 7]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reload(withModal modal: Any) {

    }
    
    func setupUI() {
        dateL.textColor = .hex("#ACACAC")
        dateL.font = .systemFont(ofSize: 14)
        dateL.text = "创建时间：2022-09-26 09:21"
        addSubview(dateL)
        dateL.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(21)
            make.left.equalTo(self.snp.left).offset(10)
        }
        
        contentL.font = .systemFont(ofSize: 17)
        contentL.textColor = .hex("#333333")
        contentL.text = "我的工单内容，测试内容，在线测试提交。"
        contentL.numberOfLines = 0
        addSubview(contentL)
        contentL.snp.makeConstraints { make in
            make.top.equalTo(dateL.snp.bottom).offset(14)
            make.left.equalTo(dateL.snp.left)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(20)
        }
        
        statusL.font = .systemFont(ofSize: 14)
        statusL.textColor = .hex("#FF0000")
        statusL.text = "处理中"
        addSubview(statusL)
        statusL.snp.makeConstraints { make in
            make.centerY.equalTo(dateL.snp.centerY)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(20)
        }
        
        collectionV.maxCount = 5
        collectionV.itemHeight = 60
        addSubview(collectionV)
        collectionV.snp.makeConstraints { (make) in
            make.top.equalTo(contentL.snp.bottom).offset(12)
            make.left.equalTo(dateL.snp.left)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        addSubview(line)
        line.snp.makeConstraints { (make) -> Void in
            make.bottom.equalToSuperview()
            make.left.equalTo(contentL.snp.left)
            make.right.equalTo(contentL.snp.right)
            make.height.equalTo(0.5)
            make.top.equalTo(collectionV.snp.bottom).offset(18)
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            backgroundColor = .hex("#ECECEC")
        } else {
            backgroundColor = .white
        }
    }
    
    lazy var line: UIView = {
        let li = UIView()
        li.backgroundColor = .hex("#F3F3F3")
        return li
    }()
}


