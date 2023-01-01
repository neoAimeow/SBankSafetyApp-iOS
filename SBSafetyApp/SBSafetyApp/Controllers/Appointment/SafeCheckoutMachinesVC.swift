//
//  SafeCheckoutMachinesVC.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/28.
//

import Foundation
import UIKit

class SafeCheckoutMachinesVC: SubLevelViewController {
    var id: Int64?
    var name: String?
    var dateStr: String?
    var titleStr: String?
    var remark: String?
    var isSuitable:Bool?
    
    lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.textColor = .hex("#306EC8")
        label.font = UIFont.systemFont(ofSize: 17)
        
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        var label = UILabel()
        label.textColor = .hex("#999999")
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "2022-09-26 10:01:41"
        
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.textColor = .hex("#000000")
        label.font = UIFont.systemFont(ofSize: 17)
        
        return label
    }()
    
    
    lazy var yesView:UIView = {
        var view = UIView()
        view.backgroundColor = .hex("#EAF7F0")
        view.layer.cornerRadius = 1
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.hex("#2AAD67").cgColor
        view.layer.borderWidth = 0.5
        
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .hex("#333333")
        view.addSubview(label)
        label.text = "合格"
        
        label.snp.makeConstraints { make in
            make.centerY.equalTo(view)
            make.left.equalTo(12)
        }
        
        return view
    }()
    
    lazy var noView:UIView = {
        var view = UIView()
        view.layer.cornerRadius = 1
        view.layer.masksToBounds = true
        view.backgroundColor = .hex("#FDEDEC")
        view.layer.borderColor = UIColor.hex("#E64340").cgColor
        view.layer.borderWidth = 0.5
        
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .hex("#333333")
        view.addSubview(label)
        label.text = "不合格"
        
        label.snp.makeConstraints { make in
            make.centerY.equalTo(view)
            make.left.equalTo(12)
        }
        return view
    }()
    
    lazy var explainTitleLabel: UILabel = {
        var label = UILabel()
        label.textColor = .hex("#000000")
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "说明"
        
        return label
    }()
    
    lazy var explainContainerView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 6
        view.layer.borderColor = UIColor.hex("#E4E4E4").cgColor
        return view
    }()
    
    lazy var explainContentTextView: UITextView = {
        var label = UITextView()
        label.textColor = .hex("#000000")
        label.font = UIFont.systemFont(ofSize: 16)
        label.isEditable = false
  
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        title = "自助机具"
        let rightBtn = UIBarButtonItem.init(title: "补充说明", style: .done, target: self, action: #selector(titleBarButtonItemMethod))
        rightBtn.tintColor = UIColor.hex("#306EC8")
        self.navigationItem.rightBarButtonItem = rightBtn
        setupUI()
        
        if let nameValue = name {
            nameLabel.text = nameValue
        }
        
        if let dateStrValue = dateStr {
            dateLabel.text  = dateStrValue
        }
        
        if let titleValue = titleStr {
            titleLabel.text = titleValue
        }
        
        if let remarkValue = remark {
            explainContentTextView.text = remarkValue
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func setupUI() {
        view.addSubview(nameLabel)
        view.addSubview(dateLabel)
        view.addSubview(titleLabel)
        if let isSuitableValue = isSuitable {
            if isSuitableValue {
                view.addSubview(yesView)
            } else {
                view.addSubview(noView)
            }
        }
        view.addSubview(explainTitleLabel)
        view.addSubview(explainContainerView)
        explainContainerView.addSubview(explainContentTextView)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.left.equalTo(view).offset(11)
            make.right.equalTo(view).offset(-11)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(12)
            make.left.equalTo(view).offset(11)
            make.right.equalTo(view).offset(-11)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(38)
            make.left.equalTo(view).offset(11)
            make.right.equalTo(view).offset(-11)
        }
        
        if let isSuitableValue = isSuitable {
            if isSuitableValue {
                yesView.snp.makeConstraints { make in
                    make.top.equalTo(titleLabel.snp.bottom).offset(20)
                    make.left.equalTo(view).offset(11)
                    make.right.equalTo(view).offset(-11)
                    make.height.equalTo(45)
                }
                
                explainTitleLabel.snp.makeConstraints { make in
                    make.top.equalTo(yesView.snp.bottom).offset(30)
                    make.left.equalTo(view).offset(11)
                    make.right.equalTo(view).offset(-11)
                }
            } else {
                noView.snp.makeConstraints { make in
                    make.top.equalTo(titleLabel.snp.bottom).offset(20)
                    make.left.equalTo(view).offset(11)
                    make.right.equalTo(view).offset(-11)
                    make.height.equalTo(45)
                }
                
                explainTitleLabel.snp.makeConstraints { make in
                    make.top.equalTo(noView.snp.bottom).offset(30)
                    make.left.equalTo(view).offset(11)
                    make.right.equalTo(view).offset(-11)
                }
                    
            }
        }
        
      

        explainContainerView.snp.makeConstraints { make in
            make.left.equalTo(view).offset(11)
            make.right.equalTo(view).offset(-11)
            make.top.equalTo(explainTitleLabel.snp.bottom).offset(15)
            make.height.equalTo(116)
        }
        
        explainContentTextView.snp.makeConstraints { make in
            make.left.equalTo(explainContainerView).offset(15)
            make.right.equalTo(explainContainerView).offset(-15)
            make.top.equalTo(explainContainerView).offset(15)
            make.bottom.equalTo(explainContainerView).offset(-15)
        }
    }
    
    @objc func titleBarButtonItemMethod() {
        let vc = ReplenishContentVC()
        vc.id = id
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
