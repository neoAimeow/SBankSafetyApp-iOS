//
//  RepairCommonView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/23.
//

import Foundation
import UIKit

class RepairCommonView: UIView {
    let avaterIV = UIImageView()
    let nameL = UILabel()
    let dateL = UILabel()
    let commonL = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(withCommon common: YjwxCommonModal) {
        if common.avatar == "" || common.avatar == nil {
            avaterIV.image = UIImage(named: "ic_default_av")
        }
        nameL.text = common.plyh
        dateL.text = common.plsj
        commonL.text = common.plnr
    }
    
    func setupUI() {
        let line = UIView()
        line.backgroundColor = .hex("#F5F5F5")
        addSubview(line)
        line.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(self.snp.left).offset(12)
            make.right.equalTo(self.snp.right).offset(-12)
            make.height.equalTo(0.5)
        }
        
        avaterIV.contentMode = .scaleAspectFill
        avaterIV.layer.masksToBounds = true
        avaterIV.layer.cornerRadius = 9.5
        avaterIV.layer.borderWidth = 0.5
        avaterIV.layer.borderColor = UIColor.hex("#3C72FF").cgColor
        addSubview(avaterIV)
        avaterIV.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(13)
            make.left.equalTo(self.snp.left).offset(13)
            make.width.height.equalTo(19)
        }
        
        nameL.textColor = .hex("#777777")
        nameL.font = .systemFont(ofSize: 14)
        addSubview(nameL)
        nameL.snp.makeConstraints { make in
            make.centerY.equalTo(avaterIV.snp.centerY)
            make.left.equalTo(avaterIV.snp.right).offset(10)
        }
        
        dateL.textColor = .hex("#C8C8C8")
        dateL.font = .systemFont(ofSize: 12)
        addSubview(dateL)
        dateL.snp.makeConstraints { make in
            make.centerY.equalTo(avaterIV.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-12)
        }
        
        commonL.textColor = .hex("#444444")
        commonL.font = .systemFont(ofSize: 14)
        commonL.numberOfLines = 0
        addSubview(commonL)
        commonL.snp.makeConstraints { make in
            make.top.equalTo(avaterIV.snp.bottom).offset(8)
            make.left.equalTo(avaterIV.snp.left)
            make.right.equalTo(dateL.snp.right)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
        }
    }
}
