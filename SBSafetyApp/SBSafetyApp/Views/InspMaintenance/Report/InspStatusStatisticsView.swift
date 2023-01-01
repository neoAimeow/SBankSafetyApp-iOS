//
//  InspStatusStatisticsView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/24.
//

import Foundation
import UIKit
import AAInfographics


class InspStatusStatisticsModal: NSObject {
    var color: String = ""
    var key: String = ""
    var val: String = ""
    var percent: String = ""
    
    init(color: String, key: String, val: String, percent: String) {
        self.color = color
        self.key = key
        self.val = val
        self.percent = percent
    }
}

class InspStatusStatisticsView: UIView {
    var collectionView: UICollectionView!
    let aaChartView = AAChartView()
    
    let colors = ["#2591FE", "#1AEA94", "#E557FF", "#FF6E57", "#13B185", "#FFBA5B", "#C8CACE"]
    let keys = ["未开始", "进行中", "待确认", "运行正常", "运行异常", "超时未提交", "已取消"]

    var datas: [InspStatusStatisticsModal] = [
        InspStatusStatisticsModal(color: "#2591FE", key: "未开始", val: "0", percent: "0%"),
        InspStatusStatisticsModal(color: "#1AEA94", key: "进行中", val: "0", percent: "0%"),
        InspStatusStatisticsModal(color: "#E557FF", key: "待确认", val: "0", percent: "0%"),
        InspStatusStatisticsModal(color: "#FF6E57", key: "运行正常", val: "0", percent: "0%"),
        InspStatusStatisticsModal(color: "#13B185", key: "运行异常", val: "0", percent: "0%"),
        InspStatusStatisticsModal(color: "#FFBA5B", key: "超时未提交", val: "0", percent: "0%"),
        InspStatusStatisticsModal(color: "#C8CACE", key: "已取消", val: "0", percent: "0%"),
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        layer.masksToBounds = true
        backgroundColor = .white
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    
    func reloadUI(withData lists: [CountStutasModal?]) {
        datas.removeAll()
        
        var total: Int64 = 0
        var series: [[Any]] = []
        
        for (index, list) in lists.enumerated() {
            let key = list?.bq ?? keys[index]
            let num = list?.sl ?? 0
            datas.append(InspStatusStatisticsModal(color: colors[index], key: key, val: "\(num)", percent: "\(list?.percent ?? 0)%"))
            series.append([key, Int(num)])
            total += num
        }
        
        totalL.text = "\(total)"
        
        let aaChartModel = AAChartModel()
            .chartType(.pie)
            .backgroundColor(AAColor.white)
            .dataLabelsEnabled(false)
            .legendEnabled(false)
            .tooltipEnabled(false)
            .colorsTheme(colors)
            .series([
                AASeriesElement()
                    .name("")
                    .innerSize("80%")
                    .showInLegend(false)
                    .allowPointSelect(false)
                    .borderWidth(2.5)
                    .states(AAStates().hover(AAHover().enabled(false)))
                    .data(series)
            ])
        aaChartView.aa_refreshChartWholeContentWithChartModel(aaChartModel)
    
        collectionView.reloadData()
    }

    // MARK: - Setup
    
    func setupUI() {
        let staticTitle = InspStatusTitle(withIcon: "ic_report_1", name: "网点巡检状况统计")
        addSubview(staticTitle)
        staticTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(21)
        }
        
        aaChartView.frame = CGRect(x: 30, y: 60, width: ScreenWidth - 80, height: 200)
        addSubview(aaChartView)
        
        let aaChartModel = AAChartModel()
            .chartType(.pie)
            .backgroundColor(AAColor.white)
            .dataLabelsEnabled(false)
            .legendEnabled(false)
            .tooltipEnabled(false)
            .colorsTheme(colors)
            .series([])
        aaChartView.aa_drawChartWithChartModel(aaChartModel)
        
        addSubview(totalL)
        totalL.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(aaChartView.snp.centerY).offset(-12)
        }
        
        addSubview(keyL)
        keyL.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(totalL.snp.bottom).offset(10)
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (ScreenWidth - 80)/3, height: 50)
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.register(InspStatusStatisticsCell.self, forCellWithReuseIdentifier: "InspStatusStatisticsCell")
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom).offset(-20)
            make.width.equalTo(ScreenWidth - 60)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(164)
        }
    }
    
    lazy var totalL: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 24)
        return l
    }()
    
    lazy var keyL: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 13)
        l.text = "单据数目"
        l.textColor = .hex("#AFAFAF")
        return l
    }()
}

extension InspStatusStatisticsView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InspStatusStatisticsCell", for: indexPath)
        
        let data = datas[indexPath.item]
        
        (cell as! InspStatusStatisticsCell).reload(withModal: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        _ = datas[indexPath.item]
        
        getFirstViewController()?.navigationController?.pushViewController(InspQualityStatisticsVC(), animated: true)
    }
}
