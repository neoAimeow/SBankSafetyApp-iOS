//
//  SEHomeView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/8.
//

import Foundation
import UIKit

class SEHomeView: UIView {
    let tableView = UITableView(frame: .zero, style: .grouped)
    let headerV = SEHomeHeaderView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 490))

    var datas : [ParListModal?] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
        /// 维保服务-巡检记录
        API.getParFromList(withParam: ParFormParam()) { responseModel in
            self.datas = responseModel.models ?? []
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }        
    }
   
    func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .bg
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(-UIDevice.navigationFullHeight())
        }
        tableView.tableHeaderView = headerV
    }
}

extension SEHomeView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = datas[indexPath.row]
        let ID : String = "InspListCell"
            
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = InspListCell(style: .subtitle, reuseIdentifier: ID)
        }
        
        (cell as? InspListCell)?.reload(withModal: data)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 162
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let data = datas[indexPath.row]
//        let vc = InspListDetailVC(withModal: data!)
//        navigationController?.pushViewController(vc, animated: true)
    }
}
