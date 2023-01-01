//
//  LabelPickerPopView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/9.
//

import Foundation
import UIKit
import JFPopup

class LabelPickerPopView: UIView {
    let tableView = UITableView(frame: .zero, style: .grouped)

    var datas: [YjwxRestoreDictModal]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    open var didSelectItemWith:((_ index: Int, _ title: String) -> ())?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .white
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            if #available(iOS 15.0, *) {
                make.bottom.equalTo(self.keyboardLayoutGuide.snp.top)
            } else {
                // Fallback on earlier versions
                make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            }
        }
    }
}

extension LabelPickerPopView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = datas![indexPath.row]
        let ID : String = "LabelPickerPopView"
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil { cell = UITableViewCell(style: .default, reuseIdentifier: ID) }
        cell?.textLabel?.text = data.dictLabel
        cell?.textLabel?.font = .systemFont(ofSize: 15)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let modal = datas![indexPath.row]
        didSelectItemWith?(indexPath.row, modal.dictLabel!)
    }
}
