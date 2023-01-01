//
//  ToBeConfirmedView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/27.
//

import Foundation
import UIKit

class ToBeConfirmedView: UIView {
    let segmentedC = ScrollableSegmentedControl()
    let tableView = UITableView(frame: .zero, style: .plain)

    let datas: [YjwxListModal] = [
//        YjwxListModal(id: 4, branch: "市政大厦支行", orderNum: "XJ135220215632131515", createAt: "2022-09-28 13:30:25", contractor: "上海华宇电子科技有限公司", engineer: "--", status: .toBeConfirmed),
//        YjwxListModal(id: 5, branch: "市政大厦支行", orderNum: "XJ135220215632131515", createAt: "2022-09-28 13:30:25", contractor: "上海华宇电子科技有限公司", engineer: "--", status: .toBeConfirmed),
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
        tableView.tableShowEmpty(withDataCount: datas.count)
        tableView.reloadData()
    }
    
    // MARK: - Actions
    @objc func segmentSelected(sender: ScrollableSegmentedControl) {
        print("segmentSelected", sender.selectedSegmentIndex)
//        let index = sender.selectedSegmentIndex
        
        reloadData()
    }
    
    // MARK: - Setup
    func setupUI() {
        segmentedC.tintColor = .primary
        segmentedC.underlineSelected = true
        segmentedC.segmentContentColor = .black
        segmentedC.selectedSegmentContentColor = .primary
        segmentedC.backgroundColor = .white
        segmentedC.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)
        let normalAttrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        let highlightAttrs =  [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        let selectAttrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        segmentedC.setTitleTextAttributes(normalAttrs, for: .normal)
        segmentedC.setTitleTextAttributes(highlightAttrs, for: .highlighted)
        segmentedC.setTitleTextAttributes(selectAttrs, for: .selected)
        addSubview(segmentedC)
        segmentedC.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top)
            make.left.right.centerX.equalToSuperview()
            make.height.equalTo(48)
        }
        
        segmentedC.insertSegment(withTitle: "责任网点", at: 0)
        segmentedC.insertSegment(withTitle: "关联网点", at: 1)
        segmentedC.selectedSegmentIndex = 0
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .bg
        tableView.delegate = self
        tableView.dataSource = self
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(segmentedC.snp.bottom)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        reloadData()
    }
}

extension ToBeConfirmedView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = datas[indexPath.row]
        let ID : String = "ToBeConfirmedCell"
            
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = MyRepairCell(style: .subtitle, reuseIdentifier: ID)
        }
        
        (cell as? MyRepairCell)?.reload(withModal: data)
        (cell as? MyRepairCell)?.toBeConfirmedBtn.addTarget(self, action: #selector(toBeConfirmedTapped), for: .touchUpInside)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 162
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let data = datas[indexPath.row]
//        let vc = RepairDetailVC(withModal: data)
//        getFirstViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func toBeConfirmedTapped(_ sender: RepairModalButton) {
        if sender.modal == nil { return }

        getFirstViewController()?.navigationController?.pushViewController(ToBeConfirmedDetailVC(withModal: sender.modal!), animated: true)
    }
}
