//
//  ConfirmRepairDetailVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/27.
//
// 【首页-一键报修】确认修复详情

import Foundation
import UIKit

class ConfirmRepairDetailVC: SubLevelViewController {
    let detailV = ConfirmRepairDetailView()

    var modal: YjwxListModal!

    init(withModal _modal: YjwxListModal) {
        super.init(nibName: nil, bundle: nil)
        self.modal = _modal
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "确认修复详情"
        view.backgroundColor = .bg
        setupUI()
        
        reloadData()
    }
    
    func reloadData() {
        detailV.updateUI(withModal: modal)
        
        view.showToastActivity()

        // 网点工作人员确认详情
        API.getYjwxBranchStaffConfirmDetail(withParam: YjwxParam(id: modal.id)) { responseModel in
            DispatchQueue.main.async {
                self.view.hideToastActivity()
                self.detailV.updateUI(withRestore: responseModel.model?.restore)
            }
        }
    }
    
    // MARK: - Setup
    
    func setupUI() {
        view.addSubview(detailV)

        detailV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.width.equalTo(ScreenWidth)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
