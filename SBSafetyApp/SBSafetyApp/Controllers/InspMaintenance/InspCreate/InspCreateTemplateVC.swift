//
//  InspCreateTemplateVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/22.
//
// 【首页-维保服务】新建巡检-选择巡检模板

import Foundation
import UIKit

class InspTemplateModal: NSObject {
    var id: Int = 0
    var icon: String = ""
    var name: String = ""
    
    init(id: Int, icon: String, name: String) {
        self.id = id
        self.icon = icon
        self.name = name
    }
}

class InspCreateTemplateVC: SubLevelViewController {
    var modal: InspCreateModal!

    let tableView = UITableView(frame: .zero, style: .plain)
    let label = PaddingLabel()

    let datas = [
        InspTemplateModal(id: 0, icon: "ic_temp_1", name: "离行机具区域联网报警及视频联动"),
        InspTemplateModal(id: 1, icon: "ic_temp_2", name: "离行机具视频监控及门禁系统"),
        InspTemplateModal(id: 2, icon: "ic_temp_3", name: "上海银行人防模块"),
        InspTemplateModal(id: 3, icon: "ic_temp_4", name: "视频监控系统巡检模板"),
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
        title = "选择巡检模板"
        view.backgroundColor = .bg
        navigationController?.navBarStyle(.white)
        setupUI()
        
        reloadData()
    }
    
    func reloadData() {
        
    }
    
    // MARK: - Setup
    
    func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .bg
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        label.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 65)
        label.text = modal.dept?.deptName
        label.font = .systemFont(ofSize: 17)
        label.insets = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        tableView.tableHeaderView = label
    }
}

extension InspCreateTemplateVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = datas[indexPath.row]
        let ID : String = "InspCreateTemplateCell"
            
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = InspCreateTemplateCell(style: .subtitle, reuseIdentifier: ID)
        }
        
        (cell as? InspCreateTemplateCell)?.reload(withModal: data)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = datas[indexPath.row]
        modal.template = data
        let vc = InspCreateContractorVC(withModal: modal)
        navigationController?.pushViewController(vc, animated: true)
    }
}
