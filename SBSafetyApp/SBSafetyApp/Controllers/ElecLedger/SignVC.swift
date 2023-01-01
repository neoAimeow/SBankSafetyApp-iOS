//
//  SignVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/16.
//

import Foundation
import UIKit

protocol SignVCDelegate: AnyObject {
    func handleConfirm(_ canvas: UIImage?)
    func handleClose()
}

class SignVC: SubLevelViewController {
    let signV = SignView()
    
    weak var delegate: SignVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "签字"
        backBtn.tintColor = .white
        setupUI()

        reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Utils.app.blockRotation = true
        setNewOrientation(fullScreen: true)
        navigationController?.navBarStyle(.theme)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Utils.app.blockRotation = false
        setNewOrientation(fullScreen: false)
        navigationController?.navBarStyle(.clear)
    }
    
    func reloadData() {
        
    }
    
    @objc func saveTapped() {
        let snapshot = signV.canvas.snapshot()
        delegate?.handleConfirm(snapshot)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func clearTapped() {
        signV.canvas.clear()
        delegate?.handleClose()
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Setup
    
    func setupUI() {
        signV.clearBtn.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        signV.saveBtn.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        view.addSubview(signV)
        signV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
