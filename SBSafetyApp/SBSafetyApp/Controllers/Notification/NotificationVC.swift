//
//  NotificationVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/5.
//
// 【首页-通知】通知列表

import Foundation
import UIKit

class NotificationVC: SubLevelViewController {
    let tableView = UITableView(frame: .zero, style: .plain)
    
    let datas = [1,2,3, 1,2,3, 1,2,3]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        title = "通知列表"
        
        setupUI()
        
        reloadData()
    }
    
    func reloadData() {

    }
    
    // MARK: - Setup
    
    func setupUI() {
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension NotificationVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = datas[indexPath.row]
        let ID : String = "NotificationCell"
            
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = NotificationCell(style: .subtitle, reuseIdentifier: ID)
        }
        
        (cell as? NotificationCell)?.reload(withModal: data)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 99
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(NotiDetailVC(), animated: true)
    }
    
}
