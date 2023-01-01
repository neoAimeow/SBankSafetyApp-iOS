//
//  BSDatePicker.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/11.
//

import Foundation
import UIKit

protocol BSDatePickerDelegate: AnyObject {
    func datePickerSelectDate(_ picker: BSDatePicker, dateCompontnt: BSDateComponent)
}

class BSDatePicker: UIView {
    public weak var delegate: BSDatePickerDelegate?
    
    private let pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    public var minimumDate: Date? {
        didSet {
            self.updateDate(animated: false)
        }
    }
    
    public var maximumDate: Date? {
        didSet {
            self.updateDate(animated: false)
        }
    }
    
    public var date: Date {
        set {
            self.setDate(newValue, animated: false)
        }
        get {
            return self._date
        }
    }
    
    public var textColor: UIColor? = .black {
        didSet {
            self.updateDate(animated: false)
        }
    }
    
    public var font: UIFont? = UIFont.systemFont(ofSize: 16) {
        didSet {
            self.updateDate(animated: false)
        }
    }
    
    public var saturdayColor: UIColor? = UIColor(red: 31/255, green: 119/255, blue: 219/255, alpha: 1) {
        didSet {
            self.updateDate(animated: false)
        }
    }
    
    public var sundayColor: UIColor? = UIColor(red: 198/255, green: 51/255, blue: 42/255, alpha: 1) {
        didSet {
            self.updateDate(animated: false)
        }
    }
    
    public var isShowWeek = false {
        didSet {
            self.pickerView.delegate = nil
            self.pickerView.reloadAllComponents()
            self.pickerView.delegate = self
            self.updateDate(animated: false)
        }
    }
    
    public var dateFormatType: BSDateFormatType = .default {
        didSet {
            self.pickerView.delegate = nil
            self.pickerView.reloadAllComponents()
            self.pickerView.delegate = self
            self.updateDate(animated: false)
        }
    }
    
    public var selectedDateComponent: BSDateComponent {
        let year = self.pickerView.selectedRow(inComponent: self.dateIndex(.year, dateFormatType: self.dateFormatType))
        let month = self.pickerView.selectedRow(inComponent: self.dateIndex(.month, dateFormatType: self.dateFormatType))
        let day = self.pickerView.selectedRow(inComponent: self.dateIndex(.day, dateFormatType: self.dateFormatType))
        var component = BSDateComponent()
        component.year = year + self.minimumDateComponent.year + 1
        component.month = month + self.minimumDateComponent.month + 1
        component.day = day + self.minimumDateComponent.day + 1
        return component
    }
    
    private let years: Int = 9999
    private let months: Int = 12
    private var days: Int = 31
    
    private var isShow = true
    
    private var _date = Date()
    private var dateComponent: BSDateComponent {
        return self.date.dateComponent
    }
    
    private var minimumDateComponent = BSDateComponent()
    
