//
//  SEHomeVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/8.
//
//  【首页】维修工程师-首页

import Foundation
import UIKit

class SEHomeVC: TopViewController {
    let homeV = SEHomeView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .bg
        setupUI()
        reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        parent?.tabBarController?.tabBar.changeTabBar(hidden: false, animated: true)
        navigationController?.navBarStyle(.clear)
    }

    func reloadData() {
        API.getInfo { responseModel in
            BSUser.currentUser.modifyUser(withModal: responseModel.model?.user)
        }
    }
    
    // MARK: - Actions
    @objc func maintenanceTapped() {
        let role = UserDefaults.standard.string(forKey: SafetyUserRole)
        if (role == UserRole.Engineer.rawValue) {
            navigationController?.pushViewController(InspHomeVC(), animated: true)
        }
    } // 我的巡检

    @objc func repairTapped() {
        let role = UserDefaults.standard.string(forKey: SafetyUserRole)
        if (role == UserRole.Engineer.rawValue) {
            navigationController?.pushViewController(SERepairHomeVC(), animated: true)
        }
    } // 一键维修

    // MARK: - Setup

    func setupUI() {
        homeV.headerV.taskV.addTarget(self, action: #selector(maintenanceTapped), for: .touchUpInside)
        homeV.headerV.repairV.addTarget(self, action: #selector(repairTapped), for: .touchUpInside)
        view.addSubview(homeV)
        homeV.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
            make.top.left.right.equalToSuperview()
        }
    }
}
