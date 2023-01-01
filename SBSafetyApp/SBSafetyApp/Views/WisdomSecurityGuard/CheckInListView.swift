//
//  CheckInListView.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/16.
//
// https://pic2.58cdn.com.cn/nowater/webim/big/n_v272978bf2167f42a5916df271e92d3b38.png

import Foundation
import UIKit

class CheckInListView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func buildData(models datas: [CheckInListModel]) {
        self.removeAllSubViews()
        var viewArr: [SecurityCheckInCell] = []
        for _data in datas {
            let view = SecurityCheckInCell()
            view.buildData(model: _data)
            viewArr.append(view)
            addSubview(view)
            
            view.snp.makeConstraints { make in
                make.height.equalTo(109)
            }
        }
        
        viewArr.snp.distributeViewsAlong(axisType: .vertical, fixedSpacing: 10, leadSpacing: 10, tailSpacing: 10)

        viewArr.snp.makeConstraints { make in
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
