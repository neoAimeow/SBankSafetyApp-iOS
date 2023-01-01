//
//  RepairReportTimeDetailVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/28.
//
// 【首页-一键报修】一键报修-统计详情

import Foundation
import UIKit

class RRTimeDetailModal: NSObject {
    var branch: String = ""
    var orderNum: String = ""
    var date: String = ""

    init(branch: String, orderNum: String, date: String) {
        self.branch = branch
        self.orderNum = orderNum
        self.date = date
    }
}

class RepairReportTimeDetailVC: SubLevelViewController {
    let tableView = UITableView(frame: .zero, style: .plain)
    
    let datas = [
        RRTimeDetailModal(branch: "上海银行-浦西分行-徐汇支行-百丽国际广场ATM （18004470）", orderNum: "XJ53202207280002", date: "1小时25分钟"),
        RRTimeDetailModal(branch: "上海银行-市南分行-青浦支行-徐泾支行", orderNum: "XJ53202207280002", date: "37分钟"),
        RRTimeDetailModal(branch: "上海银行-总行营业部-浦西支行", orderNum: "XJ53202207280002", date: "37分钟"),
        RRTimeDetailModal(branch: "上海银行-市南分行-青浦支行-华新支行", orderNum: "XJ53202207280002", date: "37分钟"),
        RRTimeDetailModal(branch: "上海银行-总行营业部-白玉支行-市政大厦支行", orderNum: "XJ53202207280002", date: "37分钟"),
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "报修响应统计"
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
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 55))
        header.backgroundColor = .hex("#F8F8F8")
        
        let titleL = UILabel()
        titleL.text = "九安保安服务有限公司"
        titleL.font = .systemFont(ofSize: 17)
        header.addSubview(titleL)
        titleL.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
        
        let dateL = UILabel()
        dateL.text = "2022年11月"
        dateL.font = .systemFont(ofSize: 17)
        header.addSubview(dateL)
        dateL.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
        }
        
        tableView.tableHeaderView = header
    }
}
extension RepairReportTimeDetailVC: UITableViewDataSource, UITableViewDelegate {
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
        
        (cell as? InspQualityStatisticsCell)?.reload(withTimeModal: data)

        return cell!
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}

