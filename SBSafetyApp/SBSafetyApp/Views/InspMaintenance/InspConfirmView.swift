//
//  InspConfirmView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/22.
//

import Foundation
import UIKit

class InspConfirmView: UIView {
    let segmentedC = ScrollableSegmentedControl()
    let tableView = UITableView(frame: .zero, style: .plain)
    
    var datas: [ParListModal?] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
        datas.removeAll()
        
        if segmentedC.selectedSegmentIndex == 0 {
            showToastActivity()
            API.getParZrwd(withParam: ParZrwdParam()) { responseModel in
                print("getParZrwd", responseModel)
                
                self.hideToastActivity()
            }
            
        } else if segmentedC.selectedSegmentIndex == 1 {
            
        }
        
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
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .bg
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(segmentedC.snp.bottom)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
}

extension InspConfirmView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = datas[indexPath.row]
        let ID : String = "InspConfirmCell"
            
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = InspConfirmCell(style: .default, reuseIdentifier: ID)
        }
        
        (cell as? InspConfirmCell)?.reload(withModal: data)
        return cell!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 162
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
