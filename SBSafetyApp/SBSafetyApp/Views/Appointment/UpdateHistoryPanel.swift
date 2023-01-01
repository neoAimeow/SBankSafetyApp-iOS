//
//  UpdateHistoryPanel.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/28.
//

import Foundation
import UIKit
#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif



protocol UpdateHistoryPanelDelegate: AnyObject {
    func historyCellClicked(model: UpdateHistoryModal);
}

class UpdateHistoryPanel: UIView {
    var disposeBag = DisposeBag()

    weak var delegate: UpdateHistoryPanelDelegate?

    lazy var titleView: SectionTitleView = {
        let titleView = SectionTitleView(withStyle: .Style2, title: "修改历史")
        return titleView;
    }()
    
    lazy var lineView: UIView = {
        return UIView.createLightLine()
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
    }
    
    func buildData(models: [UpdateHistoryModal]) {
        removeAllSubViews()
        stackView.removeAllSubViews()

        self.layer.masksToBounds = true
        self.layer.cornerRadius = 7
        self.backgroundColor = .white
        
        addSubview(titleView)
        addSubview(lineView)
        addSubview(stackView)

        titleView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(20)
            make.left.equalTo(self).offset(20)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(20)
            make.height.equalTo(0.5)
            make.left.right.equalTo(self)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom)
            make.left.right.equalTo(self)
            make.bottom.equalTo(self)
        }
        
        
        models.forEach { model in
            let view = UpdateHistoryCell()
            let line = UIView.createLightLine()
            
            view.rx.tapGesture().when(.recognized)
                .subscribe(onNext: { _ in
                    self.delegate?.historyCellClicked(model: model)
                })
                .disposed(by: disposeBag)
            
                        
            view.buildData(data: model)
            stackView.addArrangedSubview(view)
            stackView.addArrangedSubview(line)
            view.snp.makeConstraints { make in
                make.height.equalTo(70)
            }
            line.snp.makeConstraints { make in
                make.height.equalTo(0.5)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
