//
//  SignDisplayVC.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/28.
//

import Foundation
import UIKit

class SignDisplayVC: SubLevelViewController {
    let App_Delegate = (UIApplication.shared.delegate) as! AppDelegate

    lazy var signImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIView.ContentMode.scaleToFill
        imageView.backgroundColor = .randomColor
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "查看签名"
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
        setupUI()
    }

    override var shouldAutorotate:Bool{
        return false
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
    
    
    func setupUI() {
        view.addSubview(signImageView)
        signImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.bottom.equalTo(view)
        }
    }
}
