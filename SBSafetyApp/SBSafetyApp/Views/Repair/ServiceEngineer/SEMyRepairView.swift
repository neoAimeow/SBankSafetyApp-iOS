//
//  SEMyRepairView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/29.
//

import Foundation
import UIKit

class SEMyRepairView: UIView, PullToRefreshPresentable {
    let tableView = UITableView(frame: .zero, style: .plain)
    let summaryV = RepairSummaryView()

    var datas: [YjwxListModal?] = []
    
    var pageNum: Int64 = 1

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupPullToRefresh(on: tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        tableView.removeAllPullToRefresh()
    }
    
    func reloadAction() {
        pageNum = 1
        getList()
    }
    
    
    func loadAction() {
//        pageNum += 1
//        getList()
    }
    
    func reloadData() {
        // 获取报修单完成数
        API.getYjwxGetListTotal { responseModel in
            DispatchQueue.main.async {
                self.summaryV.update(withData: responseModel.model)
            }
        }
        
        // 报修单列表
        getList()
    }
    
    // 报修单列表
    func getList() {
        // 报修单列表
        API.getYjwxGetList(withParam: YjwxListParam(pageSize: PageSize, pageNum: pageNum)) { responseModel in
            DispatchQueue.main.async {
                if self.pageNum > 1 && (responseModel.models == nil || responseModel.models?.count == 0) {
                    self.pageNum -= 1
                    return
                }
                if self.pageNum == 1 {
                    self.datas.removeAll()
                }
                self.datas.append(contentsOf: responseModel.models ?? [])
                self.tableView.tableShowEmpty(withDataCount: self.datas.count)
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Setup
    
    func setupUI() {
        addSubview(summaryV)
        summaryV.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(54)
        }

        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .bg
        tableView.delegate = self
        tableView.dataSource = self
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(summaryV.snp.bottom).offset(5)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
}

extension SEMyRepairView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = datas[indexPath.row]
        let ID : String = "SEMyTaskCell"
            
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = SETaskHallCell(style: .default, reuseIdentifier: ID)
        }
        
        (cell as? SETaskHallCell)?.reload(withModal: data!)
        (cell as? SETaskHallCell)?.confirmedArrivalBtn.addTarget(self, action: #selector(confirmedArrivalTapped), for: .touchUpInside)
        (cell as? SETaskHallCell)?.startRepairBtn.addTarget(self, action: #selector(startRepairTapped), for: .touchUpInside)
//        (cell as? SETaskHallCell)?.confirmFixBtn.addTarget(self, action: #selector(confirmFixTapped), for: .touchUpInside)
        (cell as? SETaskHallCell)?.reviewsBtn.addTarget(self, action: #selector(reviewsTapped), for: .touchUpInside)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = datas[indexPath.row]

        let ID : String = "SEMyTaskCell"
            
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = SETaskHallCell(style: .subtitle, reuseIdentifier: ID)
        }
        
        return (cell as? SETaskHallCell)?.cellHeight(withModal: data!) ?? 186
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = datas[indexPath.row]
        let vc = RepairDetailVC(withModal: data!)
        getFirstViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
    
    // 确认到达
    @objc func confirmedArrivalTapped(_ sender: RepairModalButton) {
        let param = YjwxParam(id: sender.modal?.id)
        let fdvc = FaceDetectVC()
        fdvc.didSelectImageWith = { (img) -> () in
            fdvc.navigationController?.popViewController(animated: true)
            
            param.baseRl = img.imgToBase64()
            self.didArrivaLoc(withParam: param)
        }
        
        getFirstViewController()?.navigationController?.pushViewController(fdvc, animated: true)
    }
    
    
    func didArrivaLoc(withParam param: YjwxParam) {
        LocManager.shared.didSelectLocWith = { (longitude, latitude) -> () in
            print("Selected longitude: \(longitude) at latitude: \(latitude)")
            param.longitude = longitude
            param.latitude = latitude
            self.showToastActivity()

            API.postYjwxEngineerArrive(withParam: param) { responseModel in
                DispatchQueue.main.async {
                    self.hideToastActivity()
                    if responseModel.errorCode == .Success {
                        self.showToast(witMsg: responseModel.errorMessage)
                        Utils.delay(second: 1) { self.reloadData() }
                    }
                }
            }
        }
        LocManager.shared.startLoaction()
    }
    
    
    // 开始修复
    @objc func startRepairTapped(_ sender: RepairModalButton) {
        if sender.modal == nil { return }
        getFirstViewController()?.navigationController?.pushViewController(SECreateRestoreVC(withModal: sender.modal!), animated: true)
    }
//
//    // 确认修复
//    @objc func confirmFixTapped(_ sender: RepairModalButton) {
//        if sender.modal == nil { return }
//        getFirstViewController()?.navigationController?.pushViewController(ToBeConfirmedDetailVC(withModal: sender.modal!), animated: true)
//    }
    
    // 查看评价
    @objc func reviewsTapped(_ sender: RepairModalButton) {
        if sender.modal == nil { return }
        getFirstViewController()?.navigationController?.pushViewController(MyReviewsVC(withModal: sender.modal!), animated: true)
    }
}
