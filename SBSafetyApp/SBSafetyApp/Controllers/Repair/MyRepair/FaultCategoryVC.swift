//
//  FaultCategoryVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/27.
//
// 【首页-一键报修】一键报修-选择故障

import Foundation
import UIKit

class FaultCategoryModal: NSObject {
    var name: String = ""
    
    init(name: String) {
        self.name = name
    }
}

class FaultCategoryVC: SubLevelViewController {
    let headerV = BSSearchButton(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 60))
    let tableView = UITableView(frame: .zero, style: .plain)
    let submitBtn = UIButton.createPrimaryLarge("提交")

    var currentModal: YjwxGzModal?

    open var didSelectModalWith:((_ modal: YjwxGzModal?, _ tswb: String?) -> ())?

    var tswb: String?
    var datas: [YjwxGzModal?]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "选择故障"
        view.backgroundColor = .white
        setupUI()
        
        reloadData()
    }
    
    
    func reloadData() {
        let param = YjwxParam()
        param.deptId = deptId
        API.getYjwxGetGzList(withParam: param) { responseModel in
            DispatchQueue.main.async {
                self.datas = responseModel.model?.data
                self.tswb = responseModel.model?.tswb
                self.view.hideToastActivity()
                self.tableView.tableShowEmpty(withDataCount: self.datas?.count ?? 0)
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func confirmTapped() {
        super.backToPrevious()
        didSelectModalWith?(currentModal, tswb)
    }
    
    func setupUI() {
        headerV.titleL.text = "请搜索故障"
        
        submitBtn.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)
        submitBtn.setTitle("确定并提交", for: .normal)
        view.addSubview(submitBtn)
        submitBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.left.equalTo(view.snp.left).offset(14)
            make.right.equalTo(view.snp.right).offset(-14)
            make.height.equalTo(50)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(submitBtn.snp.top)
        }
        
        tableView.tableHeaderView = headerV
    }
}

extension FaultCategoryVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = datas?[indexPath.row]
        let ID : String = "FaultCategoryCell"
            
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = FaultCategoryCell(style: .subtitle, reuseIdentifier: ID)
        }
        
        (cell as? FaultCategoryCell)?.reload(withModal: data!, cur: currentModal)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let modal = datas?[indexPath.row]
        currentModal = modal
        tableView.reloadData()
    }
}
