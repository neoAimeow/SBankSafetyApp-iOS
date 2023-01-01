//
//  ElecHistoryDetailVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/17.
//

import Foundation
import UIKit

class ElecHistoryDetailVC: SubLevelViewController {
    var modal: StandingBookModal!
    
    init(withModal _modal: StandingBookModal) {
        super.init(nibName: nil, bundle: nil)
        self.modal = _modal
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "历史详情"
        view.backgroundColor = .bg
        setupUI()
        
//        reloadData()
    }
    
//    func reloadData() {
//        /// 获取详细信息
//        API.getStandingBookDetail(withId: modal.bookId!) { responseModel in
//            print("responseModel", responseModel)
//        }
//    }

    func setupUI() {
        let type: ElecType = ElecType(rawValue: modal.bookType!)!
        switch type {
        case .ATM, .OutMonitor, .VideoMonitor, .SimpleWarehouse, .OutBusiness: setupDetail(); break
        case .SecurityLegal: setupSecurityLegal(); break
        case .InfraredArm: setupInfraredArm(); break
        case .Repair: setupRepair(); break
        case .CheckVideo: setupCheckVideo(); break
        case .CashBox: setupCashBox(); break
        case .SelfCheck: setupSelfCheck(); break
        case .SecurityCheck: setupSecurityCheck(); break
        }
    }
    
    // MARK: - Setup
    func setupSecurityCheck() {
        let detailV = DetailSecurityCheckView()
        view.addSubview(detailV)
        detailV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        detailV.reloadData(modal)
    }
    
    func setupSelfCheck() {
        let detailV = DetailSelfCheckView()
        view.addSubview(detailV)
        detailV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        detailV.reloadData(modal)
    }
        
    func setupCashBox() {
        let detailV = DetailCashBoxView()
        view.addSubview(detailV)
        detailV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        detailV.reloadData(modal)
    }
    
    func setupCheckVideo() {
        let detailV = DetailCheckVideoView()
        view.addSubview(detailV)
        detailV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        detailV.reloadData(modal)
    }
    
    func setupRepair() {
        let detailV = DetailRepairView()
        view.addSubview(detailV)
        detailV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        detailV.reloadData(modal)
    }
    
    func setupInfraredArm() {
        let detailV = DetailInfraredArmView()
        view.addSubview(detailV)
        detailV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        detailV.reloadData(modal)
    }
    
    func setupSecurityLegal() {
        let detailV = DetailSecurityLegalView()
        view.addSubview(detailV)
        detailV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        detailV.reloadData(modal)
    }
    
    func setupDetail() {
        let detailV = DetailView()
        view.addSubview(detailV)
        detailV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        detailV.reloadData(modal)
    }
}
