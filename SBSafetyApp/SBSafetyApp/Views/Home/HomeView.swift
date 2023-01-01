//
//  HomeView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/14.
//

import Foundation
import UIKit

public enum IFType: Int {
    case IFAlarm         = 0 // 报警处置
    case IFDuty          = 1 // 履职管理
    case IFRepair        = 2 // 一键维修
    case IFWisdomInsider = 3 // 安全评估
    case IFSmartSecurity = 4 // 保安管理
    case IFSupervision   = 5 // 检查监督
    case IFMaintenance   = 6 // 维保服务
    case IFElecLedger    = 7 // 台账管理
}

protocol HomeViewDelegate: AnyObject {
    func handleTypeSelected(_ type: IFType)
}

class HomeView: UIScrollView {
    let datas: [[String: Any]] = [
        ["icon": "ic_bjtz", "title" : "报警处置", "type" : IFType.IFAlarm],
        ["icon": "ic_lzgl", "title" : "履职管理", "type" : IFType.IFDuty],
        ["icon": "ic_sssb", "title" : "维保服务", "type" : IFType.IFMaintenance],
        ["icon": "ic_zhnb", "title" : "安全评估", "type" : IFType.IFWisdomInsider],
        ["icon": "ic_xjwx", "title" : "一键报修", "type" : IFType.IFRepair],
        ["icon": "ic_dztz", "title" : "电子台账", "type" : IFType.IFElecLedger],
        ["icon": "ic_jcjd", "title" : "检查监督", "type" : IFType.IFSupervision],
        ["icon": "ic_zhba", "title" : "保安管理", "type" : IFType.IFSmartSecurity],
    ]

    weak var hDelegate: HomeViewDelegate?
    
    let bannerV = HomeCarouselView()
    let situationV = HomeSituationView()
    let todayV = HomeTodayView()
//    let deviceV = HomeDeviceView()
//    let briefV = HomeBriefView()
//    let orderV = HomeOrderView()
//    let notiV = HomeNotiView()
//    let collectV = HomeCollectView()

    let bottomIV = UIImageView(image: UIImage(named: "ic_slogen"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        showsVerticalScrollIndicator = false
        alwaysBounceVertical = true
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(bannerV)
        bannerV.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(16)
            make.width.equalTo(ScreenWidth)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(130)
        }
        
        addSubview(situationV)
        situationV.snp.makeConstraints { make in
            make.top.equalTo(bannerV.snp.bottom).offset(16)
            make.width.equalTo(ScreenWidth - 20)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(300)
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (ScreenWidth - 120)/4, height: 70)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.register(HomeCollectionCell.self, forCellWithReuseIdentifier: "HomeCollectionCell")
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(situationV.snp.bottom).offset(20)
            make.width.equalTo(ScreenWidth - 32)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(154)
        }
        
        addSubview(todayV)
        todayV.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(16)
            make.width.equalTo(ScreenWidth - 20)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(100)
        }
        
//        addSubview(deviceV)
//        deviceV.snp.makeConstraints { make in
//            make.top.equalTo(todayV.snp.bottom).offset(10)
//            make.width.equalTo(ScreenWidth - 20)
//            make.centerX.equalTo(self.snp.centerX)
//            make.height.equalTo(276)
//        }
//
//        addSubview(briefV)
//        briefV.snp.makeConstraints { make in
//            make.top.equalTo(deviceV.snp.bottom).offset(10)
//            make.left.equalTo(self.snp.left).offset(10)
//            make.width.equalTo(ScreenWidth - 220)
//            make.height.equalTo(138)
//        }
//
//        addSubview(orderV)
//        orderV.snp.makeConstraints { make in
//            make.top.equalTo(briefV.snp.top)
//            make.right.equalTo(situationV.snp.right)
//            make.width.equalTo(190)
//            make.height.equalTo(59)
//        }
//
//        addSubview(notiV)
//        notiV.snp.makeConstraints { make in
//            make.top.equalTo(orderV.snp.bottom).offset(5)
//            make.left.equalTo(orderV.snp.left)
//            make.width.equalTo(92)
//            make.height.equalTo(74)
//        }
//
//        addSubview(collectV)
//        collectV.snp.makeConstraints { make in
//            make.top.equalTo(orderV.snp.bottom).offset(5)
//            make.right.equalTo(orderV.snp.right)
//            make.width.equalTo(92)
//            make.height.equalTo(74)
//        }
        
        addSubview(bottomIV)
        bottomIV.snp.makeConstraints { make in
            make.top.equalTo(todayV.snp.bottom).offset(18)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(120)
            make.height.equalTo(40)
            make.bottom.equalTo(self.snp.bottom).offset(-20)
        }
    }
}

extension HomeView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionCell", for: indexPath)
        
        let data = datas[indexPath.item]
        
        (cell as! HomeCollectionCell).iconIV.image = UIImage(named: data["icon"] as! String)
        (cell as! HomeCollectionCell).nameL.text = data["title"] as? String
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = datas[indexPath.item]

        hDelegate?.handleTypeSelected(data["type"] as! IFType)
    }
}

class WeatherView: UIView {
    let titleL = UILabel()
//    let wIV = UIImageView()
    let wL = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(withLive live: BSCommon) {
        titleL.text = live.province
        wL.text = "\(live.weather ?? "")  \(live.temperature ?? "")℃"
    }
    
    func setupUI() {
        backgroundColor = .red
        frame = CGRect(x: 0, y: 0, width: 100, height: 25.5)
        
//        wIV.image = UIImage(systemName: "cloud.sun")
//        wIV.tintColor = .primary
//        wIV.contentMode = .scaleAspectFit
//        addSubview(wIV)
//        wIV.snp.makeConstraints { make in
//            make.height.equalTo(13)
//            make.width.equalTo(17)
//            make.top.equalTo(self.snp.top).offset(-15)
//            make.right.equalTo(self.snp.right)
//        }
//
        titleL.font = .systemFont(ofSize: 16)
        titleL.textColor = .black
        addSubview(titleL)
        titleL.snp.makeConstraints { make in
            make.right.equalTo(self.snp.right)
            make.top.equalTo(self.snp.top).offset(-15)
        }
        
        wL.text = "多云  23℃"
        wL.font = .systemFont(ofSize: 12)
        wL.textColor = .hex("#AAAAAA")
        addSubview(wL)
        wL.snp.makeConstraints { make in
            make.right.equalTo(titleL.snp.right)
            make.top.equalTo(titleL.snp.bottom).offset(3)
        }
    }
}

