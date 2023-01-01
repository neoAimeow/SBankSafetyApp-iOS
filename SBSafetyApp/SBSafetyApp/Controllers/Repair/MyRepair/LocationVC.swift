//
//  LocationVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/28.
//
// 【首页-一键报修】一键报修-选择位置信息

import Foundation
import UIKit

class LocationVC: SubLevelViewController {
    let tableView = UITableView(frame: .zero, style: .grouped)
    let allTableView = UITableView(frame: .zero, style: .grouped)

    open var didSelectLocWith:((_ loc: String?) -> ())?

    var datas: [YjwxFswzModal?] = []
    var allDatas: [YjwxFswzModal?] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "位置信息"
        view.backgroundColor = .white
        
        setupUI()
        
        reloadData()
    }
    
    func reloadData() {
        view.showToastActivity()
        API.getYjwxGetFswzList { responseModel in
            self.datas = responseModel.models ?? []
            self.allDatas = responseModel.models ?? []
            DispatchQueue.main.async {
                self.view.hideToastActivity()
                self.tableView.tableShowEmpty(withDataCount: self.datas.count)
                self.tableView.reloadData()
                self.allTableView.tableShowEmpty(withDataCount: self.allDatas.count)
                self.allTableView.reloadData()
            }
        }
    }
    
    func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .bg
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.width.equalTo(136)
        }
        
        allTableView.dataSource = self
        allTableView.delegate = self
        allTableView.separatorStyle = .none
        allTableView.showsVerticalScrollIndicator = false
        allTableView.backgroundColor = .white
        view.addSubview(allTableView)
        allTableView.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.left.equalTo(tableView.snp.right)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension LocationVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        if allTableView == tableView {
            return allDatas.count
        }
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if allTableView == tableView {
            return allDatas[section]?.child?.count ?? 0
        }
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if allTableView == tableView {
            let modal = allDatas[section]

            let label = PaddingLabel()
            label.insets = UIEdgeInsets(top: 0, left: 11, bottom: 0, right: 11)
            label.text = modal?.name
            label.backgroundColor = .hex("#F8F8F8")
            label.textColor = .hex("#0A0A0A")
            label.font = UIFont.systemFont(ofSize: 16)
            return label
        }
        return nil
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if allTableView == tableView {
            let data = allDatas[indexPath.section]?.child?[indexPath.row]
            let ID : String = "LocationSubCell"
                
            var cell = tableView.dequeueReusableCell(withIdentifier: ID)
            if cell == nil {
                cell = LocationSubCell(style: .subtitle, reuseIdentifier: ID)
            }
            
            (cell as? LocationSubCell)?.textLabel?.text = data?.name
            return cell!
        }
        
        let data = datas[indexPath.row]
        let ID : String = "LocationCell"
            
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = LocationCell(style: .subtitle, reuseIdentifier: ID)
        }
        
        (cell as? LocationCell)?.textLabel?.text = data?.name
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 36
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if allTableView == tableView {
            return 36
        }
        return 0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if allTableView == tableView {
            let modal = allDatas[indexPath.section]?.child?[indexPath.row]
            navigationController?.popViewController(animated: true)
            didSelectLocWith?(modal?.name ?? "")
            return
        }
        
        allTableView.scrollToRow(at: IndexPath(row: 0, section: indexPath.row), at: .top, animated: true)
    }
}
