//
//  RepairReportTimeView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/28.
//

import Foundation
import UIKit
import AAInfographics

class RRTimeDescItemModal: NSObject {
    var key: String = ""
    var value: Int = 0
    
    init(key: String, value: Int) {
        self.key = key
        self.value = value
    }
}

class RepairReportTimeView: UIScrollView {
    let basicV = UIView.createBase()
    let detailV = UIView.createBase()
    let compCtl = BSArrowControl()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let datas = [
        RRTimeDescItemModal(key: "<2小时", value: 50),
        RRTimeDescItemModal(key: "2-3小时", value: 68),
        RRTimeDescItemModal(key: "3-4小时", value: 38),
        RRTimeDescItemModal(key: "4-5小时", value: 54),
        RRTimeDescItemModal(key: ">5小时", value: 24),
        RRTimeDescItemModal(key: "合计", value: 234),
    ]
    
    func reloadData() {
        
    }
    
    @objc func detailTapped(_ sender: UIButton) {
        getFirstViewController()?.navigationController?.pushViewController(RepairReportTimeDetailVC(), animated: true)
    }

    // MARK: - Setup
    func setupBasicView() {
        addSubview(basicV)
        basicV.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(14)
            make.right.equalToSuperview().offset(-14)
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(ScreenWidth - 28)
            make.height.equalTo(407)
        }
        
        let dateCtl = BSMonthControl()
        dateCtl.layer.borderWidth = 0.5
        dateCtl.layer.cornerRadius = 4
        dateCtl.layer.borderColor = UIColor.hex("#DDDDDD").cgColor
        basicV.addSubview(dateCtl)
        dateCtl.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.top.equalToSuperview().offset(18)
            make.width.equalTo(122)
            make.height.equalTo(46)
        }
        
        compCtl.title = "九安保安服务有限公司"
        compCtl.layer.borderWidth = 0.5
        compCtl.layer.cornerRadius = 4
        compCtl.layer.borderColor = UIColor.hex("#DDDDDD").cgColor
        basicV.addSubview(compCtl)
        compCtl.snp.makeConstraints { make in
            make.right.equalTo(dateCtl.snp.left).offset(-12)
            make.centerY.equalTo(dateCtl.snp.centerY)
            make.left.equalToSuperview().offset(14)
            make.height.equalTo(46)
        }
        
        let datas = ["报修响应", "出发耗时", "到达耗时", "修复耗时"]
        let segmentedC = BSSegmentedControl()
        segmentedC.font = .systemFont(ofSize: 14)
        segmentedC.selectedFont = .systemFont(ofSize: 14)
        segmentedC.selectedBgColors = [.hex("#3C72FF"), .hex("#3C72FF")]
        segmentedC.cornerRadius = 16
        segmentedC.padding = 55
        basicV.addSubview(segmentedC)
        segmentedC.snp.makeConstraints { make in
            make.top.equalTo(compCtl.snp.bottom).offset(16)
            make.left.equalTo(basicV.snp.left).offset(15)
            make.right.equalTo(basicV.snp.right).offset(-12)
            make.height.equalTo(32)
        }
        segmentedC.itemTitles = datas
        segmentedC.currentSelectedIndex = 0
        segmentedC.didSelectItemWith = { (index, title) -> () in

        }
        
        let aaChartView = AAChartView()
        aaChartView.frame = CGRect(x: 30, y: 60, width: ScreenWidth - 80, height: 200)
        addSubview(aaChartView)
        aaChartView.snp.makeConstraints { make in
            make.top.equalTo(segmentedC.snp.bottom).offset(46)
            make.left.equalTo(basicV.snp.left).offset(15)
            make.right.equalTo(basicV.snp.right).offset(-12)
            make.height.equalTo(200)
        }
        
        let gradientColorDic1 = AAGradientColor.linearGradient(
            direction: .toBottom,
            startColor: AARgba(230, 232, 238, 1),
            endColor: AARgba(230, 232, 238, 0.14)
        )

        let aaChartModel = AAChartModel()
            .chartType(.area)
            .categories(["<2小时", "2-3小时", "3-4小时", "4-5小时", ">5小时"])
            .yAxisTitle("")
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
    }
    
    func setupDetailView() {
        addSubview(detailV)
        detailV.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(14)
            make.right.equalToSuperview().offset(-14)
            make.top.equalTo(basicV.snp.bottom).offset(10)
            make.width.equalTo(ScreenWidth - 28)
            make.bottom.equalToSuperview().offset(-40)
        }
        
        let desL = UILabel()
        desL.font = .systemFont(ofSize: 17)
        desL.text = "报修响应统计"
        desL.textAlignment = .center
        detailV.addSubview(desL)
        desL.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview().offset(23)
            make.centerX.equalToSuperview()
        }
        
        let desBgIV = UIImageView(image: UIImage(named: "login_desc"))
        detailV.insertSubview(desBgIV, belowSubview: desL)
        desBgIV.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(desL.snp.centerY)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        let desTitleItem = RRTimeTitleItem()
        detailV.addSubview(desTitleItem)
        desTitleItem.snp.makeConstraints { make in
            make.top.equalTo(desL.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(35)
        }
        
        var lastI: RRTimeDescItem?
        for (index, record) in datas.enumerated() {
            let itemV = RRTimeDescItem()
            itemV.reloadData(withModal: record)
            itemV.detailBtn.addTarget(self, action: #selector(detailTapped), for: .touchUpInside)
            itemV.detailBtn.tag = index
            detailV.addSubview(itemV)
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
        setupBasicView()
        
        setupDetailView()
    }
}
class RRTimeDescItem: UIView {
    let title1L = UILabel()
    let title2L = UILabel()
    let detailBtn = UIButton(type: .custom)
   
    let line = RRTimeLine()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData(withModal modal: RRTimeDescItemModal) {
        title1L.text = modal.key
        title2L.text = "\(modal.value)"
    }

    // MARK: - Setup
    func setupUI() {
        line.topLine.isHidden = true
        addSubview(line)
        line.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(35)
        }
        
        title1L.font = .systemFont(ofSize: 14)
        title1L.textColor = .hex("#8D8E8E")
        addSubview(title1L)
        title1L.snp.makeConstraints { make in
            make.left.equalTo(line.v1Line.snp.right).offset(10)
            make.centerY.equalToSuperview()
        }
        
        title2L.font = .systemFont(ofSize: 14)
        title2L.textColor = .hex("#8D8E8E")
        addSubview(title2L)
        title2L.snp.makeConstraints { make in
            make.left.equalTo(line.v2Line.snp.right).offset(10)
            make.centerY.equalToSuperview()
        }
        
        detailBtn.setTitle("详情", for: .normal)
        detailBtn.setTitleColor(.hex("#3C72FF"), for: .normal)
        detailBtn.titleLabel?.font = .systemFont(ofSize: 14)
        addSubview(detailBtn)
        detailBtn.snp.makeConstraints { make in
            make.left.equalTo(line.v3Line.snp.right).offset(10)
            make.centerY.equalToSuperview()
        }
    }
}

