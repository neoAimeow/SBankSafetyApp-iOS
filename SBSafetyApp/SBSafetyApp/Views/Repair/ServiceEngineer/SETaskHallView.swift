//
//  SETaskHallView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/29.
//

import Foundation
import UIKit

class SETaskHallView: UIView, PullToRefreshPresentable {
    let tableView = UITableView(frame: .zero, style: .plain)
    var datas: [YjwxListModal?] = []
    
    var pageNum: Int64 = 1

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupPullToRefresh(on: tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        tableView.removeAllPullToRefresh()
    }
    
    func reloadAction() {
        pageNum = 1
        reloadData()
    }
    
    
    func loadAction() {
//        pageNum += 1
//        reloadData()
    }
    
    // 报修单列表
    func reloadData() {
//        if pageNum == 1 {
//            datas.removeAll()
//            tableView.reloadData()
//        }
//        showToastActivity()
        // 报修单列表
        API.getYjwxGetList(withParam: YjwxListParam(ddzt: 0, pageSize: PageSize, pageNum: pageNum)) { responseModel in
            DispatchQueue.main.async {
                if self.pageNum > 1 && (responseModel.models == nil || responseModel.models?.count == 0) {
                    self.pageNum -= 1
                    return
                }
                if self.pageNum == 1 {
                    self.datas.removeAll()
                }
//                self.hideToastActivity()
                self.datas.append(contentsOf: responseModel.models ?? [])
                self.tableView.tableShowEmpty(withDataCount: self.datas.count)
                self.tableView.reloadData()
            }
        }
    }
    // MARK: - Setup
    
    func setupUI() {
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .bg
        tableView.delegate = self
        tableView.dataSource = self
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
}

extension SETaskHallView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = datas[indexPath.row]
        let ID : String = "SETaskHallCell"
            
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = SETaskHallCell(style: .default, reuseIdentifier: ID)
        }
        
        (cell as? SETaskHallCell)?.reload(withModal: data!)
        (cell as? SETaskHallCell)?.acceptBtn.addTarget(self, action: #selector(acceptTapped), for: .touchUpInside)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = datas[indexPath.row]
        let ID : String = "SETaskHallCell"
            
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = SETaskHallCell(style: .default, reuseIdentifier: ID)
        }
        return (cell as? SETaskHallCell)?.cellHeight(withModal: data!) ?? 186
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = datas[indexPath.row]
        let vc = RepairDetailVC(withModal: data!)
        getFirstViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
    
    // 接单
    @objc func acceptTapped(_ sender: RepairModalButton) {
        showToastActivity()
        API.postYjwxEngineerOrderTaking(withParam: YjwxParam(id: sender.modal?.id)) { responseModel in
            DispatchQueue.main.async {
                self.hideToastActivity()
                if responseModel.errorCode == .Success {
                    self.showToast(witMsg: responseModel.errorMessage)
                    self.reloadData()
                }
            }
        }
    }
}
