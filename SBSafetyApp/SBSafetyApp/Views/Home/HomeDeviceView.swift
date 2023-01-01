//
//  HomeDeviceView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/21.
//

import Foundation
import UIKit
import AAInfographics

class HomeDeviceView: UIView {
      
    let onlineV = HomeDeviceCard()
    let completionV = HomeDeviceCard()
    let failureV = HomeDeviceCard()
    let maintenanceV = HomeDeviceCard()
    let segmentedC = ScrollableSegmentedControl()
    let arrowIV = UIImageView(image: UIImage(named: "ic_device_arr"))

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.masksToBounds = true
        layer.cornerRadius = 10

        setupUI()
        update(withData: [])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(withData: Any) {
        onlineV.update(withModal: HomeDeviceModal(type: .online, value: "96.7"))
        completionV.update(withModal: HomeDeviceModal(type: .completion, value: "62.4"))
        failureV.update(withModal: HomeDeviceModal(type: .failure, value: "12.3"))
        maintenanceV.update(withModal: HomeDeviceModal(type: .maintenance, value: "57.9"))
    }
    
    @objc func segmentSelected(sender: ScrollableSegmentedControl) {
        print("segmentSelected", sender.selectedSegmentIndex)
        let index = sender.selectedSegmentIndex
        
        arrowIV.snp.updateConstraints { make in
            make.left.equalTo(segmentedC.snp.left).offset(index == 0 ? 17 : 67)
        }
    }
    
    func setupUI() {
        
        let titleL = UILabel()
        titleL.text = "设备分析"
        titleL.textColor = .black
        titleL.font = .systemFont(ofSize: 16)
        addSubview(titleL)
        titleL.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(12)
            make.left.equalTo(self.snp.left).offset(15.5)
        }
        
        let subTitleL = UILabel()
        subTitleL.text = "记录要可靠，统计才有效"
        subTitleL.textColor = .hex("#B6B6B6")
        subTitleL.font = .systemFont(ofSize: 14)
        addSubview(subTitleL)
        subTitleL.snp.makeConstraints { make in
            make.top.equalTo(titleL.snp.bottom)
            make.left.equalTo(self.snp.left).offset(15.5)
        }
        
        segmentedC.tintColor = .primary
        segmentedC.underlineSelected = true
        segmentedC.isSmallLine = true
        segmentedC.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)
        segmentedC.segmentContentColor = .black
        segmentedC.selectedSegmentContentColor = .primary
        
        let normalAttrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
        let highlightAttrs =  [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        let selectAttrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        segmentedC.setTitleTextAttributes(normalAttrs, for: .normal)
        segmentedC.setTitleTextAttributes(highlightAttrs, for: .highlighted)
        segmentedC.setTitleTextAttributes(selectAttrs, for: .selected)
        
        addSubview(segmentedC)
        segmentedC.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(self.snp.right).offset(-10)
            make.top.equalTo(titleL.snp.top)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        
        segmentedC.insertSegment(withTitle: "全行", at: 0)
        segmentedC.insertSegment(withTitle: "本行", at: 1)
        segmentedC.selectedSegmentIndex = 0

        let baseV = UIView()
        baseV.backgroundColor = .hex("#F9FAFC")
        baseV.layer.masksToBounds = true
        baseV.layer.cornerRadius = 4
        addSubview(baseV)
        baseV.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(60)
            make.left.equalTo(self.snp.left).offset(15.5)
            make.right.equalTo(self.snp.right).offset(-15.5)
            make.height.equalTo(200)
        }
        
        addSubview(arrowIV)
        arrowIV.snp.makeConstraints { make in
            make.bottom.equalTo(baseV.snp.top)
            make.width.equalTo(16)
            make.left.equalTo(segmentedC.snp.left).offset(17)
        }
        
        
        let aaChartView = AAChartView()
        aaChartView.layer.masksToBounds = true
        aaChartView.layer.cornerRadius = 4
        aaChartView.frame = CGRect(x: 0, y: 60, width: ScreenWidth - 51, height: 120)
        baseV.addSubview(aaChartView)
        
        let aaChartModel = AAChartModel()
            .chartType(.spline)
            .animationType(.bounce)
            .markerRadius(0)
