//
//  OneClickRepairVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/27.
//
// 【首页-一键报修】一键报修-新建提交

import Foundation
import UIKit

class OneClickRepairVC: SubLevelViewController {
    let newV = OneClickRepairView()
    
    var param = YjwxCreateOrderParam()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "一键报修"
        view.backgroundColor = .white
        setupUI()
        
        reloadData()
    }
    
    // 选择网点
    @objc func branchTapped() {
        let bSearchVC = BranchSearchVC()
        bSearchVC.didSelectBranchWith = { (dept) -> () in
            self.param.wddm = "\(dept.deptId ?? 0)"
            self.param.wdmc = dept.deptName
            self.param.wdqc = "\(dept.deptPosition ?? "")(\( dept.deptName ?? ""))"
            self.param.wdzrr = "\(dept.leader ?? "")(\(dept.phone ?? ""))"
            self.newV.updateUI(param: self.param)
            
            bSearchVC.navigationController?.popViewController(animated: true)
        }
        navigationController?.pushViewController(bSearchVC, animated: true)
    }
    
    // 选择报修故障
    @objc func faultCategoryTapped() {
        let vc = FaultCategoryVC(withDeptId: Int64(param.wddm!), deptName: param.wdmc)
        vc.didSelectModalWith = { (modal, tswb) -> () in
            self.param.bxgzmc = modal?.fwfcmc
            self.param.bxgzdm = "\(modal?.fwfcid ?? 0)"
            self.newV.updateUI(param: self.param, yysj: tswb)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // 选择发生位置
    @objc func locationTapped() {
        let vc = LocationVC()
        vc.didSelectLocWith = { (loc) -> () in
            self.param.fswz = loc
            self.newV.updateUI(param: self.param)
            self.newV.moreLocHidden = (loc != "自定义位置" && loc != "其他位置")
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func submitTapped() {
        param.bxgzms = newV.despTF.value
        
        if (newV.moreLocTF.value != nil) && (newV.moreLocTF.value != "")  {
            param.fswz = (param.fswz ?? "")  + " - " + (newV.moreLocTF.value ?? "")
        }
                
        let imgs = newV.imgPickerView.images
        
        if imgs.count == 0 {
            self.didCreate()
            return
        }
        
        var uploadindex = 0
        var enclosureList: [[String: String]] = []
        
        for img in imgs {
            let path = FilesManager.shared.saveImage(img: img)
            API.postYjwxUpload(withImage: path!) { responseModel in
                if responseModel.model?.imgUrl != nil {
                    enclosureList.append(["fjdz": responseModel.model?.imgUrl ?? ""])
                }
                uploadindex += 1
                if imgs.count == uploadindex {
                    DispatchQueue.main.async {
                        self.param.enclosureList = enclosureList
                        self.didCreate()
                    }
                }
            }
        }
    }
    
    func didCreate() {
        do {
            view.showToastActivity()
            let jsonParam = YjwxJsonParam()
            let data: Data = try JSONEncoder().encode(param)
            let string = String(data: data, encoding: String.Encoding.utf8)
            jsonParam.jsonStr = string
            API.postYjwxInsertRepairOrder(withParam: jsonParam) { responseModel in
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
   
    func reloadData() {
        param.wddm = "\(deptId ?? 0)"
        param.wdmc = deptName
        param.bxrmc = "\(BSUser.currentUser.nickName ?? "")(\(BSUser.currentUser.phone ?? ""))"
        param.bxrid = "\(BSUser.currentUser.userId)"
        newV.updateUI(param: param)
        
        API.getHomeDeptall(withParam: HomeParam(deptName: deptName), block: { responseModel in
            DispatchQueue.main.async {
                let dept = responseModel.models?[0]
                if self.deptId == dept?.deptId {
                    self.param.wddm = "\(dept?.deptId ?? 0)"
                    self.param.wdmc = dept?.deptName
                    self.param.wdqc = "\(dept?.deptPosition ?? "")(\( dept?.deptName ?? ""))"
                    self.param.wdzrr = "\(dept?.leader ?? "")(\(dept?.phone ?? ""))"
                    self.newV.updateUI(param: self.param)
                }
            }
        })
    }
    
    // MARK: - Setup
    
    func setupUI() {
        newV.branchTF.ctl.addTarget(self, action: #selector(branchTapped), for: .touchUpInside)
        newV.locationTF.ctl.addTarget(self, action: #selector(locationTapped), for: .touchUpInside)
        newV.failureTF.ctl.addTarget(self, action: #selector(faultCategoryTapped), for: .touchUpInside)
        newV.submitBtn.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        view.addSubview(newV)
        newV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.width.equalTo(ScreenWidth)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
