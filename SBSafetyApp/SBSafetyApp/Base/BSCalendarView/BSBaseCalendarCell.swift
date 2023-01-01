//
//  BSBaseCalendarCell.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/23.
//

import Foundation
import UIKit
import JTAppleCalendar

class BSBaseCalendarCell: JTACDayCell {
    lazy var dayView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .hex("#939DB1")
        return label
    }()
    
    lazy var detailLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    lazy var line: UIView = {
        let l = UIView()
        l.backgroundColor = .hex("#B2B5B9")
        l.layer.cornerRadius = 1.5
        l.layer.masksToBounds = true
        return l
    }()
    
    var selectTextColor: UIColor = .hex("#636871")
    var selectFont: UIFont = UIFont.systemFont(ofSize: 15)
    
    var deSelectTextColor: UIColor = .hex("#636871")
    var deSelectFont: UIFont = UIFont.systemFont(ofSize: 15)
    
    var highLightTextColor: UIColor = .hex("#636871")
    var highLightFont: UIFont = UIFont.systemFont(ofSize: 15)
    
    var selectDetailTextColor: UIColor = .hex("#636871")
    var selectDetailFont: UIFont = UIFont.systemFont(ofSize: 15)

    var deSelectDetailTextColor: UIColor = .hex("#636871")
    var deSelectDetailFont: UIFont = UIFont.systemFont(ofSize: 15)

    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .bg
    }
    
    func setupUI(style: BSCalendarStyleEnum) {
        self.contentView.removeAllSubViews()
        switch(style) {
            case .Style1:
            
            contentView.addSubview(dayView)
            dayView.addSubview(dayLabel)
            
            selectTextColor = .hex("#FFFFFF")
            selectFont = UIFont.systemFont(ofSize: 15)
            
            deSelectTextColor = .hex("#636871")
            deSelectFont = UIFont.systemFont(ofSize: 15)
            
            highLightTextColor = .hex("#306EC8")
            highLightFont = UIFont.systemFont(ofSize: 15)
            
            dayView.layer.cornerRadius = 17
            dayView.layer.masksToBounds = true
            dayView.snp.makeConstraints { make in
                make.width.height.equalTo(34)
                make.centerX.equalTo(self.contentView)
            }
            
            dayLabel.snp.makeConstraints { make in
                make.center.equalTo(dayView)
            }
            break;
        case .Style2 :
            contentView.addSubview(dayView)
            contentView.addSubview(detailLabel)
            dayView.addSubview(dayLabel)
            
            selectTextColor = .hex("#FFFFFF")
            selectFont = UIFont.systemFont(ofSize: 15)
            
            deSelectTextColor = .hex("#636871")
            deSelectFont = UIFont.systemFont(ofSize: 15)
            
            highLightTextColor = .hex("#306EC8")
            highLightFont = UIFont.systemFont(ofSize: 15)
            
            selectDetailTextColor = .hex("#333333")
            selectDetailFont = UIFont.systemFont(ofSize: 12)
            
            deSelectDetailTextColor = .hex("#333333")
            deSelectDetailFont = UIFont.systemFont(ofSize: 12)
            
            dayView.layer.cornerRadius = 12
            dayView.layer.masksToBounds = true
            dayView.snp.makeConstraints { make in
                make.width.height.equalTo(24)
                make.centerX.equalTo(self.contentView)
                make.top.equalTo(self.contentView)
            }
            
            dayLabel.snp.makeConstraints { make in
                make.center.equalTo(dayView)
            }
            
            detailLabel.snp.makeConstraints { make in
                make.centerX.equalTo(dayView).offset(2)
                make.top.equalTo(dayView.snp.bottom)
            }
        case .Style3:
            contentView.addSubview(dayLabel)
            contentView.addSubview(dayView)
            
            selectTextColor = .hex("#FFFFFF")
            selectFont = UIFont.systemFont(ofSize: 15)
            
            deSelectTextColor = .hex("#636871")
            deSelectFont = UIFont.systemFont(ofSize: 15)
         
            
            break
        case .Style4:
            contentView.addSubview(dayView)
            contentView.addSubview(line)
            dayView.addSubview(dayLabel)
            
            selectTextColor = .hex("#FFFFFF")
            selectFont = UIFont.systemFont(ofSize: 15)
            
            deSelectTextColor = .hex("#636871")
            deSelectFont = UIFont.systemFont(ofSize: 15)
            
            highLightTextColor = .hex("#306EC8")
            highLightFont = UIFont.systemFont(ofSize: 15)
            
            selectDetailTextColor = .hex("#333333")
            selectDetailFont = UIFont.systemFont(ofSize: 12)
            
            deSelectDetailTextColor = .hex("#333333")
            deSelectDetailFont = UIFont.systemFont(ofSize: 12)
            
            dayView.layer.cornerRadius = 12
            dayView.layer.masksToBounds = true
            dayView.snp.makeConstraints { make in
                make.width.height.equalTo(24)
                make.centerX.equalTo(self.contentView)
                make.top.equalTo(self.contentView)
            }
            
            dayLabel.snp.makeConstraints { make in
                make.center.equalTo(dayView)
            }
            
            line.snp.makeConstraints { make in
                make.centerX.equalTo(dayView)
                make.top.equalTo(dayView.snp.bottom).offset(6)
                make.width.equalTo(15)
                make.height.equalTo(3)
            }
            break
        case .Style5:
            break
        }
        
        dayLabel.textColor = deSelectTextColor
        dayLabel.font = deSelectFont
        
        detailLabel.textColor = deSelectDetailTextColor
        detailLabel.font = deSelectDetailFont
    }
    
    func selectCell() {
        dayView.backgroundColor = .hex("#306EC8")
        dayLabel.textColor = selectTextColor
    }
    
    func deSelectCell() {
        dayView.backgroundColor = .clear
        dayLabel.textColor = deSelectTextColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSelect() {
        
    }
}
