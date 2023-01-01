//
//  EditHistoryCell.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/18.
//

import Foundation
import UIKit

enum EditHistoryStateEnum: Int {
    case open = 0
    case close = 1
}

class EditHistoryModal: NSObject {
    var id: Int = 0
    var avatarUrls: String = ""
    var nickName: String = ""
    var dateStr: String = ""
    var state: EditHistoryStateEnum
    var detailStr: String = ""
    
    init(id: Int, avatarUrls: String, nickName: String, dateStr: String, state: EditHistoryStateEnum, detailStr: String) {
        self.id = id
        self.avatarUrls = avatarUrls
        self.nickName = nickName
        self.dateStr = dateStr
        self.state = state
        self.detailStr = detailStr
    }

}

class EditHistoryCell: UITableViewCell {
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
    
    lazy var detailBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.hex("#E9E9E9").cgColor
        view.layer.borderWidth = 0.5
        return view
    }()
    
    lazy var detailLabel: UITextView = {
       let textView = UITextView()
        textView.textColor = UIColor.hex("#666666")
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isEditable = false
        return textView
    }()
    
    override init( style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildData(data: YyxgjlModel) {
        if let nameValue = data.xgrmc {
            nameLabel.text = nameValue
        }
        
        if let dateValue = data.xgrq {
            dateLabel.text = dateValue
        }
        
        if let content = data.remark {
            detailLabel.text = content
        }
        
        if let state = data.yyzt {
            
            if state == "1" {
                stateTextLabel.text = "营业"
                stateTextLabel.textColor = UIColor.hex("#306EC8")
            } else {
                stateTextLabel.text = "不营业"
                stateTextLabel.textColor = UIColor.hex("#F17854")
            }
     
        }
        
  
    }
    
    func setupUI() {
        self.contentView.addSubview(cornerBackgroundView)
        
        cornerBackgroundView.addSubview(avatarImageView)
        cornerBackgroundView.addSubview(nameLabel);
        cornerBackgroundView.addSubview(dateLabel)
        cornerBackgroundView.addSubview(stateTextLabel)
        cornerBackgroundView.addSubview(detailBackgroundView);
        detailBackgroundView.addSubview(detailLabel)
        
        cornerBackgroundView.snp.makeConstraints { make in
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.top.equalTo(self.contentView).offset(10)
            make.bottom.equalTo(self.contentView).offset(-10)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.width.equalTo(34)
            make.height.equalTo(34)
            make.top.equalTo(cornerBackgroundView).offset(14)
            make.left.equalTo(cornerBackgroundView).offset(14)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView)
            make.left.equalTo(avatarImageView.snp_rightMargin).offset(19)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp_bottomMargin).offset(9)
            make.left.equalTo(nameLabel);
        }
        
        stateTextLabel.snp.makeConstraints { make in
            make.top.equalTo(cornerBackgroundView).offset(24)
            make.right.equalTo(cornerBackgroundView).offset(-13)
        }
        
        detailBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp_bottomMargin).offset(20)
            make.left.equalTo(cornerBackgroundView).offset(10)
            make.right.equalTo(cornerBackgroundView).offset(-10)
            make.bottom.equalTo(cornerBackgroundView).offset(-10)
        }
        
        // 高度自适应
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(detailBackgroundView)
            make.left.equalTo(detailBackgroundView).offset(5)
            make.right.equalTo(detailBackgroundView).offset(5)
            make.bottom.equalTo(detailBackgroundView)
        }
        
    }
}
