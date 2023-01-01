//
//  SecurityHomeVC.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/16.
//  保安管理-首页

import Foundation
import UIKit

class SecurityHomeVC: SubLevelViewController {

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()

    lazy var contentView: UIView = {
        return UIView()
    }()

    lazy var panelView: SecurityHomePanelView = {
        let panelView = SecurityHomePanelView(frame: .zero)
        panelView.delegate = self
        return panelView
    }()

    lazy var checkInTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.hex("#000000")
        label.text = "今日签到记录"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()

    lazy var checkInListView: CheckInListView = {
        let view = CheckInListView(frame: .zero)

        return view
    }()

    lazy var emptyView: SecurityHomeEmptyView = {
        let view = SecurityHomeEmptyView(imageNamed: "uncheck", text: "今日还未签到")
        return view
    }()

    lazy var checkButton: UIButton = {
        let button = UIButton.createCornerButton("去做任务")
        button.addTarget(self, action: #selector(checkIn(sender:)), for: .touchUpInside)
        return button
    }()

    var fakeData: [CheckInListModel] = [
        CheckInListModel(timeStr: "14:25", checkInStateStr: "签到", address: "上海市浦东新区东书房路629弄3号", subBranchStr: "上海银行总行"),
        CheckInListModel(timeStr: "14:25", checkInStateStr: "签到", address: "上海市浦东新区东书房路629弄3号", subBranchStr: "上海银行总行"),
        CheckInListModel(timeStr: "14:25", checkInStateStr: "签退", address: "上海市浦东新区东书房路629弄3号", subBranchStr: "上海银行总行"),
        CheckInListModel(timeStr: "14:25", checkInStateStr: "签到", address: "上海市浦东新区东书房路629弄3号", subBranchStr: "上海银行总行"),
        CheckInListModel(timeStr: "14:25", checkInStateStr: "签退", address: "上海市浦东新区东书房路629弄4号", subBranchStr: "上海银行总行"),
        CheckInListModel(timeStr: "14:25", checkInStateStr: "签到", address: "上海市浦东新区东书房路629弄3号", subBranchStr: "上海银行总行"),
        CheckInListModel(timeStr: "14:25", checkInStateStr: "签到", address: "上海市浦东新区东书房路629弄3号", subBranchStr: "上海银行总行"),
        CheckInListModel(timeStr: "14:25", checkInStateStr: "签到", address: "上海市浦东新区东书房路629弄6号", subBranchStr: "上海银行总行"),
        CheckInListModel(timeStr: "14:25", checkInStateStr: "签到", address: "上海市浦东新区东书房路629弄8号", subBranchStr: "上海银行总行"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "保安管理首页"
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    func setupUI() {
        view.backgroundColor = UIColor.hex("#F8F8F8")
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(panelView);
        contentView.addSubview(checkInTitleLabel)
        contentView.addSubview(checkInListView)
//        self.view.addSubview(emptyView)
        contentView.addSubview(checkButton)

        checkInListView.buildData(models: fakeData)

        scrollView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(view)
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(view)
        }

        panelView.snp.makeConstraints { make in
            make.top.equalTo(scrollView)
            make.left.equalTo(scrollView)
            make.right.equalTo(scrollView)
        }

        checkInTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(panelView.snp.bottom).offset(10)
            make.centerX.equalTo(scrollView)
        }

        checkInListView.snp.makeConstraints { make in
            make.left.equalTo(scrollView)
            make.right.equalTo(scrollView)
            make.top.equalTo(checkInTitleLabel.snp.bottom).offset(10)
        }

        checkButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(220)
            make.top.equalTo(checkInListView.snp.bottom).offset(15)
            make.centerX.equalTo(scrollView)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }

    @objc func checkIn(sender: UIButton) {
        navigationController?.pushViewController(FaceDetectVC(), animated: true)
    }

}

extension SecurityHomeVC: SecurityHomePanelTapDelegate {
    func taskItemTapped() {
        navigationController?.pushViewController(SecurityTaskListVC(), animated: true)
        print("taskItemTapped");
    }

    func checkInItemTapped() {
        print("checkInItemTapped");
    }

    func statisticsItemTapped() {
        print("statisticsItemTapped");
        navigationController?.pushViewController(AttendanceStatisticsVC(), animated: true)
    }
}
