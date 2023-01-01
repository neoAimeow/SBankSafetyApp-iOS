//
//  WeekBizDateEditVC.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/28.
// 履职管理-周营业日

import Foundation

import Foundation
import UIKit

class WeekBizDateEditVC: SubLevelViewController {
    
    lazy var dateSelectPanel: EditBizDateView = {
        let panel = EditBizDateView(withStyle: .Style2, withTitle: "营业时间")
        return panel
    }()
    
    lazy var contentTextView:BaseTextViewPanel = {
        let panel = BaseTextViewPanel(withStyle: .Style2, withTitle: "说明")
        return panel
    }()
    
    lazy var submitButton: UIButton = {
        let view = UIButton.createCornerButton("保存修改")
        view.addTarget(self, action: #selector(submitButtonClicked(sender:)), for: .touchUpInside)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        title = "周营业日"
        setupUI()
    }
    
    @objc func submitButtonClicked(sender: UIButton) {
        let workDate = dateSelectPanel.selectWeekDays.joined(separator: ",")
        let year = Date().string(format: "yyyy")
        let month = Date().string(format: "MM")
        API.xgyyzt(withParam: XgyyztParam(deptId: self.deptId ?? BSUser.currentUser.deptId, month: month, remark: contentTextView.textView.text, status: "1", type: "week", workDates: workDate, year: year)) { responseModel in
            Utils.app.window?.showToast(witMsg: "修改成功")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func setupUI() {
        view.addSubview(dateSelectPanel)
        view.addSubview(contentTextView)
        view.addSubview(submitButton)
        
        dateSelectPanel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
        }

        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(dateSelectPanel.snp.bottom).offset(10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
        }
        submitButton.snp.makeConstraints { make in
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.top.equalTo(contentTextView.snp.bottom).offset(20)
            make.height.equalTo(50)
            
        }
    }
    
}
