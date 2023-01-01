//
//  UpdateHistoryCell.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/28.
//

import Foundation
import UIKit

enum UpdateHistoryStateEnum: Int {
    case open = 0
    case close = 1
}

class UpdateHistoryModal: NSObject {
    var id: Int64?
    var avatarUrls: String?
    var nickName: String?
    var dateStr: String?
    var state: UpdateHistoryStateEnum?

    init(id: Int64?, avatarUrls: String?, nickName: String?, dateStr: String?, state: UpdateHistoryStateEnum?) {
        self.id = id
        self.avatarUrls = avatarUrls
        self.nickName = nickName
        self.dateStr = dateStr
        self.state = state
    }

}

class UpdateHistoryCell: UIView {
    lazy var cornerBackgroundView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        return view
    } ()
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "ic_default")
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        return imageView;
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.hex("#010101")
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.hex("#B1B1B1")
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    } ()
    
    lazy var stateTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)

        return label
    }()

    lazy var indicatorImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage.init(systemName: "chevron.right"))
        imageView.tintColor = .hex("#A3A3A3")
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor.white
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildData(data: UpdateHistoryModal) {
        if let nickName = data.nickName {
            nameLabel.text = nickName
        }
        
        if let dateStr = data.dateStr {
            dateLabel.text = dateStr
        }
        
        if let state = data.state {
            switch state {
                case .open:
                stateTextLabel.text = "(营业)"
                stateTextLabel.textColor = UIColor.hex("#306EC8")
                break
                case .close:
                stateTextLabel.text = "(不营业)"
                stateTextLabel.textColor = UIColor.hex("#F17854")
                break
            }
        }
       
    }
    
    func setupUI() {
        
        self.addSubview(avatarImageView)
        self.addSubview(nameLabel);
        self.addSubview(dateLabel)
        self.addSubview(stateTextLabel)
        self.addSubview(indicatorImageView)
        
        
        avatarImageView.snp.makeConstraints { make in
            make.width.equalTo(34)
            make.height.equalTo(34)
            make.top.equalTo(self).offset(14)
            make.left.equalTo(self).offset(14)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView)
            make.left.equalTo(avatarImageView.snp.right).offset(10)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp_bottomMargin).offset(9)
            make.left.equalTo(nameLabel);
        }
        
        stateTextLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.left.equalTo(nameLabel.snp.right).offset(30)
        }
        
        indicatorImageView.snp.makeConstraints { make in
            make.height.equalTo(10.5)
            make.width.equalTo(6)
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-20)
        }
        
    
    }
}

