//
//  MyVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/24.
//
// 【我的】我的页面

import Foundation
import UIKit

class MyVC: TopViewController {
    let myV = MyView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .bg
        setupNavItems()
        
        setupUI()
        
        reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        parent?.tabBarController?.tabBar.changeTabBar(hidden: false, animated: true)
    }
    
    func reloadData() {
        API.getInfo { responseModel in
            BSUser.currentUser.modifyUser(withModal: responseModel.model?.user)
            DispatchQueue.main.async {
                self.myV.updateUI()
            }
        }
    }
    
    // MARK: - Actions
    
    @objc func departTapped() {
        
    }
    
    @objc func aboutTapped() {
        navigationController?.pushViewController(AboutusVC(), animated: true)
    }
    
    @objc func settingTapped() {
        navigationController?.pushViewController(SettingVC(), animated: true)
    }
    
    // MARK: - Setup
    
    func setupUI() {
        myV.departItem.addTarget(self, action: #selector(departTapped), for: .touchUpInside)
        myV.aboutItem.addTarget(self, action: #selector(aboutTapped), for: .touchUpInside)
        myV.settingItem.addTarget(self, action: #selector(settingTapped), for: .touchUpInside)
        view.addSubview(myV)
        myV.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    func setupNavItems() {
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: titleL)]
        
        let settingBtn = UIButton(type: .custom)
        settingBtn.setImage(UIImage(named: "ic_setting"), for: .normal)
        settingBtn.addTarget(self, action: #selector(settingTapped), for: .touchUpInside)
        let settingBar = UIBarButtonItem(customView: settingBtn)
        navigationItem.rightBarButtonItems = [settingBar]
    }
    
    lazy var titleL: UILabel = {
        let l = UILabel()
        l.text = "我的"
        l.font = .systemFont(ofSize: 17)
        l.textColor = .white
        return l
    }()
}
