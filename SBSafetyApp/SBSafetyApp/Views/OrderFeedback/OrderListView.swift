//
//  OrderListView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/5.
//

import Foundation
import UIKit

class OrderListView: UIView {
    let submitBtn = UIButton.createPrimaryLarge("新建工单")

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
        addSubview(submitBtn)
        submitBtn.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(50)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(ScreenWidth - 20)
            make.bottom.equalTo(self.snp.bottom).offset(-20)
        }
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(submitBtn.snp.top)
        }
    }
}

extension OrderListView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let data = datas[indexPath.row]
        let ID : String = "OrderListCell"
            
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = OrderListCell(style: .subtitle, reuseIdentifier: ID)
        }
        
//        (cell as? MyRepairCell)?.reload(withModal: data)
//        (cell as? MyRepairCell)?.reviewsBtn.addTarget(self, action: #selector(reviewsTapped), for: .touchUpInside)
//        (cell as? MyRepairCell)?.evaluatedBtn.addTarget(self, action: #selector(evaluatedTapped), for: .touchUpInside)
        return cell!
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 152
//    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 162
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
}
