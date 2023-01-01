//
//  MyView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/24.
//

import Foundation
import UIKit

class MyView: UIView {
    let departItem = MyItemView(withModal: MyItemModal(icon: "ic_my_depart", name: "部门管理", status: .single, lineType: .line_none))
    let aboutItem = MyItemView(withModal: MyItemModal(icon: "ic_my_about", name: "关于", status: .top, lineType: .full))
    let settingItem = MyItemView(withModal: MyItemModal(icon: "ic_my_setting", name: "设置", status: .bottom, lineType: .line_none))

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
        updateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI() {
        let user = BSUser.currentUser
        nameL.text = user.nickName
        departL.text = user.deptName
    }
   
    func setupUI() {
        addSubview(baseIV)
        baseIV.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(243)
        }
        
        addSubview(avatarIV)
        avatarIV.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(20)
            make.top.equalTo(self.snp.top).offset(111)
            make.width.height.equalTo(55)
        }
        
        addSubview(nameL)
        nameL.snp.makeConstraints { make in
            make.left.equalTo(avatarIV.snp.right).offset(16)
            make.top.equalTo(avatarIV.snp.top)
        }
        
        addSubview(departL)
        departL.snp.makeConstraints { make in
            make.left.equalTo(nameL.snp.left)
            make.top.equalTo(nameL.snp.bottom).offset(8)
        }
        
        let arrowIV = UIImageView(image: UIImage(systemName: "chevron.right"))
        arrowIV.tintColor = .white
        arrowIV.contentMode = .scaleAspectFit
        addSubview(arrowIV)
        arrowIV.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(avatarIV.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-20)
            make.width.equalTo(8)
        }

        departItem.isHidden = true
        addSubview(departItem)
        departItem.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(avatarIV.snp.bottom).offset(23)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.height.equalTo(75)
        }
        
        addSubview(aboutItem)
        aboutItem.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(departItem.snp.bottom).offset(10)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.height.equalTo(75)
        }
        
        addSubview(settingItem)
        settingItem.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(aboutItem.snp.bottom)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.height.equalTo(75)
        }
    }
    
    lazy var baseIV: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "my_bg"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    lazy var avatarIV: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "ic_default_av"))
        iv.backgroundColor = .hex("#277AD8")
        iv.layer.borderWidth = 1.5
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.cornerRadius = 27.5
        iv.layer.masksToBounds = true
        return iv
    }()
    
    lazy var nameL: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 20)
        l.textColor = .white
        return l
    }()
    
    lazy var departL: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 15)
        l.textColor = .hex("#8AB4E8")
        return l
    }()
}
