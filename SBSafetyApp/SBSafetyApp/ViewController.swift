//
//  ViewController.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/14.
//

import UIKit

class ViewController: SubLevelViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        title = "上海银行"
        view.backgroundColor = .bg
        setupUI()
    }

    func setupUI() {
        let iv = UIImageView()
        iv.image = UIImage(named: "ic_gnwsz")
        iv.contentMode = .scaleAspectFit
        view.addSubview(iv)
        iv.snp.makeConstraints { make in
            make.width.equalTo(109)
            make.height.equalTo(109)
            make.centerY.equalTo(view.snp.centerY).offset(-80)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        let titleL = UILabel()
        titleL.text = "功能完善中，近期上线，\n\n敬请期待..."
        titleL.textColor = .hex("#A2A2A2")
        titleL.font = UIFont.systemFont(ofSize: 17)
        titleL.textAlignment = .center
        titleL.numberOfLines = 0
        view.addSubview(titleL)
        titleL.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(iv.snp.bottom).offset(20)
        }
    }

}

