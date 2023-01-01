//
//  SafeCheckPersonVC.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/19.
//
// https://pic5.58cdn.com.cn/nowater/webim/big/n_v2a3df492a92064f878dacd7b5b0eefe30.png

import Foundation
import UIKit

class SafeCheckPersonVC: SubLevelViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.register(BaseInfoCell.self, forCellReuseIdentifier: "SafeCheckNormalCell")
        tableView.register(BaseInfoDescCell.self, forCellReuseIdentifier: "SafeCheckStyle1Cell")
        return tableView
    }()

    var fakeData: [BaseInfoModel] = [
        BaseInfoModel(style: BaseInfoStyleEnum.Normal, title: "履职人", detail: "陈明"),
        BaseInfoModel(style: BaseInfoStyleEnum.Normal, title: "任务时间", detail: "2022-09-26 06:00~22:00"),
        BaseInfoModel(style: BaseInfoStyleEnum.Normal, title: "完成时间", detail: "张启山、韩冬梅"),
        BaseInfoModel(style: BaseInfoStyleEnum.Normal, title: "耗时", detail: "00小时01分01秒"),
    ]

    var fakeData2: [BaseInfoDescModel] = [
        BaseInfoDescModel(style: BaseInfoDescStyleEnum.Normal, title: "录像保存是否完整", detail: "陈明 2022-09-26 10:10:42"),
        BaseInfoDescModel(style: BaseInfoDescStyleEnum.Normal, title: "是否未被安装盗码装置", detail: "陈明 2022-09-26 10:10:42"),
        BaseInfoDescModel(style: BaseInfoDescStyleEnum.Normal, title: "是否未见不明张贴物", detail: "陈明 2022-09-26 10:10:42"),
        BaseInfoDescModel(style: BaseInfoDescStyleEnum.Normal, title: "求助对讲按钮是否正常", detail: "陈明 2022-09-26 10:10:42"),
        BaseInfoDescModel(style: BaseInfoDescStyleEnum.Normal, title: "语音安全提示是否正常", detail: "陈明 2022-09-26 10:10:42"),
        BaseInfoDescModel(style: BaseInfoDescStyleEnum.Normal, title: "自助银行远程落锁是否正常", detail: "陈明 2022-09-26 10:10:42"),
    ]

    var fakeData3: [BaseInfoDescModel] = [
        BaseInfoDescModel(style: BaseInfoDescStyleEnum.Normal, title: "LED屏、灯箱是否正常", detail: "陈明 2022-09-26 10:10:42"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "营业期间安全检查-保安员"

        setupUI()
    }

    // MARK: - Setup

    func setupUI() {
        let rightBtn = UIBarButtonItem.init(title: "查看签名", style: .done, target: self, action: #selector(titleBarButtonItemMethod))
        rightBtn.tintColor = UIColor.hex("#306EC8")
        self.navigationItem.rightBarButtonItem = rightBtn

        view.backgroundColor = .hex("#F8F8F8")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view).offset(-10)
        }
    }

    @objc func titleBarButtonItemMethod() {
        navigationController?.pushViewController(SignDisplayVC(), animated: true)
    }
}

extension SafeCheckPersonVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return fakeData.count
        } else if (section == 1) {
            return fakeData2.count
        } else {
            return fakeData3.count
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 1
        } else {
            return 50
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (section == 1) {
            let view = SectionTitleView(withStyle: SectionTitleStyleEnum.Style1, title: "自助机具")
            return view
        } else if (section == 2) {
            let view = SectionTitleView(withStyle: SectionTitleStyleEnum.Style1, title: "营业大厅")
            return view
        } else {
            let view = UIView()
            view.backgroundColor = .clear
            return view
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let data = fakeData[indexPath.row]
            let cell = (tableView.dequeueReusableCell(withIdentifier: "SafeCheckNormalCell", for: indexPath)) as! BaseInfoCell
//            cell.buildData(model: data, isHighlight: true)
            cell.selectionStyle = .none
            return cell
        } else if (indexPath.section == 1) {
            let data = fakeData2[indexPath.row]
            let cell = (tableView.dequeueReusableCell(withIdentifier: "SafeCheckStyle1Cell", for: indexPath)) as! BaseInfoDescCell
//            cell.buildData(model: data, isHighlight: true)
            cell.selectionStyle = .none
            return cell
        } else {
            let data = fakeData3[indexPath.row]
            let cell = (tableView.dequeueReusableCell(withIdentifier: "SafeCheckStyle1Cell", for: indexPath)) as! BaseInfoDescCell
//            cell.buildData(model: data, isHighlight: false)
            cell.selectionStyle = .none
            return cell
        }
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return 50
        } else {
            return 64
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            self.navigationController?.pushViewController(SafeCheckoutMachinesVC(), animated: true)
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        tableView.setCornerRadiusSection(willDisplay: cell, forRowAt: indexPath)
    }
}
