//
//  FeedbackListView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/5.
//

import Foundation
import UIKit

class FeedbackListView: UIView {
    let tableView = UITableView(frame: .zero, style: .plain)
    
    let datas = [1,2,3, 1,2,3, 1,2,3]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.bottom.top.left.right.equalToSuperview()
        }
    }
}

extension FeedbackListView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let data = datas[indexPath.row]
        let ID : String = "FeedbackListCell"
            
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = FeedbackListCell(style: .subtitle, reuseIdentifier: ID)
        }
        
//        (cell as? MyRepairCell)?.reload(withModal: data)
//        (cell as? MyRepairCell)?.reviewsBtn.addTarget(self, action: #selector(reviewsTapped), for: .touchUpInside)
//        (cell as? MyRepairCell)?.evaluatedBtn.addTarget(self, action: #selector(evaluatedTapped), for: .touchUpInside)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let data = datas[indexPath.row]
        getFirstViewController()?.navigationController?.pushViewController(FeedbackDetailVC(), animated: true)
    }
}