class RRTimeTitleItem: UIView {
    let title1L = UILabel()
    let title2L = UILabel()
    let title3L = UILabel()
   
    let line = RRTimeLine()

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
    func setupUI() {
        line.topLine.isHidden = false
        line.bottomLine.isHidden = false
        addSubview(line)
        line.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(35)
        }
        
        title1L.text = "时间段"
        title1L.font = .systemFont(ofSize: 14)
        addSubview(title1L)
        title1L.snp.makeConstraints { make in
            make.left.equalTo(line.v1Line.snp.right).offset(10)
            make.centerY.equalToSuperview()
        }
        
        title2L.text = "单据数目"
        title2L.font = .systemFont(ofSize: 14)
        addSubview(title2L)
        title2L.snp.makeConstraints { make in
            make.left.equalTo(line.v2Line.snp.right).offset(10)
            make.centerY.equalToSuperview()
        }
        
        title3L.text = "查看详情"
        title3L.font = .systemFont(ofSize: 14)
        addSubview(title3L)
        title3L.snp.makeConstraints { make in
            make.left.equalTo(line.v3Line.snp.right).offset(10)
            make.centerY.equalToSuperview()
        }
    }
}

class RRTimeLine: UIView {
    let v1Line = UIView()
    let v2Line = UIView()
    let v3Line = UIView()
    let topLine = UIView()
    let bottomLine = UIView()

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
    func setupUI() {
        topLine.isHidden = true
        topLine.backgroundColor = .hex("#EBEBEB")
        addSubview(topLine)
        topLine.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        v1Line.backgroundColor = .hex("#EBEBEB")
        addSubview(v1Line)
        v1Line.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(0.5)
        }
        
        v2Line.backgroundColor = .hex("#EBEBEB")
        addSubview(v2Line)
        v2Line.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(v1Line.snp.right).offset(120)
            make.width.equalTo(0.5)
        }
        
        let v4Line = UIView()
        v4Line.backgroundColor = .hex("#EBEBEB")
        addSubview(v4Line)
        v4Line.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(0.5)
        }
        
        v3Line.backgroundColor = .hex("#EBEBEB")
        addSubview(v3Line)
        v3Line.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalTo(v4Line.snp.right).offset(-74)
            make.width.equalTo(0.5)
        }
        
        bottomLine.backgroundColor = .hex("#EBEBEB")
        addSubview(bottomLine)
        bottomLine.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}

