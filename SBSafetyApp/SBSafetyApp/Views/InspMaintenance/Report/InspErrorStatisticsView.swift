//
//  InspErrorStatisticsView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/25.
//

import Foundation
import UIKit

class InspErrorStatisticsModal: NSObject {
    var index: Int = 1
    var key: String = ""
    var val: Int = 0
    var percent: Float = 1.0
    
    init(index: Int, key: String, val: Int, percent: Float) {
        self.index = index
        self.key = key
        self.val = val
        self.percent = percent
    }
}

class InspErrorStatisticsView: UIView {
    let staticTitle = InspStatusTitle(withIcon: "ic_report_3", name: "异常巡检项目统计TOP5")

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        layer.masksToBounds = true
        backgroundColor = .white
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadUI(withData lists: [CountStutasModal?]) {
        var lastV: InspErrorItemView? = nil
        for (index, data) in lists.enumerated() {
            let key = data?.bq ?? ""
            let num = data?.sl ?? 0
            let percent = lists[0]?.sl == 0 ? 0 : Float(num) / Float((lists[0]?.sl)!)
            let _d = InspErrorStatisticsModal(index: index + 1, key: key, val: Int(num), percent: percent)
            let itemV = InspErrorItemView(withModal: _d)
            addSubview(itemV)
            itemV.snp.makeConstraints { make in
                make.top.equalTo(lastV == nil ? staticTitle.snp.bottom : lastV!.snp.bottom).offset(22)
                make.left.right.equalToSuperview()
                make.height.equalTo(30)
            }
            
            lastV = itemV
        }
    }

    // MARK: - Setup
    
    func setupUI() {
        addSubview(staticTitle)
        staticTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(21)
        }
    }
}

class InspErrorItemView: UIView {

    init(withModal modal: InspErrorStatisticsModal) {
        super.init(frame: .zero)
        
        setupUI()
        
        let width = (ScreenWidth - 100) * CGFloat(modal.percent)
        
        rateV.snp.updateConstraints { make in
            make.width.equalTo(width)
        }
        
        indexL.text = "\(modal.index)"
        valL.text = "\(modal.val)"
        nameL.text = modal.key
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    func setupUI() {
        addSubview(indexL)
        indexL.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.centerY.equalToSuperview()
            make.left.equalTo(self.snp.left).offset(20)
        }
        
        addSubview(nameL)
        nameL.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(indexL.snp.right).offset(11)
        }
        
        addSubview(valL)
        valL.snp.makeConstraints { make in
            make.centerY.equalTo(nameL.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-27)
        }
        
        addSubview(bgV)
        bgV.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(nameL.snp.left)
            make.width.equalTo(ScreenWidth - 100)
            make.height.equalTo(10)
        }
        
        addSubview(rateV)
        rateV.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(nameL.snp.left)
            make.width.equalTo(0)
            make.height.equalTo(10)
        }
    }
    
    lazy var indexL: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 13)
        l.textAlignment = .center
        l.textColor = .hex("#979EAD")
        l.backgroundColor = .hex("#F1F3F7")
        l.layer.cornerRadius = 4
        l.layer.masksToBounds = true
        return l
    }()
    
    lazy var nameL: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 13)
        l.textColor = .hex("#626E8E")
        return l
    }()
    
    lazy var valL: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14)
        l.textAlignment = .right
        l.textColor = .hex("#3C72FF")
        return l
    }()
    
    lazy var bgV: UIView = {
        let v = UIView()
        v.backgroundColor = .hex("#EDEFF4")
        v.layer.cornerRadius = 5
        v.layer.masksToBounds = true
        return v
    }()
    
    lazy var rateV: UIView = {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth - 100, height: 10))
        v.drawBG([UIColor.hex("#618CFB").cgColor, UIColor.hex("#3C72FF").cgColor], direction: .toRight)
        v.layer.cornerRadius = 5
        v.layer.masksToBounds = true
        return v
    }()
}
