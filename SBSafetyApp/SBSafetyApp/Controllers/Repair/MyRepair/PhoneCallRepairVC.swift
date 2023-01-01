////
////  PhoneCallRepairVC.swift
////  SBSafetyApp
////
////  Created by Lina on 2022/11/25.
////
//// 【首页-一键报修】电话报修
//
//import Foundation
//import UIKit
//
//class PhoneCallRepairVC: SubLevelViewController {
//    let tableView = UITableView(frame: .zero, style: .plain)
//
//    var datas: [YjwxDhbxModal?] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        title = "服务商"
//        view.backgroundColor = .bg
//        setupUI()
//        reloadData()
//    }
//
//    func reloadData() {
//        /// 电话报修
//        view.showToastActivity()
//        API.getYjwxGetDhbxList { responseModel in
//            self.datas = responseModel.models ?? []
//            DispatchQueue.main.async {
//                self.view.hideToastActivity()
//                self.tableView.tableShowEmpty(withDataCount: self.datas.count)
//                self.tableView.reloadData()
//            }
//        }
//    }
//
//    // MARK: - Setup
//
//    func setupUI() {
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.separatorStyle = .none
//        tableView.showsVerticalScrollIndicator = false
//        tableView.backgroundColor = .bg
//        view.addSubview(tableView)
//        tableView.snp.makeConstraints { (make) in
//            make.left.right.equalToSuperview()
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
//            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
//        }
//    }
//}
//
//extension PhoneCallRepairVC: UITableViewDataSource, UITableViewDelegate {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return datas.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let data = datas[indexPath.row]
//        let ID : String = "PhoneCallRepairCell"
//
//        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
//        if cell == nil {
//            cell = PhoneCallRepairCell(style: .subtitle, reuseIdentifier: ID)
//        }
//
//        (cell as? PhoneCallRepairCell)?.reload(withModal: data, isLast: indexPath.row == datas.count - 1)
//        return cell!
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 75
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let data = datas[indexPath.row]
//
//        UIApplication.shared.open(URL(string: "tel://\(data?.gcsfzrlxdh ?? "")")!)
//    }
//}
//
