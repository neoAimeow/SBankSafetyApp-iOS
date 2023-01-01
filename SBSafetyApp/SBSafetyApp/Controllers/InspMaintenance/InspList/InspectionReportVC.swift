//
//  InspectionReportVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/24.
//

import Foundation
import UIKit

class InspectionReportVC: SubLevelViewController {

    let reportV = InspectionReportView()
    
    var month = Calendar.current.component(.month, from: Date())
    var year = Calendar.current.component(.year, from: Date())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .hex("#3C72FF")
        setupNavItems()
        setupUI()
        
        reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navBarStyle(.custom, bg: "#3C72FF")
    }
    
    func reloadData() {
        let cretime = "\(year)-\(month < 10 ? "0\(month)" : "\(month)")-01"

        /// 报表1-网点巡检状况统计
        API.getCountStutasCount(withParam: CountParam(deptId: deptId, cretime: cretime, tmplValue: wbtype)) { responseModel in
            DispatchQueue.main.async {
                self.reportV.staticBase1.reloadUI(withData: responseModel.models ?? [])
            }
        }

        /// 报表2-单项巡检结果
        API.getCountItemCount(withParam: CountParam(deptId: deptId, cretime: cretime, tmplValue: wbtype)) { responseModel in
            print("getCountItemCount", responseModel.resultData as Any)
            DispatchQueue.main.async {
                self.reportV.staticBase2.reloadUI(withData: responseModel.model)
            }
        }
        
        /// 报表3-获取报修前五项
        API.getCountTopfiveList(withParam: CountParam(deptId: deptId, cretime: cretime, tmplValue: wbtype)) { responseModel in
            print("getCountTopfiveList", responseModel.resultData as Any)
            DispatchQueue.main.async {
                self.reportV.staticBase3.reloadUI(withData: responseModel.models ?? [])
            }
        }
    }
    
    // MARK: - Actions
    
    @objc func shareTapped() {
        
    }
    
    @objc func dateTapped() {
        self.popup.bottomSheet(bgColor: .black.withAlphaComponent(0.65)) {
            let v = CornerView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 386))
            v.corners = SBRectCorner(topLeft: 12, topRight: 12, bottomLeft: 0, bottomRight: 0)
            v.backgroundColor = .white
            let rPopV = MonthPickupPopView()
            rPopV.picker.date = Calendar.current.date(from: DateComponents(year: year, month: month))!
            rPopV.delegate = self
            v.addSubview(rPopV)
            rPopV.snp.makeConstraints { (make) -> Void in
                make.top.right.left.bottom.equalToSuperview()
            }
            return v
        }
    }
    
    // MARK: - Setup
    func setupUI() {
        reportV.dateBtn.setTitle("\(year)年\(month)月", for: .normal)
        reportV.dateBtn.addTarget(self, action: #selector(dateTapped), for: .touchUpInside)
        view.addSubview(reportV)
        reportV.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.width.equalTo(ScreenWidth)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func setupNavItems() {
        backBtn.setImage(UIImage(systemName: "xmark"), for: .normal)
        backBtn.tintColor = .white
        
        let settingBtn = UIButton(type: .custom)
        settingBtn.setImage(UIImage(named: "ic_share"), for: .normal)
        settingBtn.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        let settingBar = UIBarButtonItem(customView: settingBtn)
        navigationItem.rightBarButtonItems = [settingBar]
        
    }
}

extension InspectionReportVC: MonthPickupPopViewDelegate {
    func handleConfirm(_ picker: BSDatePicker) {
        year = Calendar.current.component(.year, from: picker.selectedDateComponent.date!)
        month = Calendar.current.component(.month, from: picker.selectedDateComponent.date!)
        reportV.dateBtn.setTitle("\(year)年\(month)月", for: .normal)
        reloadData()
    }
    
    func handleClose(_ picker: BSDatePicker) {
        
    }
}
