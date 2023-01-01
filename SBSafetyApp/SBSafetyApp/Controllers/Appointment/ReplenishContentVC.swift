//
//  ReplenishContentVC.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/28.
//  履职管理-补充说明

import Foundation
import UIKit

class LzglUpdateParam: Encodable {
    var id: Int64?
    var remark: String?
    var images : [String]?
}



class ReplenishContentVC: SubLevelViewController {
    var id: Int64?
    
    lazy var contentTextView: BaseTextViewPanel = {
        let panel = BaseTextViewPanel(withStyle: .Style2, withTitle: "内容")
        return panel;
    }()

    lazy var imagePickerPanel: BaseImagePickerPanel = {
        let panel = BaseImagePickerPanel(withStyle: .Style2, withTitle: "现场图片")
        return panel;
    }()

    lazy var submitButton: UIButton = {
        let button = UIButton.createCornerPrimary("提交")
        button.addTarget(self, action: #selector(submitTapped(sender:)), for: .touchUpInside)
        return button
    }()

    var images: [String] = []

    @objc func submitTapped(sender: UIButton) {

        let imgs = imagePickerPanel.imagePickerView.images
        
        if imgs.count == 0 {
            self.didCreate(imageUrls: [])
            return
        }
        
        var uploadindex = 0
        var imageUrlList: [String] = []
        
        for img in imgs {
            let path = FilesManager.shared.saveImage(img: img)
            API.lzglUpload(withImage: path!) { responseModel in
                if responseModel.model?.imgUrl != nil {
                    imageUrlList.append(responseModel.model?.imgUrl ?? "")
                }
                uploadindex += 1
                if imgs.count == uploadindex {
                    DispatchQueue.main.async {
                        self.didCreate(imageUrls: imageUrlList)
                    }
                }
            }
        }
    }
    
    func didCreate(imageUrls: [String]) {
        do {
            view.showToastActivity()
            let param = LzglUpdateParam()
            param.id = id
            param.remark = contentTextView.textView.text
            param.images = imageUrls
            let data: Data = try JSONEncoder().encode(param)
            let string = String(data: data, encoding: String.Encoding.utf8)
            if let jsonStr = string {
                API.updateRemark(withParam: UpdateRemarkParam(jsonStr: jsonStr)) { responseModel in
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
         
        } catch  {
            print(error)
        }
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "补充说明"
        view.backgroundColor = .bg
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    func setupUI() {
        view.addSubview(contentTextView)
        view.addSubview(imagePickerPanel)
        view.addSubview(submitButton)

        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
        }

        imagePickerPanel.snp.makeConstraints { make in
            make.top.equalTo(contentTextView.snp.bottom).offset(20)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
        }

        submitButton.snp.makeConstraints { make in
            make.bottom.equalTo(view).offset(-20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(50)
        }
    }

}