    private var maximumDateComponent = BSDateComponent()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initVars()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initVars() {
        self.addSubview(self.pickerView)
        self.addConstraints([
            NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: self.pickerView, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: self.pickerView, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: self.pickerView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: self.pickerView, attribute: .bottom, multiplier: 1, constant: 0),
            ])
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.updateDate(animated: false)
    }
    
    open func update(animated: Bool) {
        self.updateDate(animated: animated)
    }
    
    open func setDate(_ date: Date, animated: Bool) {
        self._date = date
        self.updateDate(animated: animated)
    }
    
    private func updateDate(animated: Bool) {
        self.isShow = true
        if let minimumDate = self.minimumDate, let maximumDate = self.maximumDate {
            if (minimumDate.dateComponent.year > maximumDate.dateComponent.year) ||
             (minimumDate.dateComponent.year == maximumDate.dateComponent.year && minimumDate.dateComponent.month > maximumDate.dateComponent.month) ||
            (minimumDate.dateComponent.year == maximumDate.dateComponent.year && minimumDate.dateComponent.month == maximumDate.dateComponent.month && minimumDate.dateComponent.day > maximumDate.dateComponent.day) {
                self.isShow = false
            }
        }
        self.pickerView.reloadAllComponents()
        
        if self.isShow {
            self.availableYearDate()
            self.availableMonthDate()
            self.availableDayDate()
            
            if self.updateYearDate(animated: animated) {
                if self.updateMonthDate(animated: animated) {
                    self.updateDayhDate(animated: animated)
                }
            }
        }
    }
    
    private func availableYearDate() {
        if let minimumDate = self.minimumDate {
            self.minimumDateComponent.year = minimumDate.dateComponent.year - 1
        } else {
            self.minimumDateComponent.reset()
        }
        
        if let maximumDate = self.maximumDate {
            self.maximumDateComponent.year = self.years - maximumDate.dateComponent.year
        } else {
            self.maximumDateComponent.reset()
        }
        
        self.pickerView.reloadComponent(self.dateIndex(.year, dateFormatType: self.dateFormatType))
    }
    
    private func availableMonthDate() {
        if self.selectedDateComponent.equalYear(self.minimumDate?.dateComponent) {
            self.minimumDateComponent.month = (self.minimumDate?.dateComponent.month ?? 0) - 1
        } else {
            self.minimumDateComponent.month = 0
        }
        
        if self.selectedDateComponent.equalYear(self.maximumDate?.dateComponent) {
            self.maximumDateComponent.month = self.months - (self.maximumDate?.dateComponent.month ?? 0)
        } else {
            self.maximumDateComponent.month = 0
        }
        
        self.pickerView.reloadComponent(self.dateIndex(.month, dateFormatType: self.dateFormatType))
    }
    
    private func availableDayDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let monthValue = self.selectedDateComponent.month + 1 < 10 ? "0\(self.selectedDateComponent.month + 1)" : "\(self.selectedDateComponent.month + 1)"
        if let date = dateFormatter.date(from: "\(self.selectedDateComponent.yearString)-\(monthValue)-01")?.addingTimeInterval(-24*60*60) {
            self.days = date.dateComponent.day
        } else {
            self.days = 31
        }
        
        if self.selectedDateComponent.equalYearMonth(self.minimumDate?.dateComponent) {
            self.minimumDateComponent.day = (self.minimumDate?.dateComponent.day ?? 0) - 1
        } else {
            self.minimumDateComponent.day = 0
        }
        
        if self.selectedDateComponent.equalYearMonth(self.maximumDate?.dateComponent) {
            self.maximumDateComponent.day = self.days - (self.maximumDate?.dateComponent.day ?? 0)
        } else {
            self.maximumDateComponent.day = 0
        }
        
        self.pickerView.reloadComponent(self.dateIndex(.day, dateFormatType: self.dateFormatType))
    }
    
    @discardableResult
    private func updateYearDate(animated: Bool) -> Bool {
        if !self.isShow { return false }
        if self.dateComponent.year - self.minimumDateComponent.year - 1 < 0 { return false }
        if (self.years - self.minimumDateComponent.year - self.maximumDateComponent.year) < (self.dateComponent.year - self.minimumDateComponent.year - 1) { return false }
        self.pickerView.selectRow(self.dateComponent.year - self.minimumDateComponent.year - 1, inComponent: self.dateIndex(.year, dateFormatType: self.dateFormatType), animated: animated)
        return true
    }
    
    @discardableResult
    private func updateMonthDate(animated: Bool) -> Bool {
        if !self.isShow { return false }
        if self.dateComponent.month - self.minimumDateComponent.month - 1 < 0 { return false }
        if (self.months - self.minimumDateComponent.month - self.maximumDateComponent.month) < (self.dateComponent.month - self.minimumDateComponent.month - 1) { return false }
        self.pickerView.selectRow(self.dateComponent.month - self.minimumDateComponent.month - 1, inComponent: self.dateIndex(.month, dateFormatType: self.dateFormatType), animated: animated)
        return true
    }
    
    @discardableResult
    private func updateDayhDate(animated: Bool) -> Bool {
        if !self.isShow { return false }
        if self.dateComponent.day - self.minimumDateComponent.day - 1 < 0 { return false }
        if (self.days - self.minimumDateComponent.day - self.maximumDateComponent.day) < (self.dateComponent.day - self.minimumDateComponent.day - 1) { return false }
        self.pickerView.selectRow(self.dateComponent.day - self.minimumDateComponent.day - 1, inComponent: self.dateIndex(.day, dateFormatType: self.dateFormatType), animated: animated)
        return true
    }
    
    private func checkWeek(_ value: Int) -> (week: BSDateComponent.Weekday, weekValue: String) {
        let value = value + 1 < 10 ? "0\(value + 1)" : "\(value + 1)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: "\(self.selectedDateComponent.yearString)-\(self.selectedDateComponent.monthString)-\(value)"),
            let week = date.dateComponent.week {
            return (week, "(\(week.valueShort()))")
        }
        return (.sunday, "")
    }
}

