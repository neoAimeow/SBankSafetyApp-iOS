//
//  NetworkStateEditPopup.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/12/17.
//  营业网点状态-修改弹窗

import Foundation
import UIKit
import JFPopup
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

protocol NetworkStateEditPopupDelegate: AnyObject {
    func editPopupCancelButtonClicked();
    func editPopupSubmitButtonClicked(isOpen: Bool, text: String);
}

class NetworkStateEditPopup: UIView {
    weak var delegate: NetworkStateEditPopupDelegate?
    var disposeBag = DisposeBag()

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .hex("#000000")
        return label
    }()

    lazy var titleLine: UIView = {
        return UIView.createLine()
    }()
    
    var isOpen = true
    
    lazy var doCheckBox: BSCheckbox = {
        let view = BSCheckbox()
        view.buildData(title: "营业", enable: true)
        view.isUserInteractionEnabled = true
        view.rx.tapGesture().when(.recognized)
                .subscribe(onNext: { [self] _ in
                    view.buildData(title: "营业", enable: true)
                    undoCheckBox.buildData(title: "不营业", enable: false)
                    self.isOpen = true
                })
                .disposed(by: disposeBag)

        
        return view
    }()
    
    lazy var undoCheckBox: BSCheckbox = {
        let view = BSCheckbox()
        view.buildData(title: "不营业", enable: false)
        view.isUserInteractionEnabled = true
        view.rx.tapGesture().when(.recognized)
                .subscribe(onNext: { [self] _ in
                    print("不营业")
                    doCheckBox.buildData(title: "营业", enable: false)
                    view.buildData(title: "不营业", enable: true)
                    self.isOpen = false
                })
                .disposed(by: disposeBag)

        return view
    }()
    
    
    lazy var textView: BSTextView = {
        let view = BSTextView()
        view.backgroundColor = .hex("#FAFAFA")
        view.font = UIFont.systemFont(ofSize: 13)
        view.textColor = .hex("#B8B8B8")
        view.placeholder = "请说明此次调整的原因"
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    lazy var buttonLine: UIView = {
        return UIView.createLine()
    }()
    
    lazy var buttonVelLine: UIView = {
        return UIView.createLine()
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("取消", for: .normal)
        button.setTitleColor(.hex("#999999"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(cancelButtonClicked(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("提交", for: .normal)
        button.setTitleColor(.hex("#306EC8"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(submitButtonClicked(sender:)), for: .touchUpInside)
        return button
    }()

    
    @objc func cancelButtonClicked(sender: UIButton) {
        (self.getFirstViewController() as! JFPopupController).dismiss(animated: true)
        delegate?.editPopupCancelButtonClicked()
    }
    
    @objc func submitButtonClicked(sender: UIButton) {
        (self.getFirstViewController() as! JFPopupController).dismiss(animated: true)
        delegate?.editPopupSubmitButtonClicked(isOpen: self.isOpen, text: textView.text)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        backgroundColor = .white
        buildData(dateStr: "2022年01月01日")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildData(dateStr: String) {
        dateLabel.text = dateStr
    }
    
    func setupUI() {
        layer.masksToBounds = true
        layer.cornerRadius = 8
        addSubview(dateLabel)
        addSubview(titleLine)
        addSubview(doCheckBox)
        addSubview(undoCheckBox)
        addSubview(textView)
        addSubview(cancelButton)
        addSubview(submitButton)
        addSubview(buttonLine)
        addSubview(buttonVelLine)
        
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(22)
        }
        
        titleLine.snp.makeConstraints { make in
            make.left.right.equalTo(self)
            make.top.equalTo(dateLabel.snp.bottom).offset(22)
            make.height.equalTo(0.5)
        }
        
        doCheckBox.snp.makeConstraints { make in
            make.top.equalTo(titleLine.snp.bottom).offset(27)
            make.left.equalTo(self).offset(32)
        }
        
        undoCheckBox.snp.makeConstraints { make in
            make.top.equalTo(doCheckBox.snp.top)
            make.left.equalTo(doCheckBox.snp.right).offset(40)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(undoCheckBox.snp.bottom).offset(17)
            make.left.equalTo(self).offset(32)
            make.right.equalTo(self).offset(-32)
            make.height.equalTo(109)
        }
        
        buttonLine.snp.makeConstraints { make in
            make.left.right.equalTo(self)
            make.top.equalTo(textView.snp.bottom).offset(25.5)
            make.height.equalTo(0.5)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.left.equalTo(self)
            make.height.equalTo(53)
            make.top.equalTo(buttonLine.snp.bottom)
        }
        
        submitButton.snp.makeConstraints { make in
            make.right.equalTo(self)
            make.height.equalTo(cancelButton)
            make.left.equalTo(cancelButton.snp.right)
            make.width.equalTo(cancelButton)
            make.top.equalTo(cancelButton)
        }
  
        buttonVelLine.snp.makeConstraints { make in
            make.top.equalTo(cancelButton)
            make.bottom.equalTo(cancelButton)
            make.width.equalTo(0.5)
            make.left.equalTo(cancelButton.snp.right)
        }
        
    }
}
