//
//  MonthAnomaliesVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/22.
//
// 【首页-履职管理】巡检报告-当月异常

import Foundation
import UIKit

class MonthAnomaliesVC: SubLevelViewController {
    let segmentedC = ScrollableSegmentedControl()
    let tableView = UITableView(frame: .zero, style: .plain)

    let datas = [1, 2, 3]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "当月异常"
        view.backgroundColor = .bg
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navBarStyle(.white)
    }
    
    func reloadData() {
        tableView.tableShowEmpty(withDataCount: datas.count)
        tableView.reloadData()
    }
    
    // MARK: - Actions
    @objc func segmentSelected(sender: ScrollableSegmentedControl) {
        print("segmentSelected", sender.selectedSegmentIndex)
//        let index = sender.selectedSegmentIndex
    }
        
    // MARK: - Setup
    
    func setupUI() {
        segmentedC.tintColor = .primary
        segmentedC.underlineSelected = true
        segmentedC.segmentContentColor = .black
        segmentedC.selectedSegmentContentColor = .primary
        segmentedC.backgroundColor = .bg
        segmentedC.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)
        let normalAttrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        let highlightAttrs =  [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        let selectAttrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        segmentedC.setTitleTextAttributes(normalAttrs, for: .normal)
        segmentedC.setTitleTextAttributes(highlightAttrs, for: .highlighted)
        segmentedC.setTitleTextAttributes(selectAttrs, for: .selected)
        view.addSubview(segmentedC)
        segmentedC.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.centerX.equalToSuperview()
            make.height.equalTo(48)
        }
        
        segmentedC.insertSegment(withTitle: "未整改 (1)", at: 0)
        segmentedC.insertSegment(withTitle: "已整改 (0)", at: 1)
        segmentedC.selectedSegmentIndex = 0
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(segmentedC.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension MonthAnomaliesVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = datas[indexPath.row]
        let ID : String = "MonthAnomaliesCell"
            
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = MonthAnomaliesCell(style: .subtitle, reuseIdentifier: ID)
        }
        
        (cell as? MonthAnomaliesCell)?.reload(withData: data)
        return cell!
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

