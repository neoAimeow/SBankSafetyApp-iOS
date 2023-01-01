//
//  InspQualityStatisticsVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/24.
//
// 【首页-维保服务】巡检质量统计

import Foundation
import UIKit

class InspQualitySModal: NSObject {
    var branch: String = ""
    var orderNum: String = ""
    var name: String = ""

    init(branch: String, orderNum: String, name: String) {
        self.branch = branch
        self.orderNum = orderNum
        self.name = name
    }
}

class InspQualityStatisticsVC: SubLevelViewController {
    let tableView = UITableView(frame: .zero, style: .plain)
    
    let datas = [
        InspQualitySModal(branch: "上海银行-浦西分行-徐汇支行-百丽国际广场ATM （18004470）", orderNum: "XJ53202207280002", name: "张三"),
        InspQualitySModal(branch: "上海银行-市南分行-青浦支行-徐泾支行", orderNum: "XJ53202207280002", name: "金松"),
        InspQualitySModal(branch: "上海银行-总行营业部-浦西支行", orderNum: "XJ53202207280002", name: "杨家豪"),
        InspQualitySModal(branch: "上海银行-市南分行-青浦支行-华新支行", orderNum: "XJ53202207280002", name: "金松"),
        InspQualitySModal(branch: "上海银行-总行营业部-白玉支行-市政大厦支行", orderNum: "XJ53202207280002", name: "杨家豪"),
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "巡检质量统计"
        view.backgroundColor = .white
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navBarStyle(.white)
    }
    
    func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
}
extension InspQualityStatisticsVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = datas[indexPath.row]
        let ID : String = "InspQualityStatisticsCell"
            
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = InspQualityStatisticsCell(style: .value1, reuseIdentifier: ID)
        }
        
        (cell as? InspQualityStatisticsCell)?.reload(withModal: data)

        return cell!
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}

