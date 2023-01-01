//
//  BranchSearchVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/29.
//

import Foundation
import UIKit

class BranchSearchVC: SubLevelViewController {
    let headerV = BSSearchButton(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 60))
    let tableView = UITableView(frame: .zero, style: .grouped)

    let resultV = BranchResultView()

    open var didSelectBranchWith:((_ modal: DeptModal) -> ())?

    var datas: [DeptModal] = []
    
    var sortDatas: [[DeptModal]] = []
    var indexs: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "选择网点"
        view.backgroundColor = .white
        navigationController?.navBarStyle(.white)
        setupUI()
        reloadData()
    }
    
    func reloadData() {
        view.showToastActivity()
        API.getDeptList { responseModel in
            self.sortDatas = self.sortAllDatas(responseModel.models ?? [])
            DispatchQueue.main.async {
                self.view.hideToastActivity()
                self.tableView.tableShowEmpty(withDataCount: self.sortDatas.count)
                self.tableView.reloadData()
            }
        }
    }

    func sortAllDatas(_ datas: [DeptModal?]) -> [[DeptModal]] {
        if datas.count == 0 { return [] }
        let s_datas = datas.sorted { modal1, modal2 in
            let i1 =  Utils.findFirstLetter(fromString: modal1!.deptName!)
            let i2 =  Utils.findFirstLetter(fromString: modal2!.deptName!)
            return i1 > i2
        }
        
        let letters = ["#","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        
        var sorts: [[DeptModal]] = []

        indexs.removeAll()

        for letter in letters {
            var sds: [DeptModal] = []
            for s_data in s_datas {
                let initials =  Utils.findFirstLetter(fromString: s_data!.deptName!)
                if letter == initials {
                    sds.append(s_data!)
                }
            }
            if sds.count > 0 {
                sorts.append(sds)
                indexs.append(letter)
            }
        }
        
        return sorts
    }
    
    @objc func showSearchTapped() {
        if resultV.superview == nil {
            view.addSubview(resultV)
            resultV.snp.makeConstraints { make in
                make.top.left.right.equalToSuperview()
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            }
            resultV.resetUI()
        }
    }
    
    @objc func cencelTFTapped() {
        if resultV.superview != nil {
            resultV.removeFromSuperview()
        }
    }
    
    func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        headerV.titleL.text = "搜索网点"
        headerV.padding = 25
        headerV.ctl.addTarget(self, action: #selector(showSearchTapped), for: .touchUpInside)
        tableView.tableHeaderView = headerV
        
        resultV.headerV.cancelBtn.addTarget(self, action: #selector(cencelTFTapped), for: .touchUpInside)
        resultV.didSelectBranchWith = didSelectBranchWith
    }
}

extension BranchSearchVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sortDatas.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortDatas[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = sortDatas[indexPath.section][indexPath.row]
        let ID : String = "BranchSearchCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil { cell = BranchSearchCell(style: .default, reuseIdentifier: ID) }
        (cell as? BranchSearchCell)?.reload(withModal: data)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let l = PaddingLabel()
        l.insets = UIEdgeInsets(top: 0, left: 26, bottom: 0, right: 26)
        l.font = .systemFont(ofSize: 16)
        l.textColor = .hex("#666666")
        l.backgroundColor = .white
        l.text = indexs[section]
        return l
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return indexs
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        let selectedIndex = IndexPath(row: 0, section: index)
        tableView.scrollToRow(at: selectedIndex, at: .bottom, animated: true)
        return index
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let modal = sortDatas[indexPath.section][indexPath.row]
        didSelectBranchWith?(modal)
    }
}