// MARK: UIPickerViewDelegate
extension BSDatePicker: UIPickerViewDelegate {
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 31.0
    }
    
    public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return self.width(dateType: self.dateArray(self.dateFormatType)[component], isShowWeek: self.isShowWeek)
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.availableYearDate()
        self.availableMonthDate()
        self.availableDayDate()
        self.delegate?.datePickerSelectDate(self, dateCompontnt: self.selectedDateComponent)
    }
}

// MARK: UIPickerViewDataSource
extension BSDatePicker: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if !self.isShow { return 0 }
        return self.dateArray(self.dateFormatType).count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch self.dateArray(self.dateFormatType)[component] {
        case .year:
            return self.years - self.minimumDateComponent.year - self.maximumDateComponent.year
        case .month:
            return self.months - self.minimumDateComponent.month - self.maximumDateComponent.month
        case .day:
            return self.days - self.minimumDateComponent.day - self.maximumDateComponent.day
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let dateType = self.dateArray(self.dateFormatType)[component]
        let label = UILabel()
        label.textAlignment = self.alignment(dateType: dateType)
        let attributedString = NSMutableAttributedString()
        switch dateType {
        case .year:
            attributedString.append(NSAttributedString(string: self.year(row + self.minimumDateComponent.year), attributes: [
                NSAttributedString.Key.font : self.font ?? UIFont.systemFont(ofSize: 23),
                NSAttributedString.Key.foregroundColor : self.textColor ?? .black,
                ]))
        case .month:
            attributedString.append(NSAttributedString(string: self.month(row + self.minimumDateComponent.month), attributes: [
                NSAttributedString.Key.font : self.font ?? UIFont.systemFont(ofSize: 23),
                NSAttributedString.Key.foregroundColor : self.textColor ?? .black,
                ]))
        case .day:
            let rowValue = row + self.minimumDateComponent.day
            if self.isShowWeek {
                let week = self.checkWeek(rowValue)
                var color: UIColor = self.textColor ?? .black
                if week.week == .saturday {
                    color = self.saturdayColor ?? UIColor(red: 31/255, green: 119/255, blue: 219/255, alpha: 1)
                } else if week.week == .sunday {
                    color = self.sundayColor ?? UIColor(red: 198/255, green: 51/255, blue: 42/255, alpha: 1)
                }
                attributedString.append(NSAttributedString(string: "\(self.day(rowValue)) \(week.weekValue)", attributes: [
                    NSAttributedString.Key.font : self.font ?? UIFont.systemFont(ofSize: 23),
                    NSAttributedString.Key.foregroundColor : color,
                    ]))
            } else {
                attributedString.append(NSAttributedString(string: self.day(rowValue), attributes: [
                    NSAttributedString.Key.font : self.font ?? UIFont.systemFont(ofSize: 23),
                    NSAttributedString.Key.foregroundColor : self.textColor ?? .black,
                    ]))
            }
        }
        label.attributedText = attributedString
        label.adjustsFontSizeToFitWidth = true
        return label
    }
}

extension BSDatePicker {
    func dateArray(_ dateFormatType: BSDateFormatType) -> [BSDateType] {
        if dateFormatType == .default {
            return [.year, .month, .day]
        } else {
            return [.year, .month]
        }
    }
    
    func width(dateType: BSDateType, isShowWeek: Bool) -> CGFloat {
        if dateType == .year {
            return 80
        } else if dateType == .month {
            return 50
        } else {
            if isShowWeek {
                return 95
            } else {
                return 70
            }
        }
    }
    
    func alignment(dateType: BSDateType) -> NSTextAlignment {
        if dateType == .year {
            return .center
        } else if dateType == .month {
            return .left
        } else {
            return .left
        }
    }
    
    func dateIndex(_ dateType: BSDateType, dateFormatType: BSDateFormatType) -> Int {
        return self.dateArray(dateFormatType).firstIndex(where: { $0 == dateType }) ?? 0
    }
    
    func year(_ value: Int) -> String {
        return "\(value + 1)年"
    }
    
    func month(_ value: Int) -> String {
        return "\(value + 1)月"
    }
    
    func day(_ value: Int) -> String {
        return "\(value + 1)日"
    }
}
