//
//  ElecStatisticsView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/14.
//

import Foundation
import UIKit

class ElecStatisticsView: BSStatisticsView {
    let statusCtl = BSStatusControl(withStyle: .style2)
    
    var typeDatas: [StandingBookTypeModal?] = [] {
        didSet {
            updateTypes()
        }
    }
    
    func updateTypes() {
        var dataSource: [SelectPopModal] = [SelectPopModal(name: "全部类型")]
        for model in typeDatas {
            dataSource.append(SelectPopModal(id: (model?.typeValue)!, name: (model?.typeLabel)!))
        }
        DispatchQueue.main.async {
            self.statusCtl.dataSource = dataSource
        }
    }
    
    override func setupUI() {
        super.setupUI()
                
        let itemWight = (ScreenWidth - 50) / 2.0
        deptBtn.snp.remakeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(baseTV.snp.bottom).offset(20)
            make.height.equalTo(35)
            make.width.equalTo(itemWight)
        }
        
        statusCtl.key = "全部类型"
        statusCtl.backgroundColor = .white
        statusCtl.layer.masksToBounds = true
        statusCtl.layer.cornerRadius = 4
        statusCtl.layer.borderColor = UIColor.hex("#E4E4E4").cgColor
        statusCtl.layer.borderWidth = 0.5
        basicBV.addSubview(statusCtl)
        statusCtl.snp.makeConstraints { (make) in
            make.top.equalTo(deptBtn.snp.top)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(35)
            make.width.equalTo(itemWight)
        }
    }
}
