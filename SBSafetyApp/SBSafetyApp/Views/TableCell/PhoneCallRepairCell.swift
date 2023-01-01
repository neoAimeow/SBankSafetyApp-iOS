//
//  PhoneCallRepairCell.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/25.
//

import Foundation
import UIKit

class PhoneCallRepairCell: UITableViewCell {
    let line = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .bg
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            self.backgroundColor = .hex("#ECECEC")
        } else {
            self.backgroundColor = .white
        }
    }
    
    
    func reload(withModal modal: YjwxDhbxModal?, isLast: Bool) {
        nameL.text = modal?.gcsfzr
        phoneL.text = modal?.gcsfzrlxdh
        
        line.isHidden = isLast
    }
    
    func setupUI() {
        addSubview(nameL)
        nameL.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(20)
        }
        
        addSubview(phoneL)
        phoneL.snp.makeConstraints { make in
            make.left.equalTo(nameL.snp.left)
            make.top.equalTo(nameL.snp.bottom)
        }
        
        addSubview(callIV)
        callIV.snp.makeConstraints { make in
            make.right.equalTo(self.snp.right).offset(-16)
            make.centerY.equalTo(self.snp.centerY)
            make.width.height.equalTo(25)
        }
        
        line.backgroundColor = .hex("#F3F3F3")
        addSubview(line)
        line.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(self.snp.left).offset(13)
            make.right.equalTo(self.snp.right).offset(-15)
            make.height.equalTo(0.5)
        }
    }
    
    lazy var nameL: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 17)
        return l
    }()
    
    lazy var phoneL: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14)
        l.textColor = .hex("#777777")
        return l
    }()
    
    lazy var callIV: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "ic_phonecall"))
        return iv
    }()
}
