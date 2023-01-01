//
//  FeedbackListCell.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/5.
//

import Foundation
import UIKit

class FeedbackListCell: UITableViewCell {
    let dateL = UILabel()
    let contentL = UILabel()
    
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
        contentL.text = "布防状态主机信息列表显示“无主机”，营布防状态主机信息列表显示“无主机”，营业"
        addSubview(contentL)
        contentL.snp.makeConstraints { make in
            make.top.equalTo(dateL.snp.bottom).offset(14)
            make.left.equalTo(dateL.snp.left)
            make.right.equalToSuperview().offset(-58)
//            make.height.equalTo(20)
        }
        
        arrowIV.image = UIImage(systemName: "chevron.right")
        arrowIV.tintColor = .hex("#A5A5A5")
        arrowIV.contentMode = .scaleAspectFit
        addSubview(arrowIV)
        arrowIV.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(contentL.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-10)
            make.width.equalTo(8)
        }
        
        addSubview(line)
        line.snp.makeConstraints { (make) -> Void in
            make.bottom.equalToSuperview()
            make.left.equalTo(contentL.snp.left)
            make.right.equalTo(contentL.snp.right)
            make.height.equalTo(0.5)
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
    
    lazy var arrowIV: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "chevron.right"))
        iv.tintColor = .hex("#A5A5A5")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var line: UIView = {
        let li = UIView()
        li.backgroundColor = .hex("#F3F3F3")
        return li
    }()
}


