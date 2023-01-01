//
//  BSCustomDateView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/29.
//

import Foundation
import UIKit

protocol BSCustomDateViewDelegate {
    func didSelected(year: Int, quarter: Int?, month: Int?, day: Int?, dateEnum: CustomDateEnum)
}

enum CustomDateEnum: Int {
    case daily = 1
    case monthly = 2
    case quarterly = 3
    case annual = 4
}

enum CustomDateTypeEnum: Int {
    case normal = 1
    case subTitle = 2
}

class BSCustomDateView: UIView {
    var delegate: BSCustomDateViewDelegate?
    
    var dateEnum: CustomDateEnum = .daily

    var day = Calendar.current.component(.day, from: Date())
    var month = Calendar.current.component(.month, from: Date())
    var quarter = Date.getCurrentQuarter(month: Calendar.current.component(.month, from: Date()))
    var year = Calendar.current.component(.year, from: Date())
    
    var datas = ["日", "月", "季", "年"] {
        didSet {
            segmentedC.itemTitles = datas
        }
    }
    
    var dateValue = "" {
        didSet {
            dateL.text = dateValue
        }
    }
    
    var subValue = "" {
        didSet {
            subTitleL.text = subValue
        }
    }
    
    var type: CustomDateTypeEnum = .normal
 
    let dateL = UILabel()
    let subTitleL = UILabel()
    let segmentedC = StaticSegmented()
    
    init(withType _type: CustomDateTypeEnum = .normal) {
        super.init(frame: .zero)
        self.type = _type
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    func selectItemWith(index: Int, title: String?) {
//        day = Calendar.current.component(.day, from: Date())
//        month = Calendar.current.component(.month, from: Date())
//        quarter = Date.getCurrentQuarter(month: Calendar.current.component(.month, from: Date()))
//        year = Calendar.current.component(.year, from: Date())
//
        if title == "日" {
            dateEnum = .daily
            dateValue = "\(year)年\(month)月\(day)日"
            delegate?.didSelected(year: year, quarter: quarter, month: month, day: day, dateEnum: .daily)
        } else if title == "月" {
            dateEnum = .monthly
            dateValue = "\(year)年\(month)月"
            delegate?.didSelected(year: year, quarter: quarter, month: month, day: day, dateEnum: .monthly)
        } else if title == "季" {
            dateEnum = .quarterly
            dateValue = "\(year)年第\(quarter)季度"
            delegate?.didSelected(year: year, quarter: quarter, month: month, day: day, dateEnum: .quarterly)
        } else if title == "年" {
            dateEnum = .annual
            dateValue = "\(year)年"
            delegate?.didSelected(year: year, quarter: quarter, month: month, day: day, dateEnum: .annual)
        }
    }
    
    @objc func leftTapped() {
        switch dateEnum {
        case .daily:
            let date = Date.previousDay(year: year, month: month, day: day)
            updateDay(date)
            break
        case .monthly:
            let date = Date.previousMonth(year: year, month: month)
            updateDay(date)
            break
        case .quarterly:
            let date = Date.previousQuarter(year: year, month: month)
            updateDay(date)
            break
        case .annual:
            let date = Date.previousAnnual(year: year)
            updateDay(date)
            break
        }
    }
    
    @objc func rightTapped() {
        switch dateEnum {
        case .daily:
            let date = Date.nextDay(year: year, month: month, day: day)
            updateDay(date)
            break
        case .monthly:
            let date = Date.nextMonth(year: year, month: month)
            updateDay(date)
            break
        case .quarterly:
            let date = Date.nextQuarter(year: year, month: month)
            updateDay(date)
            break
        case .annual:
            let date = Date.nextAnnual(year: year)
            updateDay(date)
            break
        }
    }
    
    func updateDay(_ date: Date)  {
        year =  Calendar.current.component(.year, from: date)
        month =  Calendar.current.component(.month, from: date)
        quarter =  Calendar.current.component(.quarter, from: date)
        quarter = Date.getCurrentQuarter(month: month)
        day =  Calendar.current.component(.day, from: date)
        
        switch dateEnum {
        case .daily:
            dateValue = "\(year)年\(month)月\(day)日"
            delegate?.didSelected(year: year, quarter: nil, month: month, day: day, dateEnum: .daily)
            break
        case .monthly:
            dateValue = "\(year)年\(month)月"
            delegate?.didSelected(year: year, quarter: nil, month: month, day: nil, dateEnum: .monthly)
            break
        case .quarterly:
            dateValue = "\(year)年第\(quarter)季度"
            delegate?.didSelected(year: year, quarter: quarter, month: nil, day: nil, dateEnum: .quarterly)
            break
        case .annual:
            dateValue = "\(year)年"
            delegate?.didSelected(year: year, quarter: nil, month: nil, day: nil, dateEnum: .annual)
            break
        }
    }
    
    
    // MARK: - Setup
    
    func setupUI() {
        let leftBtn = UIButton(type: .custom)
        leftBtn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        leftBtn.tintColor = .hex("#CCCCCC")
        leftBtn.addTarget(self, action: #selector(leftTapped), for: .touchUpInside)
        addSubview(leftBtn)
        leftBtn.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.snp.left)
            make.width.equalTo(30)
            make.height.equalTo(35)
        }
        
        dateL.textAlignment = .center
        dateL.adjustsFontSizeToFitWidth = true
        addSubview(dateL)
        dateL.snp.makeConstraints { (make) -> Void in
            if type == .normal {
                make.centerY.equalTo(self.snp.centerY)
            } else {
                make.top.equalTo(self.snp.top)
            }
            make.left.equalTo(leftBtn.snp.right)
            make.width.equalTo(120)
        }
        
        if type == .subTitle {
            subTitleL.textAlignment = .center
            subTitleL.adjustsFontSizeToFitWidth = true
            subTitleL.textColor = .primary
            subTitleL.font = .systemFont(ofSize: 14)
            addSubview(subTitleL)
            subTitleL.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(dateL.snp.bottom)
                make.left.equalTo(leftBtn.snp.right)
                make.width.equalTo(120)
            }
        }
                
        let rightBtn = UIButton(type: .custom)
        rightBtn.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        rightBtn.addTarget(self, action: #selector(rightTapped), for: .touchUpInside)
        rightBtn.tintColor = .hex("#CCCCCC")
        addSubview(rightBtn)
        rightBtn.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(dateL.snp.right)
            make.width.equalTo(30)
            make.height.equalTo(35)
        }
        
        segmentedC.bgColor = .bg
        segmentedC.selectedBgColor = .white
        segmentedC.font = .systemFont(ofSize: 15)
        segmentedC.selectedFont = .systemFont(ofSize: 15)
        segmentedC.textColor = .hex("#B9B9B9")
        segmentedC.selectedTextColor = .black
        segmentedC.sectionWidth = 43
        segmentedC.padding = 4
        segmentedC.cornerRadius = 13.5
        segmentedC.itemTitles = datas
        segmentedC.didSelectItemWith = { (index, title) -> () in
            self.selectItemWith(index: index, title: title)
        }
        addSubview(segmentedC)
        segmentedC.snp.makeConstraints { make in
            make.right.equalTo(self.snp.right).offset(-13)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(35)
        }
        
        self.dateValue = "\(year)年\(month)月\(day)日"
        self.subValue = "整体完成率: 0%"
    }
}