//            .tooltipEnabled(false)
            .dataLabelsEnabled(false)
            .legendEnabled(false)
            .categories(["完成率", "在线率", "故障率", "维护率"])
            .colorsTheme(["#306EC8"])
            .yAxisMin(0)
            .yAxisMax(1)
            .backgroundColor("#F9FAFC")
            .series([AASeriesElement()
                .name("")
                .lineWidth(3.0)
                .data([0.624, 0.967, 0.123, 0.579])
                .shadow(AAShadow().offsetX(0).offsetY(1).opacity(0.27).width(5.0).color("#306EC8"))
                .showInLegend(false)
            ])
        let aaOptions = aaChartModel.aa_toAAOptions()
        aaOptions.xAxis?
            .labels(
                AALabels()
                    .enabled(true)
                    .style(AAStyle(color: AAColor.gray, fontSize: 10, weight: .bold))
                    .format("{value}%"))
            .crosshair(AACrosshair().dashStyle(.shortDash).color("#306EC8").width(1))
        aaChartView.aa_drawChartWithChartModel(aaChartModel)
        
        let itemW = (ScreenWidth - 51) / 4.0
        
        baseV.addSubview(onlineV)
        onlineV.snp.makeConstraints { make in
            make.left.equalTo(baseV.snp.left)
            make.top.equalTo(baseV.snp.top)
            make.width.equalTo(itemW)
        }
        
        let vLine1 = UIView()
        vLine1.backgroundColor = .hex("#ECEEF2")
        baseV.addSubview(vLine1)
        vLine1.snp.makeConstraints { make in
            make.left.equalTo(onlineV.snp.right)
            make.top.equalTo(baseV.snp.top).offset(18)
            make.height.equalTo(30)
            make.width.equalTo(0.5)
        }
        
        baseV.addSubview(completionV)
        completionV.snp.makeConstraints { make in
            make.left.equalTo(onlineV.snp.right)
            make.centerY.equalTo(onlineV.snp.centerY)
            make.width.equalTo(itemW)
        }
        
        let vLine2 = UIView()
        vLine2.backgroundColor = .hex("#ECEEF2")
        baseV.addSubview(vLine2)
        vLine2.snp.makeConstraints { make in
            make.left.equalTo(completionV.snp.right)
            make.top.equalTo(vLine1.snp.top)
            make.bottom.equalTo(vLine1.snp.top)
            make.width.equalTo(0.5)
        }
        
        baseV.addSubview(failureV)
        failureV.snp.makeConstraints { make in
            make.left.equalTo(completionV.snp.right)
            make.centerY.equalTo(onlineV.snp.centerY)
            make.width.equalTo(itemW)
        }
        
        let vLine3 = UIView()
        vLine3.backgroundColor = .hex("#ECEEF2")
        baseV.addSubview(vLine3)
        vLine3.snp.makeConstraints { make in
            make.left.equalTo(failureV.snp.right)
            make.top.equalTo(vLine1.snp.top)
            make.bottom.equalTo(vLine1.snp.top)
            make.width.equalTo(0.5)
        }
        
        baseV.addSubview(maintenanceV)
        maintenanceV.snp.makeConstraints { make in
            make.left.equalTo(failureV.snp.right)
            make.centerY.equalTo(onlineV.snp.centerY)
            make.width.equalTo(itemW)
        }
        
    }
}


public enum DeviceRateEnum: Int {
    case online = 0
    case completion  = 1
    case failure  = 2
    case maintenance  = 3
}

class HomeDeviceModal: NSObject {
    var type: DeviceRateEnum = .online
    var value: String = ""
    
    init(type: DeviceRateEnum, value: String) {
        self.type = type
        self.value = value
    }
}


class HomeDeviceCard: UIView {
    let keyL = UILabel()
    let valueL = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(withModal modal: HomeDeviceModal) {
        switch modal.type {
        case .online:
            keyL.text = "在线率"
            break
        case .completion:
            keyL.text = "完成率"
            break
        case .failure:
            keyL.text = "故障率"
            break
        case .maintenance:
            keyL.text = "维护率"
            break
        }
        valueL.text = "\(modal.value)%"
    }
    
    func setupUI() {
        keyL.textColor = .hex("#95979B")
        keyL.font = .systemFont(ofSize: 14)
        addSubview(keyL)
        keyL.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(16)
            make.centerX.equalToSuperview()
        }
        
        valueL.textColor = .hex("#1C2532")
        valueL.font = .systemFont(ofSize: 17)
        addSubview(valueL)
        valueL.snp.makeConstraints { make in
            make.top.equalTo(keyL.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
    }
}
