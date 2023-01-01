//
//  InspCreateContractorVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/22.
//
// 【首页-维保服务】新建巡检-选择巡检工程商

import Foundation
import UIKit

class InspContractorModal: NSObject {
    var id: String = ""
    var name: String = ""
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

class InspCreateContractorVC: SubLevelViewController {
    var modal: InspCreateModal!

    let tableView = UITableView(frame: .zero, style: .plain)

    let datas: [InspContractorModal] = [
        InspContractorModal(id: "1", name: "九安保安服务有限公司"),
        InspContractorModal(id: "2", name: "龙华保安服务有限公司"),
    ]
    
    init(withModal _modal: InspCreateModal) {
        super.init(nibName: nil, bundle: nil)
        self.modal = _modal
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "选择巡检工程商"
        view.backgroundColor = .bg
        navigationController?.navBarStyle(.white)
        setupUI()
        
        reloadData()
    }
    
    func reloadData() {
        API.getParCnameList(withParam: ParParam()) { responseModel in
            print("getParCnameList", responseModel)
            
            
        }
    }
    
    // MARK: - Setup
    
    func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension InspCreateContractorVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = datas[indexPath.row]
        let ID : String = "InspCreateContractorCell"
            
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = InspCreateContractorCell(style: .value1, reuseIdentifier: ID)
        }
        (cell as? InspCreateContractorCell)?.nameL.text = data.name
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = datas[indexPath.row]
        modal.contractor = data
        let vc = InspCreateVC(withModal: modal)
        navigationController?.pushViewController(vc, animated: true)
    }
}
