//
//  SubLevelViewController.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/15.
//

import Foundation
import UIKit

class SubLevelViewController: TopViewController {
    
    let backBtn = UIButton(type: .custom)
    var backBar : UIBarButtonItem! = nil
    
    var deptId: Int64?
    var deptName: String?
    var wbtype: String?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    init(withDeptId _deptId: Int64? = nil, deptName _deptName: String? = nil, wbtype _wbtype: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.deptId = _deptId
        self.deptName = _deptName
        self.wbtype = _wbtype
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if navigationController!.viewControllers.count > 1 {
            backBtn.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
            backBtn.addTarget(self, action: #selector(backToPrevious), for: .touchUpInside)
            backBtn.sizeToFit()
            backBtn.tintColor = .black
            backBar = UIBarButtonItem(customView: backBtn)
            navigationItem.leftBarButtonItems = [backBar]
            
            //启用滑动返回（swipe back）
            navigationController?.interactivePopGestureRecognizer!.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if navigationController!.viewControllers.count > 1 {
            parent?.tabBarController?.tabBar.changeTabBar(hidden: true, animated: true)
        }
    }

    // MARK: - Actions
    // 返回按钮点击响应
    @objc func backToPrevious() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - GestureRecognizerDelegate
extension SubLevelViewController: UIGestureRecognizerDelegate {
    // 是否允许手势
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if (gestureRecognizer == navigationController?.interactivePopGestureRecognizer) {
            //只有二级以及以下的页面允许手势返回
            return navigationController!.viewControllers.count > 1
        }
        return true
    }
}
