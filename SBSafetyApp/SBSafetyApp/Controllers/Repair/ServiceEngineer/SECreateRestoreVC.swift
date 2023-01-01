//
//  SECreateRestoreVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/29.
//
// 【首页-一键报修-维修工程师】维修工程师-单据详情
import Foundation
import UIKit

class SECreateRestoreVC: SubLevelViewController {
    let detailV = SECreateRestoreView()

    var modal: YjwxListModal!
    
    var dictModals: [[YjwxRestoreDictModal]] = []
    
    var param: YjwxRestoreParam = YjwxRestoreParam(gcsid: "\(BSUser.currentUser.userId)", xfcg: "1", ghsb: "0", wxdj: "0", fwdj: "0", wxbj: "0")

    init(withModal _modal: YjwxListModal) {
        super.init(nibName: nil, bundle: nil)
        self.modal = _modal
        self.param.bxdid = "\(_modal.id ?? 0)"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "单据详情"
        view.backgroundColor = .bg
        setupUI()
        
        reloadData()
    }
    
    func reloadData() {
        // 维修工程师默认字典
        API.getYjwxEngineerRestoreDict { responseModel in
            let datas = responseModel.models
            var types: [String] = []
            for data in datas! {
                let iF = types.contains(where: { (item) -> Bool in
                    return item == data?.type
                })
                if  iF == false {
                    types.append(data!.type!)
                }
            }
                        
            self.dictModals.removeAll()

            for type in types {
                var sds: [YjwxRestoreDictModal] = []
                for s_data in datas! {
                    if type == s_data?.type {
                        sds.append(s_data!)
                    }
                }
                if sds.count > 0 {
                    self.dictModals.append(sds)
                }
            }
            self.detailV.updateUI(withDicts: self.dictModals)
            
            if self.dictModals.count > 0 {
                self.param.gzpp = self.dictModals[0][0].dictLabel
            }
            if self.dictModals.count > 1 {
                self.param.gzlx = self.dictModals[1][0].dictLabel
            }
            if self.dictModals.count > 2 {
                self.param.gzsb = self.dictModals[2][0].dictLabel
            }
            if self.dictModals.count > 3 {
                self.param.gzxx = self.dictModals[3][0].dictLabel
            }
            if self.dictModals.count > 4 {
                self.param.gzyy = self.dictModals[4][0].dictLabel
            }
        }
    }
    
    @objc func submitTapped() {
        param.wxms = detailV.wxmsItem.value
        param.fwms = detailV.fwmsItem.value
        param.wxdj = detailV.wxdjItem.value
        param.fwdj = detailV.fwdjItem.value
        param.wxbj = detailV.wxbjItem.value

        do {
            view.showToastActivity()
            let jsonParam = YjwxJsonParam()
            let data: Data = try JSONEncoder().encode(param)
            let string = String(data: data, encoding: String.Encoding.utf8)
            jsonParam.jsonStr = string
            API.postYjwxEngineerRestore(withParam: jsonParam) { responseModel in
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
        // 故障品牌
        detailV.gzppItem.didSelectItemWith = { (title) -> () in
            self.param.gzpp = title
        }
        // 故障类型
        detailV.gzlxItem.didSelectItemWith = { (title) -> () in
            self.param.gzlx = title
        }
        // 故障设备
        detailV.gzsbItem.didSelectItemWith = { (title) -> () in
            self.param.gzsb = title
        }
        // 故障现象
        detailV.gzxxItem.didSelectItemWith = { (title) -> () in
            self.param.gzxx = title
        }
        // 故障原因
        detailV.gzyyItem.didSelectItemWith = { (title) -> () in
            self.param.gzyy = title
        }
        // 位置信息
        detailV.wzxxItem.didSelectItemWith = { (title) -> () in
            self.param.wzxx = title
        }
        // 修复成功
        detailV.xfcgItem.didSelectItemWith = { (title) -> () in
            self.param.xfcg = (title == "是" ? "1" : "0")
        }
        // 更换设备
        detailV.ghsbItem.didSelectItemWith = { (title) -> () in
            self.param.ghsb = (title == "是" ? "1" : "0")
        }
        // 服务类型
        detailV.fwlxItem.didSelectItemWith = { (title) -> () in
            self.param.fwlx = title
        }
     
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
