//
//  ImageVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/29.
//

import Foundation
import UIKit
import Kingfisher

class ImageVC: SubLevelViewController {
    
    var urlStr: String = "" {
        didSet {
            imageV.kf.setImage(with: URL(string: urlStr))
        }
    }
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "查看大图"
       
        imageV.kf.setImage(with: URL(string: urlStr))
        imageV.contentMode = .scaleAspectFit
        view.addSubview(imageV)
        imageV.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    lazy var imageV: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
   
}
