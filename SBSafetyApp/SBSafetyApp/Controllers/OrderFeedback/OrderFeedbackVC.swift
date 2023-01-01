//
//  OrderFeedbackVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/5.
//
// 【首页-工单及反馈】我的工单列表

import Foundation
import UIKit
import Popover

class OrderFeedbackVC: SubLevelViewController {
    let datas = ["我的工单", "我的反馈"]

    let segmentedC = ScrollableSegmentedControl()

    let contentV = UIView()

    let orderV = OrderListView()
    let feedbackV = FeedbackListView()
    
    fileprivate var options: [PopoverOption] = [
        .type(.auto), .showBlackOverlay(false), .cornerRadius(6), .color(.white), .arrowSize(CGSize(width: 10, height: 5))
    ]
    fileprivate var popover: Popover!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "工单及反馈"
        view.backgroundColor = .white
        navigationController?.navBarStyle(.white)
        setupUI()
        
        reloadData()
    }
    
    func reloadData() {
        segmentedC.removeAll()
        segmentedC.insertSegment(withTitle: "\(datas[0])(1)", at: 0)
        segmentedC.insertSegment(withTitle: "\(datas[1])(4)", at: 1)
        segmentedC.selectedSegmentIndex = 0
    }
    
    // MARK: - Actions
    @objc func segmentSelected(sender: ScrollableSegmentedControl) {
        let index = sender.selectedSegmentIndex
        if index == 0 { // 我的工单
            showOrder()
        } else if index == 1 { // 我的反馈
            showFeedback()
        }
    }
    
    @objc func addOrderTapped() {
        navigationController?.pushViewController(CreateOrderVC(), animated: true)
    }
     
    // MARK: - Setup
        
    // 我的维修
    func showOrder() {
        contentV.removeAllSubViews()

        contentV.addSubview(orderV)
        orderV.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        orderV.reloadData()
    }
    
    // 我的处置
    func showFeedback() {
        contentV.removeAllSubViews()

        contentV.addSubview(feedbackV)
        feedbackV.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }

        feedbackV.reloadData()
    }

    func setupUI() {
        segmentedC.tintColor = .primary
        segmentedC.underlineSelected = true
        segmentedC.segmentContentColor = .black
        segmentedC.selectedSegmentContentColor = .primary
        segmentedC.backgroundColor = .bg
        segmentedC.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)
        let normalAttrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        let highlightAttrs =  [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        let selectAttrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        segmentedC.setTitleTextAttributes(normalAttrs, for: .normal)
        segmentedC.setTitleTextAttributes(highlightAttrs, for: .highlighted)
        segmentedC.setTitleTextAttributes(selectAttrs, for: .selected)
        view.addSubview(segmentedC)
        segmentedC.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.centerX.equalToSuperview()
            make.height.equalTo(48)
        }
        
        view.addSubview(contentV)
        contentV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(segmentedC.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        showOrder()
        
        orderV.submitBtn.addTarget(self, action: #selector(addOrderTapped), for: .touchUpInside)
    }
}
