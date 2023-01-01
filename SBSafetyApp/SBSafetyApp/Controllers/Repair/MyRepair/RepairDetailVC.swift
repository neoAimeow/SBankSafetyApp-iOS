//
//  RepairDetailVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/26.
//
// 【首页-一键报修】报修单详情

import Foundation
import UIKit

class RepairDetailVC: SubLevelViewController {
    let detailV = RepairDetailView()

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
        title = "报修单详情"
        view.backgroundColor = .bg
        
//        setupNavItems()
        setupUI()
        
        reloadData()
    }
    
    func reloadData() {
        detailV.updateUI(withModal: modal)

        // 报修单详情
        API.getYjwxGetBxdDetail(withParam: YjwxParam(id: modal.id)) { responseModel in
            self.modal = responseModel.model!
            DispatchQueue.main.async {
                self.detailV.updateUI(withModal: self.modal)
            }
        }
        
        // 报修记录
        API.getYjwxGetRecordList(withParam: YjwxParam(id: modal.id)) { responseModel in
            DispatchQueue.main.async {
                self.detailV.updateRecordUI(withModal: responseModel.models ?? [])
            }
        }
        
        // 评论
        getCommons()
    }
    
    func getCommons() {
        // 评论
        API.getYjwxGetBxdComment(withParam: YjwxParam(id: modal.id)) { responseModel in
            DispatchQueue.main.async {
                self.detailV.updateCommonUI(withCommons: responseModel.models ?? [])

            }
        }
    }
    
    // 新增报修单评价
    @objc func insetCommonTapped() {
        let plnr = detailV.writeTV.text
        
        view.showToastActivity()
        API.postYjwxInsertBxdComment(withParam: YjwxCommentParam(bxdid: modal.id, plnr: plnr)) { responseModel in
            if responseModel.errorCode == .Success {
                DispatchQueue.main.async {
                    self.view.hideToastActivity()
                    self.getCommons()
                }
            }
            
        }
    }
    
    // MARK: - Setup
    
    func setupUI() {
        detailV.submitBtn.addTarget(self, action: #selector(insetCommonTapped), for: .touchUpInside)
        view.addSubview(detailV)

        detailV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.width.equalTo(ScreenWidth)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
//    // MARK: - Actions
//    @objc func collectTapped() {
//        // 是否收藏
//    }
//
//    @objc func addTapped() {
//        // 创建案例
//        navigationController?.pushViewController(CreateCaseVC(), animated: true)
//    }
//
//    func setupNavItems() {
//        let collectBar = UIBarButtonItem(customView: collectBtn)
//        let addBar = UIBarButtonItem(customView: addBtn)
//        navigationItem.rightBarButtonItems = [collectBar, addBar]
//    }
//
//    lazy var collectBtn: UIButton = {
//        let btn = UIButton(type: .custom)
//        btn.setImage(UIImage(named: "ic_collect_no"), for: .normal)
//        btn.addTarget(self, action: #selector(collectTapped), for: .touchUpInside)
//        return btn
//    }()
//
//    lazy var addBtn: UIButton = {
//        let btn = UIButton(type: .custom)
//        btn.setImage(UIImage(named: "ic_add_case"), for: .normal)
//        btn.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
//        return btn
//    }()
}
