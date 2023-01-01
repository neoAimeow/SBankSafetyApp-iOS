//
//  RepairReportDurationView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/28.
//

import Foundation
import UIKit
import AAInfographics

class RepairReportDurationView: UIScrollView {
    let dateCtl = BSMonthControl()

    let durationV = UIView.createBase()
    let repairStatisV = UIView.createBase()
    let averageRepairStatisV = UIView.createBase()
    
    let datas = [
        RRTimeDescItemModal(key: "<2小时", value: 50),
        RRTimeDescItemModal(key: "2-3小时", value: 68),
        RRTimeDescItemModal(key: "3-4小时", value: 38),
        RRTimeDescItemModal(key: "4-5小时", value: 54),
        RRTimeDescItemModal(key: ">5小时", value: 24),
        RRTimeDescItemModal(key: "合计", value: 234),
    ]
    
    let averageDatas = [
        RRTimeDescItemModal(key: "<2小时", value: 50),
        RRTimeDescItemModal(key: "2-3小时", value: 68),
        RRTimeDescItemModal(key: "3-4小时", value: 38),
        RRTimeDescItemModal(key: "4-5小时", value: 54),
        RRTimeDescItemModal(key: ">5小时", value: 24),
        RRTimeDescItemModal(key: "合计", value: 234),
    ]
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
        
    }
    
    // MARK: - Setup
    func setupDurationView() {
        addSubview(durationV)
        durationV.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(14)
            make.right.equalToSuperview().offset(-14)
            make.top.equalTo(dateCtl.snp.bottom).offset(10)
            make.width.equalTo(ScreenWidth - 28)
        }
        
        let titleBT = RRDurationTitleView(withIcon: "ic_rr_duration_1", title: "风险时长统计")
        durationV.addSubview(titleBT)
        titleBT.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
        }
        
        let aaChartView = AAChartView()
        aaChartView.frame = CGRect(x: 13, y: 50, width: ScreenWidth - 26, height: 140)
        durationV.addSubview(aaChartView)
        aaChartView.snp.makeConstraints { make in
            make.top.equalTo(titleBT.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(140)
            make.bottom.equalToSuperview().offset(-25)
        }
        
        let aaChartModel = AAChartModel()
            .chartType(.column)
            .categories(["最短修复时间", "平均修复时间", "最长修复时间"])
            .yAxisTitle("（小时）")
            .xAxisVisible(true)
            .markerRadius(4)
            .markerSymbolStyle(.innerBlank)
            .markerSymbol(.circle)
            .legendEnabled(false)
            .dataLabelsEnabled(false)
            .series([
                AASeriesElement()
                    .name("")
                    .lineWidth(4)
                    .color("#3C72FF")
                    .data([0.5, 1.5, 2.5]),
                ])

        aaChartView.aa_drawChartWithChartModel(aaChartModel)
    }
    
    func setupRepairStatisView() {
        addSubview(repairStatisV)
        repairStatisV.snp.makeConstraints { make in
            make.top.equalTo(durationV.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(14)
            make.right.equalToSuperview().offset(-14)
            make.width.equalTo(ScreenWidth - 28)
        }
        
        let titleBT = RRDurationTitleView(withIcon: "ic_rr_duration_2", title: "报修修复情况统计")
        repairStatisV.addSubview(titleBT)
        titleBT.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
        }
        
        let aaChartView = AAChartView()
        aaChartView.frame = CGRect(x: 13, y: 50, width: ScreenWidth - 26, height: 140)
        repairStatisV.addSubview(aaChartView)
        aaChartView.snp.makeConstraints { make in
            make.top.equalTo(titleBT.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(140)
        }
        
        let gradientColorDic1 = AAGradientColor.linearGradient(
            direction: .toBottom,
            startColor: AARgba(230, 232, 238, 1),
            endColor: AARgba(230, 232, 238, 0.14)
        )

        let aaChartModel = AAChartModel()
            .chartType(.area)
            .categories(["<2小时", "2-3小时", "3-4小时", "4-5小时", ">5小时"])
            .yAxisTitle("（单据数目）")
            .xAxisVisible(true)
            .markerRadius(4)
            .markerSymbolStyle(.innerBlank)
            .markerSymbol(.circle)
            .legendEnabled(false)
            .dataLabelsEnabled(false)
            .series([
                AASeriesElement()
                    .name("")
                    .lineWidth(2)
                    .color("#3C72FF")
                    .fillColor(gradientColorDic1)
                    .data([50, 68, 38, 54, 24]),
                ])

        aaChartView.aa_drawChartWithChartModel(aaChartModel)
        
        let desTitleItem = RRTimeTitleItem()
        repairStatisV.addSubview(desTitleItem)
        desTitleItem.snp.makeConstraints { make in
            make.top.equalTo(aaChartView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(35)
        }
        
        var lastI: RRTimeDescItem?
        for (index, record) in datas.enumerated() {
            let itemV = RRTimeDescItem()
            itemV.reloadData(withModal: record)
//            itemV.detailBtn.addTarget(self, action: #selector(detailTapped), for: .touchUpInside)
            itemV.detailBtn.tag = index
            repairStatisV.addSubview(itemV)
            if index == datas.count - 1 {
                itemV.snp.makeConstraints { make in
                    make.left.equalToSuperview().offset(16)
                    make.right.equalToSuperview().offset(-16)
                    make.top.equalTo(lastI!.snp.bottom)
                    make.height.equalTo(35)
                    make.bottom.equalToSuperview().offset(-16)
                }
            } else {
                itemV.snp.makeConstraints { make in
                    make.left.equalToSuperview().offset(16)
                    make.right.equalToSuperview().offset(-16)
                    make.height.equalTo(35)
                    if lastI == nil {
                        make.top.equalTo(desTitleItem.snp.bottom)
                    } else {
                        make.top.equalTo(lastI!.snp.bottom)
                    }
                }
            }
            lastI = itemV
        }
    }
    
    func setupAverageRepairStatisView() {
        addSubview(averageRepairStatisV)
        averageRepairStatisV.snp.makeConstraints { make in
            make.top.equalTo(repairStatisV.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(14)
            make.right.equalToSuperview().offset(-14)
            make.width.equalTo(ScreenWidth - 28)
            make.bottom.equalToSuperview().offset(-33)
        }
        
        let titleBT = RRDurationTitleView(withIcon: "ic_rr_duration_3", title: "工程商平均修复时长统计")
        averageRepairStatisV.addSubview(titleBT)
        titleBT.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
        }
        
        let aaChartView = AAChartView()
        aaChartView.frame = CGRect(x: 13, y: 50, width: ScreenWidth - 26, height: 230)
        averageRepairStatisV.addSubview(aaChartView)
        aaChartView.snp.makeConstraints { make in
            make.top.equalTo(titleBT.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(230)
        }

        let aaChartModel = AAChartModel()
            .chartType(.column)
            .categories(["九安保安服务有限公司", "上海市保安服务总公司", "上海信安保安服务有限公司（维保）", "上海特领安全科技有限公司", "上海三毛保安服务有限公司"])
            .yAxisTitle("（小时）")
            .xAxisVisible(true)
            .markerRadius(4)
            .markerSymbolStyle(.innerBlank)
            .markerSymbol(.circle)
            .legendEnabled(false)
            .dataLabelsEnabled(false)
            .series([
                AASeriesElement()
                    .name("")
                    .lineWidth(2)
                    .color("#3C72FF")
                    .data([1.4, 3.4, 1,3, 3, 2.4]),
                ])

        aaChartView.aa_drawChartWithChartModel(aaChartModel)
        
        let desTitleItem = RRTimeTitleItem()
        averageRepairStatisV.addSubview(desTitleItem)
        desTitleItem.snp.makeConstraints { make in
            make.top.equalTo(aaChartView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(35)
        }
        
        var lastI: RRTimeDescItem?
        for (index, record) in datas.enumerated() {
            let itemV = RRTimeDescItem()
            itemV.reloadData(withModal: record)
//            itemV.detailBtn.addTarget(self, action: #selector(detailTapped), for: .touchUpInside)
            itemV.detailBtn.tag = index
            averageRepairStatisV.addSubview(itemV)
            if index == datas.count - 1 {
                itemV.snp.makeConstraints { make in
                    make.left.equalToSuperview().offset(16)
                    make.right.equalToSuperview().offset(-16)
                    make.top.equalTo(lastI!.snp.bottom)
                    make.height.equalTo(35)
                    make.bottom.equalToSuperview().offset(-16)
                }
            } else {
                itemV.snp.makeConstraints { make in
                    make.left.equalToSuperview().offset(16)
                    make.right.equalToSuperview().offset(-16)
                    make.height.equalTo(35)
                    if lastI == nil {
                        make.top.equalTo(desTitleItem.snp.bottom)
                    } else {
                        make.top.equalTo(lastI!.snp.bottom)
                    }
                }
            }
            lastI = itemV
        }
    }
    
    func setupUI() {
        dateCtl.nameL.font = .systemFont(ofSize: 17)
        dateCtl.backgroundColor = .white
        addSubview(dateCtl)
        dateCtl.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(ScreenWidth)
        }
        
        setupDurationView()
        
        setupRepairStatisView()
        
        setupAverageRepairStatisView()

    }
}

class RRDurationTitleView: UIView {
    init(withIcon icon: String, title: String) {
        super.init(frame: .zero)
        setupUI(withIcon: icon, title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(withIcon icon: String, title: String) {
        iconIV.image = UIImage(named: icon)
        addSubview(iconIV)
        iconIV.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.snp.left).offset(12)
        }
        
        titleL.text = title
        addSubview(titleL)
        titleL.snp.makeConstraints { make in
            make.left.equalTo(iconIV.snp.right).offset(7)
            make.centerY.equalTo(iconIV.snp.centerY)
        }
    }
    
    lazy var iconIV: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFit
        return v
    }()
    
    lazy var titleL: UILabel = {
        let l = UILabel()
        l.textColor = .black
        l.font = UIFont.systemFont(ofSize: 17)
        l.textAlignment = .left
        return l
    }()
}
