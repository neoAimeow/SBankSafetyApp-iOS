//
//  SuperviseHomeVC.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/22.
//

import Foundation
import UIKit

class SuperviseHomeVC: SubLevelViewController {
    lazy var headImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage.init(named: "supervise_head"))
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        return imageView
    }()
    
    lazy var titleView: SuperviseHomeTitleView = {
        let view = SuperviseHomeTitleView()
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (ScreenWidth - 110) / 2, height: 60)
        layout.minimumLineSpacing = 35
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.register(SuperviseHomeCell.self, forCellWithReuseIdentifier: "SuperviseHomeCell")
        return collectionView
    }()
    
    lazy var button: UIButton = {
        let button = UIButton.createCornerButton("安全规范")
        return button
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .hex("#C1C1C1")
        label.text = "当前日期：2022年11月27日"
        return label
    }()
    
    
    var fakeData: [SuperviseHomeModel] = [
        SuperviseHomeModel(icon: "ic_task", title: "任务"),
        SuperviseHomeModel(icon: "ic_report", title: "报告"),
        SuperviseHomeModel(icon: "ic_arrage", title: "待整改"),
        SuperviseHomeModel(icon: "ic_check", title: "待复查"),
        SuperviseHomeModel(icon: "ic_locate", title: "隐患跟踪"),
        SuperviseHomeModel(icon: "ic_asistance", title: "统计"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupUI()

    }
    
    func setupUI() {
        view.addSubview(headImageView)
        view.addSubview(titleView)
        view.addSubview(collectionView)
        view.addSubview(button)
        view.addSubview(dateLabel)
        
        headImageView.snp.makeConstraints { make in
            make.left.top.right.equalTo(view)
            make.height.equalTo(255)
        }
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(headImageView.snp.bottom).offset(24)
            make.centerX.equalTo(headImageView)
        }
        
        collectionView.snp.makeConstraints { make in
            make.left.equalTo(self.view).offset(42)
            make.right.equalTo(self.view).offset(-42)
            make.top.equalTo(titleView.snp.bottom).offset(40)
            make.height.equalTo(300)
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(30)
            make.centerX.equalTo(self.view)
            make.width.equalTo(220)
            make.height.equalTo(50)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(25)
            make.centerX.equalTo(self.view)
        }
    }
}

extension SuperviseHomeVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fakeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuperviseHomeCell", for: indexPath)as! SuperviseHomeCell
        cell.buildData(model: fakeData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
}
