//
//  PtsmVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/2.
//
//

import Foundation
import UIKit
import MarkdownView

class PtsmVC: SubLevelViewController {
    let md = MarkdownView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "平台个人信息保护声明"
        setupUI()
        reloadData()
    }
    
    func reloadData() {
        view.showToastActivity()
        API.getRetrievepwdPtsm { responseModel in
            DispatchQueue.main.async {
                self.view.hideToastActivity()
                self.md.load(markdown: responseModel.model?.nr)
            }
        }
    }
    
    // MARK: - Setup
    func setupUI() {
        view.addSubview(md)
        md.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
    }
}

