//
//  BSCheckbox.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/29.
//

import Foundation
import UIKit
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

public final class BSCheckbox: UIView {
    var disposeBag = DisposeBag()

    lazy var checkImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "checkmark"))
        imageView.tintColor = .white
        return imageView
    }()

    lazy var checkBox: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 1
        view.layer.masksToBounds = true
        view.backgroundColor = .primary
        return view
    } ()
    
    lazy var uncheckBox: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 1
        view.layer.masksToBounds = true
        view.backgroundColor = .hex("#FAFAFA")
        view.layer.borderColor = UIColor.hex("#D2D2D2").cgColor
        view.layer.borderWidth = 0.5
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hex("#777777")
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    var isSelect = false
    var title = ""
    
    public init() {
        super.init(frame: .zero)
        
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildData(title: String, enable: Bool) {
        self.title = title
        isSelect = enable
        self.removeAllSubViews()
        titleLabel.text = title
        
        if enable {
            addSubview(checkBox)
            checkBox.addSubview(checkImage)
            addSubview(titleLabel)
            
            checkBox.snp.makeConstraints { make in
                make.width.height.equalTo(14)
                make.centerY.equalTo(self)
                make.left.equalTo(self)
            }
            
            checkImage.snp.makeConstraints { make in
                make.center.equalTo(checkBox)
                make.width.equalTo(6.5)
                make.height.equalTo(9)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.left.equalTo(checkBox.snp.right).offset(14)
                make.right.equalTo(self)
                make.centerY.equalTo(self)
                make.top.bottom.equalTo(self)
            }
            
        } else {
            addSubview(uncheckBox)
            addSubview(titleLabel)
            
            uncheckBox.snp.makeConstraints { make in
                make.width.height.equalTo(14)
                make.centerY.equalTo(self)
                make.left.equalTo(self)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.left.equalTo(uncheckBox.snp.right).offset(14)
                make.right.equalTo(self)
                make.centerY.equalTo(self)
                make.bottom.equalTo(self)
                make.top.equalTo(self)
            }
        }
    }
    

}
