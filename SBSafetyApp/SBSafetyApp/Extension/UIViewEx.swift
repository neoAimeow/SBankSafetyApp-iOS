//
//  UIViewEx.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/15.
//

import Foundation
import UIKit
import Toast_Swift

extension UIView {
    func getFirstViewController() -> UIViewController? {
        for view in sequence(first: self.superview, next: {$0?.superview}) {
            if let responder = view?.next {
                if responder.isKind(of: UIViewController.self) {
                    return responder as? UIViewController
                }
            }
        }
        return nil
    }
    
    func removeAllSubViews() {
        for v in self.subviews {
            v.removeFromSuperview()
        }
    }
    
    func showToast(witMsg msg: String? = "未知错误", duration: TimeInterval? = 2) {
        var style = ToastStyle()
        style.messageAlignment = .center
        style.messageNumberOfLines = 0
        style.horizontalPadding = 26
        style.maxWidthPercentage = 0.5
                
        self.makeToast(msg, duration: duration!, point: CGPoint(x: ScreenWidth/2, y: ScreenHeight/2), title: nil, image: nil, style: style) { didTap in
        }
    }
    
    func showToastActivity() {
        self.makeToastActivity(.center)
    }
    
    class func createLine()-> UIView {
        let view = UIView()
        view.backgroundColor = .hex("#E0E0E0")
        return view
    }
    
    class func createLightLine()-> UIView {
        let view = UIView()
        view.backgroundColor = .hex("#F5F5F5")
        return view
    }
    
    func makeCorner(corner: UIRectCorner, radii: CGFloat){
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corner, cornerRadii: CGSize(width: radii, height: radii))
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
    
    // MARK: - 绘制背景
    func drawBG(_ colors: [CGColor] = [UIColor.hex("#FEAC74").cgColor, UIColor.hex("#E97745").cgColor], direction: BSGLDirection = .toBottom) {
        
        var startPoint: CGPoint
        var endPoint: CGPoint
        
        switch direction {
        case .toLeft:
            startPoint = CGPoint(x: 1.0, y: 0.5)
            endPoint = CGPoint(x: 0.0, y: 0.5)
            break
        case .toRight:
            startPoint = CGPoint(x: 0.0, y: 0.5)
            endPoint = CGPoint(x: 1.0, y: 0.5)
            break
        case .toTop:
            startPoint = CGPoint(x: 0.5, y: 1.0)
            endPoint = CGPoint(x: 0.5, y: 0.0)
            break
        case .toBottom:
            startPoint = CGPoint(x: 0.5, y: 0.0)
            endPoint = CGPoint(x: 0.5, y: 1.0)
            break
        case .toBottomLeft:
            startPoint = CGPoint(x: 1.0, y: 0.0)
            endPoint = CGPoint(x: 0.0, y: 1.0)
            break
        case .toBottomRight:
            startPoint = CGPoint(x: 0.0, y: 0.0)
            endPoint = CGPoint(x: 1.0, y: 1.0)
            break
        case .toTopLeft:
            startPoint = CGPoint(x: 1.0, y: 1.0)
            endPoint = CGPoint(x: 0.0, y: 0.0)
            break
        case .toTopRight:
            startPoint = CGPoint(x: 0.0, y: 1.0)
            endPoint = CGPoint(x: 1.0, y: 0.0)
            break
        }
        
        // 绘制进度条渐变层
        let p_linear = CAGradientLayer()
        p_linear.frame = bounds
        p_linear.colors = colors
        p_linear.startPoint = startPoint
        p_linear.endPoint = endPoint
        self.layer.addSublayer(p_linear)
    }
}
