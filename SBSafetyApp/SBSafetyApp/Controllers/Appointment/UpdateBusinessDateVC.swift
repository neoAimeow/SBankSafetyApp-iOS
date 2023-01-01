//
//  UpdateBusinessDateVC.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/24.
// 修改营业日期

import Foundation
import UIKit

class UpdateBusinessDateVC: SubLevelViewController {
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var calendarView: BSCalendarView = {
        let view = BSCalendarView()
        view.multipleSelect = true
        view.style = .Style4
        return view
    }()
    
    lazy var reminderView: TaskUBRemindView = {
        let view = TaskUBRemindView()
        return view
    }()
    
    lazy var textViewPanel: BaseTextViewPanel = {
        let view = BaseTextViewPanel(withStyle: .Style2, withTitle: "修改说明")
        
        return view
    }()
    
    lazy var updateButton: UIButton = {
        let button = UIButton.createCornerButton("保存修改")
        button.backgroundColor = .hex("#0F499E")
        button.addTarget(self, action: #selector(updateButtonClicked), for: .touchUpInside)
        return button
    }()
  
    @objc func updateButtonClicked() {
        let workDates = calendarView.calendarView.selectedDates;
        var workDatesStrArray: [String] = []
        for date in workDates {
            workDatesStrArray.append(Date.normalDateFormatter2().string(from: date))
        }
        let workDate = workDatesStrArray.joined(separator: ",")
        print(workDate)
        let year = Date().string(format: "yyyy")
        let month = Date().string(format: "MM")
        API.xgyyzt(withParam: XgyyztParam(deptId: self.deptId ?? BSUser.currentUser.deptId, month: month, remark: textViewPanel.textView.text, status: "1", type: "month", workDates: workDate, year: year)) { responseModel in
            Utils.app.window?.showToast(witMsg: "修改成功")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "月营业日"
        setupUI()
    }
    
    func setupUI() {
        self.view.backgroundColor = UIColor.hex("#F8F8F8")
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(calendarView)
        contentView.addSubview(reminderView)
        contentView.addSubview(textViewPanel)
        contentView.addSubview(updateButton)
        
        scrollView.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(ScreenWidth)
        }
  
        calendarView.snp.makeConstraints { make in
            make.left.top.right.equalTo(contentView)
        }
        
        reminderView.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(calendarView.snp.bottom).offset(5)
        }
        
        textViewPanel.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
            make.top.equalTo(reminderView.snp.bottom).offset(30)
        }
        
        updateButton.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
            make.top.equalTo(textViewPanel.snp.bottom).offset(30)
            make.height.equalTo(50)
            make.bottom.equalTo(contentView.snp.bottom).offset(-30)
        }
   
    }
}


class TaskUBRemindView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    func setupUI() {
        let line1 = UIView()
        line1.backgroundColor = .hex("#B2B5B9")
        line1.layer.cornerRadius = 1.5
        line1.layer.masksToBounds = true
        addSubview(line1)
        line1.snp.makeConstraints { make in
            make.width.equalTo(10)
            make.height.equalTo(10)
            make.centerY.left.equalToSuperview()
            make.left.equalTo(self)
        }
        
        let label1 = UILabel()
        label1.text = "营业"
        label1.textColor = .hex("#636871")
        label1.font = .systemFont(ofSize: 14)
        addSubview(label1)
        label1.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(40)
            make.left.equalTo(line1.snp.right).offset(5)
        }
        
        let line2 = UIView()
        line2.backgroundColor = .hex("#FF0000")
        line2.layer.cornerRadius = 1.5
        line2.layer.masksToBounds = true
        addSubview(line2)
        line2.snp.makeConstraints { make in
            make.width.equalTo(10)
            make.height.equalTo(10)
            make.centerY.equalToSuperview()
            make.left.equalTo(label1.snp.right).offset(40)
        }
        
        let label2 = UILabel()
        label2.text = "不营业"
        label2.textColor = .hex("#FF0000")
        label2.font = .systemFont(ofSize: 14)
        addSubview(label2)
        label2.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(line2.snp.right).offset(5)
            make.width.equalTo(45)
            make.right.equalTo(self)
        }
    }
}

