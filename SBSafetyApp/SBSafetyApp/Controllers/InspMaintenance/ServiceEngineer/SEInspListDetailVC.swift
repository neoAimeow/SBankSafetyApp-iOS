//
//  SEInspListDetailVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/11.
//
// 【首页-维保服务】维修工程师-巡检明细

import Foundation
import UIKit

class SEInspListDetailVC: SubLevelViewController {
    let detailV = SEInspListDetailView()
    
    var modal: ParListModal!

    init(withModal _modal: ParListModal) {
        super.init(nibName: nil, bundle: nil)
        self.modal = _modal
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "巡检明细"
        view.backgroundColor = .bg
        setupUI()
        reloadData()
    }
    
    func reloadData() {
        detailV.updateUI(withModal: modal)

        view.showToastActivity()
        API.getParResult(withParam: ParParam(fromId: modal.formId)) { responseModel in
            print("getParResult", responseModel)
            self.view.hideToastActivity()
        }
    }
    
    func setupUI() {
        view.addSubview(detailV)
        detailV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
