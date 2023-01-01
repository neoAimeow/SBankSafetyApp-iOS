//
//  ToBeConfirmedDetailVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/27.
//
// 【首页-一键报修】完成修复

import Foundation
import UIKit

class ToBeConfirmedDetailVC: SubLevelViewController {
    let detailV = ToBeConfirmedDetailView()

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
        title = "维修详情"
        view.backgroundColor = .bg
        setupUI()
        
        reloadData()
    }
    
    func reloadData() {
        detailV.updateUI(withModal: modal)
                
        view.showToastActivity()

        // 网点工作人员确认详情
        API.getYjwxBranchStaffConfirmDetail(withParam: YjwxParam(id: modal.id)) { responseModel in
            DispatchQueue.main.async {
                self.view.hideToastActivity()
                self.detailV.updateUI(withRestore: responseModel.model?.restore)
            }
        }
    }
    
    @objc func signTapped() {
        let vc = SignVC()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func submitTapped() {
        if detailV.img == nil {
            view.showToast(witMsg: "请签名")
            return
        }
        // 网点工作人员确认
        view.showToastActivity()
        let param = YjwxParam(id: modal.id)
        let path = FilesManager.shared.saveImage(img: detailV.img!)
        API.postYjwxUpload(withImage: path!) { responseModel in
            param.bxqm = responseModel.model?.imgUrl
            self.didConfirm(withParam: param)
        }        
    }
    
    func didConfirm(withParam param: YjwxParam) {
        // 网点工作人员确认
        API.postYjwxBranchStaffConfirm(withParam: param) { responseModel in
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
    }
    
    // MARK: - Setup
    
    func setupUI() {
        detailV.imgBV.addTarget(self, action: #selector(signTapped), for: .touchUpInside)
        detailV.submitBtn.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        view.addSubview(detailV)
        detailV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.width.equalTo(ScreenWidth)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}


extension ToBeConfirmedDetailVC: SignVCDelegate {
    func handleConfirm(_ canvas: UIImage?) {
        detailV.img = canvas
    }
    
    func handleClose() {
        detailV.img = nil
    }
}

