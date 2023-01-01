//
//  InspResultStatisticsView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/25.
//

import Foundation
import UIKit

class InspResultStaticModal: NSObject {
    var key: String = ""
    var val: String = ""
    var percent: String?
    
    init(key: String, val: String, percent: String? = nil) {
        self.key = key
        self.val = val
        self.percent = percent
    }
}

class InspResultStatisticsView: UIView {
    let gauge = GaugeMeter(frame: CGRect(x: 0, y: 0, width: 100, height: 82))

    let successV = InspResultItemView()
    let error1V = InspResultItemView()
    let error2V = InspResultItemView()
    
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
        
    func reloadUI(withData data: CountItemModal?) {
        gauge.countL.text = "\(24)"
        
        /**
         ycwcl = 1;
         ycycl = 0;
         ycycll = 0;
         ycywll = "4.17";
         zc = 23;
         zcl = "95.83";
         zs = 24;
         
         */
        
        successV.updateUI(withModal: InspResultStaticModal(key: "正常", val: "\(data?.zc ?? 0)", percent: "\(data?.zcl ?? "0")%"))
        error1V.updateUI(withModal: InspResultStaticModal(key: "异常已处理", val: "\(data?.ycycl ?? 0)", percent: "\(data?.ycycll ?? "0")%"))
        error2V.updateUI(withModal: InspResultStaticModal(key: "异常未处理", val: "\(data?.ycwcl ?? 0)", percent: "\(data?.ycywll ?? "0")%"))
    }

    // MARK: - Setup
    func setupUI() {
        let staticTitle = InspStatusTitle(withIcon: "ic_report_2", name: "单项巡检结果统计")
        addSubview(staticTitle)
        staticTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(21)
        }
        
        addSubview(gauge)
        gauge.snp.makeConstraints { make in
            make.top.equalTo(staticTitle.snp.bottom).offset(53)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(82)
            make.width.equalTo(100)
        }
        
        let placeV = InspResultItemView()
        placeV.keyL.textColor = .hex("#9DA4B9")
        placeV.valL.textColor = .hex("#9DA4B9")
        placeV.updateUI(withModal: InspResultStaticModal(key: "单项巡检结果", val: "巡检项数目"))
        addSubview(placeV)
        placeV.snp.makeConstraints { make in
            make.top.equalTo(staticTitle.snp.bottom).offset(50)
            make.left.equalTo(gauge.snp.right).offset(42)
            make.height.equalTo(23)
        }

        successV.keyL.text = "正常"
        addSubview(successV)
        successV.snp.makeConstraints { make in
            make.top.equalTo(placeV.snp.bottom)
            make.left.equalTo(placeV.snp.left)
            make.height.equalTo(placeV.snp.height)
        }
        
        error1V.keyL.text = "异常已处理"
        addSubview(error1V)
        error1V.snp.makeConstraints { make in
            make.top.equalTo(successV.snp.bottom)
            make.left.equalTo(placeV.snp.left)
            make.height.equalTo(placeV.snp.height)
        }
        
        error2V.keyL.text = "异常未处理"
        addSubview(error2V)
        error2V.snp.makeConstraints { make in
            make.top.equalTo(error1V.snp.bottom)
            make.left.equalTo(placeV.snp.left)
            make.height.equalTo(placeV.snp.height)
        }
    }
}

class InspResultItemView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(withModal modal: InspResultStaticModal) {
        keyL.text = modal.key
        if modal.percent != nil {
            valL.text = "\(modal.val) (\(modal.percent!))"
        } else {
            valL.text = modal.val
        }
    }

    // MARK: - Setup
    
    func setupUI() {
        addSubview(keyL)
        keyL.snp.makeConstraints { make in
            make.left.centerY.equalToSuperview()
            make.width.equalTo(88)
        }
        
        addSubview(valL)
        valL.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(keyL.snp.right)
        }
    }
    
    lazy var keyL: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 13)
        l.textColor = .hex("#626E8E")
        return l
    }()
    
    lazy var valL: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 13)
        l.textColor = .hex("#626E8E")
        return l
    }()
    
}


class GaugeMeter: UIView {
    let countL = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let diameter: CGFloat = 100            // 进度条所在圆的直径
        let lineWidth: CGFloat = 10            // 进度条线条宽度
        // 轨道以及上面进度条的路径（在组件内部水平居中）
        let path = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: 50), radius: (diameter-lineWidth)/2,
                                startAngle: toRadians(degrees: -210),
                                endAngle: toRadians(degrees: 30),
                                clockwise: true)
        
        // 绘制进度条背景轨道
        let trackLayer = CAShapeLayer()
        trackLayer.frame = self.bounds
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = UIColor.hex("#FAFAFA").cgColor // 设置轨道颜色
        trackLayer.lineCap = CAShapeLayerLineCap.round // 轨道使用圆角线条
        trackLayer.lineWidth = lineWidth // 轨道线条的宽度
        trackLayer.path = path.cgPath // 设置轨道路径
        trackLayer.strokeEnd = 1
        layer.addSublayer(trackLayer)
        
        // 绘制进度条渐变层
        let p_linear = CAGradientLayer()
        p_linear.frame = CGRect(x: 0, y: 0, width: frame.width, height: diameter/4 * 3 + lineWidth)
        p_linear.colors = [UIColor.hex("#FF9D8D").cgColor, UIColor.hex("#FF6E57").cgColor]
        p_linear.startPoint = CGPoint(x: 0, y: 0.5)
        p_linear.endPoint = CGPoint(x: 1, y: 0.5)
        layer.addSublayer(p_linear)
        p_linear.mask = trackLayer
            
        let keyL = UILabel()
        keyL.textAlignment = .center
        keyL.font = .systemFont(ofSize: 14)
        keyL.text = "巡检项"
        addSubview(keyL)
        keyL.snp.makeConstraints { make in
            make.bottom.centerX.equalToSuperview()
        }
        
        countL.text = "3826"
        countL.textAlignment = .center
        countL.font = .systemFont(ofSize: 18)
        countL.textColor = .hex("#FF6E57")
        addSubview(countL)
        countL.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(4)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 把角度转换成弧度
    func toRadians(degrees:CGFloat) -> CGFloat {
       return .pi*(degrees) / 180.0
    }
}
