//
//  SelectPopView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/8.
//

import Foundation
import UIKit
import JFPopup

class SelectPopModal: NSObject {
    var id: String?
    var name: String = ""
    
    init(id: String? = nil, name: String) {
        self.id = id
        self.name = name
    }
}

class SelectPopView: UIView {
    let headerV = BSSearchButton(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 60))
    let tableView = UITableView(frame: .zero, style: .grouped)

    var datas: [SelectPopModal]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    open var didSelectItemWith:((_ index: Int, _ item: SelectPopModal) -> ())?

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
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            if #available(iOS 15.0, *) {
                make.bottom.equalTo(self.keyboardLayoutGuide.snp.top)
            } else {
                // Fallback on earlier versions
                make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            }
        }
    }
}

extension SelectPopView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = datas![indexPath.row]
        let ID : String = "SelectPopView"
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil { cell = UITableViewCell(style: .default, reuseIdentifier: ID) }
        cell?.textLabel?.text = data.name
        cell?.textLabel?.font = .systemFont(ofSize: 15)

        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let modal = datas![indexPath.row]
        didSelectItemWith?(indexPath.row, modal)
    }
}
