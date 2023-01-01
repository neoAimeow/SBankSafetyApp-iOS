//
//  BSCalendar.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/22.
//

import Foundation
import UIKit
import JTAppleCalendar

enum BSCalendarStyleEnum: Int {
    // https://yzf.qq.com/fsna/kf-file/kf_pic/20221123/KFPIC_kfh5221fa29cfc019f_h5cded9881fc7d6fdfece5fb364b_WXIMAGE_176315820ef8400981d3be16d5c29818.png
    case Style1 = 9001
    // https://yzf.qq.com/fsna/kf-file/kf_pic/20221124/KFPIC_kfh5221fa29cfc019f_h5cded9881fc7d6fdfece5fb364b_WXIMAGE_4a86771408b447fa9bc1951e987c621c.png
    case Style2 = 9002
    // https://yzf.qq.com/fsna/kf-file/kf_pic/20221124/KFPIC_kfh5221fa29cfc019f_h5cded9881fc7d6fdfece5fb364b_WXIMAGE_66cd9a1390134baea23b1c17c96f0e57.png
    case Style3 = 9003

    case Style4 = 9004
    case Style5 = 9005

}

protocol BSCalendarDelegate: AnyObject {
    func calendar(didSelectDate date: Date);

}

class BSCalendarView: UIView {
    weak var delegate: BSCalendarDelegate?

    var style: BSCalendarStyleEnum = BSCalendarStyleEnum.Style1

    var multipleSelect: Bool = false {
        didSet {
            calendarView.allowsMultipleSelection = multipleSelect
        }
    }
    
    var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    let currentCalendar = Calendar.current
    var dateNow = Date()
    var endDate = Date()
    var selectDate = Date()


    lazy var monthTitleView: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .hex("#3F424A")
        return label
    }()

    lazy var leftIndicatorButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.init(systemName: "chevron.left"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(didTapNavigation(sender:)), for: .touchUpInside)
        button.tintColor = .hex("#64676E")
        return button
    }()

    lazy var rightIndicatorButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.init(systemName: "chevron.right"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(didTapNavigation(sender:)), for: .touchUpInside)
        button.tintColor = .hex("#64676E")
        return button
    }()

    lazy var titleStackView: UIView = {
        let view = UIView()
        view.addSubview(leftIndicatorButton)
        view.addSubview(monthTitleView)
        view.addSubview(rightIndicatorButton)
        leftIndicatorButton.snp.makeConstraints { make in
            make.left.equalTo(view).offset(22)
            make.height.equalTo(11)
            make.centerY.equalTo(view)
            make.width.equalTo(6.5)
        }

        monthTitleView.snp.makeConstraints { make in
            make.center.equalTo(view)
        }

        rightIndicatorButton.snp.makeConstraints { make in
            make.height.equalTo(11)
            make.width.equalTo(6.5)
            make.right.equalTo(view).offset(-22)
            make.centerY.equalTo(view)
        }
        return view
    }()

    lazy var weekTitleView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalSpacing
        let weekStrs = ["日", "一", "二", "三", "四", "五", "六"]

        for weekStr in weekStrs {
            let label = UILabel.createWeekLabel()
            label.text = weekStr
            view.addArrangedSubview(label)
        }
        return view
    }()


    lazy var calendarView: JTACMonthView = {
        let view = JTACMonthView()
        view.backgroundColor = .bg
        view.translatesAutoresizingMaskIntoConstraints = false
        view.calendarDataSource = self
        view.calendarDelegate = self
        view.scrollDirection = .horizontal
        view.scrollingMode = .stopAtEachSection
        view.minimumInteritemSpacing = 0
        view.minimumLineSpacing = 0
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.register(BSBaseCalendarCell.self, forCellWithReuseIdentifier: "BSBaseCalendarCell")
        return view
    }()


    init() {
        super.init(frame: .zero)
        calendarView.scrollToSegment(.end, triggerScrollToDateDelegate: true, animateScroll: false)
        monthTitleView.text = "\(dateNow.string(format: "yyyy年MM月"))"

        self.addSubview(titleStackView)
        self.addSubview(weekTitleView)
        self.addSubview(calendarView)


        titleStackView.snp.makeConstraints { make in
            make.top.left.right.equalTo(self)
            make.height.equalTo(48)
        }

        weekTitleView.snp.makeConstraints { make in
            make.left.equalTo(self).offset(22)
            make.right.equalTo(self).offset(-22)
            make.top.equalTo(titleStackView.snp.bottom)
            make.height.equalTo(55)
        }

        calendarView.snp.makeConstraints { make in
            make.left.right.equalTo(self)
            make.top.equalTo(weekTitleView.snp.bottom)
            make.height.equalTo(300)
            make.bottom.equalTo(self)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func didTapNavigation(sender: UIButton) {
        if sender == leftIndicatorButton {
            calendarView.scrollToSegment(.previous)
        } else {
            calendarView.scrollToSegment(.next)
        }
    }
}

extension BSCalendarView: JTACMonthViewDataSource, JTACMonthViewDelegate {
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
                let startDate = formatter.date(from: "2016-01-01")!
                endDate = dateNow
                let parameters = ConfigurationParameters(
                        startDate: startDate,
                        endDate: endDate,
                        numberOfRows: 6,
                        calendar: Calendar.current,
                        generateInDates: .forAllMonths,
                        generateOutDates: .tillEndOfGrid,
                        firstDayOfWeek: .sunday)
        
                return parameters
    }
    
    

    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        if (cell != nil) {
            if cellState.dateBelongsTo == .thisMonth {
                (cell as! BSBaseCalendarCell).selectCell()
            }
            delegate?.calendar(didSelectDate: date)
            selectDate = date
        }
    }

    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        if cell != nil {
            if cellState.dateBelongsTo == .thisMonth {
                (cell as! BSBaseCalendarCell).deSelectCell()
            }
        }
    }

    func calendar(_ calendar: JTACMonthView, didHighlightDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {

    }

    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        let cell = calendar.dequeueReusableCell(withReuseIdentifier: "BSBaseCalendarCell", for: indexPath) as! BSBaseCalendarCell
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return cell
    }

    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let cell = cell as! BSBaseCalendarCell
        cell.setupUI(style: style)
        cell.line.isHidden = cellState.dateBelongsTo != .thisMonth

        if cellState.dateBelongsTo == .thisMonth {
            cell.dayLabel.text = "\(date.string(format: "dd"))"
            cell.detailLabel.text = "100%"
        } else {
            cell.dayLabel.text = ""
        }
    }

    func calendar(_ calendar: JTACMonthView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        let currentMonth = visibleDates.monthDates.first
        monthTitleView.text = "\(currentMonth?.date.string(format: "yyyy年MM月") ?? "")"
    }
    
    
}

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

extension UILabel {
    class func createWeekLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .hex("#B6B6B6")
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }
}
