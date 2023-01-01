//
//  WorkbenchVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/14.
//
// 【工作台】工作台页面

import Foundation
import UIKit

class WorkbenchVC: TopViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "工作台"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        parent?.tabBarController?.tabBar.changeTabBar(hidden: false, animated: true)
    }
}

