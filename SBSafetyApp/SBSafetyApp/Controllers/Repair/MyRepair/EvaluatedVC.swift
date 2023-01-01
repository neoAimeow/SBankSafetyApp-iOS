//
//  EvaluatedVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/26.
//
// 【首页-一键报修】评价

import Foundation
import UIKit

class EvaluatedVC: SubLevelViewController {
    let reviewsV = MyReviewsView()

    var modal: YjwxListModal!
    
    let param = YjwxEvaluateParam(xfsd: 5, wxxg: 5, fwtd: 5, wxhp: 0, xysdk: 0, xfjs: 0, fwtdh: 0, jsjz: 0, rzds: 0)

    init(withModal _modal: YjwxListModal) {
        super.init(nibName: nil, bundle: nil)
        self.modal = _modal
        param.bxdid = "\(_modal.id ?? -1)"
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
    }
    
    @objc func submitTapped() {
        param.pjnr = reviewsV.commonTV.text
        do {
            view.showToastActivity()
            let jsonParam = YjwxJsonParam()
            let data: Data = try JSONEncoder().encode(param)
            let string = String(data: data, encoding: String.Encoding.utf8)
            jsonParam.jsonStr = string
            API.postYjwxInsertBxdEvaluate(withParam: jsonParam) { responseModel in
                DispatchQueue.main.async {
                    self.view.hideToastActivity()
                    if responseModel.errorCode == .Success {
                        self.view.showToast(witMsg: responseModel.errorMessage)
                        Utils.delay(second: 1) {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
        } catch  {
            print(error)
        }
    }
    
    // MARK: - Setup
    
    func setupUI() {
        reviewsV.enabled = true
        reviewsV.tagV.delegate = self
        reviewsV.speedV.didSelectRateWith = { (rate) -> () in
            self.param.xfsd = rate
        }
        reviewsV.effectV.didSelectRateWith = { (rate) -> () in
            self.param.wxxg = rate
        }
        reviewsV.attitudeV.didSelectRateWith = { (rate) -> () in
            self.param.fwtd = rate
        }
        reviewsV.speedV.ratingValue = param.xfsd ?? 0
        reviewsV.effectV.ratingValue = param.wxxg ?? 0
        reviewsV.attitudeV.ratingValue = param.fwtd ?? 0
        reviewsV.submitBtn.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        view.addSubview(reviewsV)

        reviewsV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.width.equalTo(ScreenWidth)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

// MARK: - TagListViewDelegate

extension EvaluatedVC: TagListViewDelegate {
   func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
       print("Tag pressed: \(title)")
       tagView.isSelected = !tagView.isSelected
       
       if title == "五星好评" {
           param.wxhp = tagView.isSelected ? 1 : 0
       } else if title == "响应速度快" {
           param.xysdk = tagView.isSelected ? 1 : 0
       } else if title == "修复及时" {
           param.xfjs = tagView.isSelected ? 1 : 0
       } else if title == "服务态度好" {
           param.fwtdh = tagView.isSelected ? 1 : 0
       } else if title == "技术精湛" {
           param.jsjz = tagView.isSelected ? 1 : 0
       } else if title == "人长得帅" {
           param.rzds = tagView.isSelected ? 1 : 0
       }
   }
}
