//
//  MyReviewsVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/25.
//
// 【首页-我的收藏】我的收藏-维保服务-评价
// 【首页-一键报修】查看评价

import Foundation
import UIKit

class MyReviewsVC: SubLevelViewController {
    
    let reviewsV = MyReviewsView()

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
        title = "评价"
        view.backgroundColor = .white
        setupUI()
        
        reloadData()
    }
    
    func reloadData() {
        // 查询报修单评价
        API.getYjwxGetBxdEvaluate(withParam: YjwxParam(bxdid: "\(self.modal.id ?? -1)")) { responseModel in
            DispatchQueue.main.async {
                self.reviewsV.updateUI(withModal: responseModel.model)
            }
        }
        
    }
    // MARK: - Setup
    
    func setupUI() {
        reviewsV.enabled = false
        view.addSubview(reviewsV)
        reviewsV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
