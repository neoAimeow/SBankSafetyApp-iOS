//
//  UIImageEx.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/14.
//

import Foundation
import UIKit

public enum BSGLDirection {
    case toLeft
    case toRight
    case toTop
    case toBottom
    case toBottomLeft
    case toBottomRight
    case toTopLeft
    case toTopRight
}

public extension UIImage {
    convenience init?(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        let rect = CGRect(origin: CGPoint.zero, size: size)
        UIRectFill(rect)
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            return nil
        }
        
        self.init(cgImage: image)
        
        defer { UIGraphicsEndImageContext() }
    }
    
    convenience init?(size: CGSize, direction: BSGLDirection, colors: [UIColor]) {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil } // If the size is zero, the context will be nil.
        
        guard colors.count >= 1 else { return nil } // If less than 1 color, return nil
        
        if colors.count == 1 {
            // Mono color
            let color = colors.first!
            color.setFill()
            
            let rect = CGRect(origin: CGPoint.zero, size: size)
            UIRectFill(rect)
        }
        else {
            // Gradient color
//            var location: CGFloat = 0
            var locations: [CGFloat] = []
            
            for (index, _) in colors.enumerated() {
                let index = CGFloat(index)
                locations.append(index / CGFloat(colors.count - 1))
            }
            
            guard let gradient = CGGradient(colorSpace: CGColorSpaceCreateDeviceRGB(), colorComponents: colors.compactMap { $0.cgColor.components }.flatMap { $0 }, locations: locations, count: colors.count) else {
                return nil
            }
            
            var startPoint: CGPoint
            var endPoint: CGPoint
            
            switch direction {
            case .toLeft:
                startPoint = CGPoint(x: size.width, y: size.height/2)
                endPoint = CGPoint(x: 0.0, y: size.height/2)
                break
            case .toRight:
                startPoint = CGPoint(x: 0.0, y: size.height/2)
                endPoint = CGPoint(x: size.width, y: size.height/2)
                break
            case .toTop:
                startPoint = CGPoint(x: size.width/2, y: size.height)
                endPoint = CGPoint(x: size.width/2, y: 0.0)
                break
            case .toBottom:
                startPoint = CGPoint(x: size.width/2, y: 0.0)
                endPoint = CGPoint(x: size.width/2, y: size.height)
                break
            case .toBottomLeft:
                startPoint = CGPoint(x: size.width, y: 0.0)
                endPoint = CGPoint(x: 0.0, y: size.height)
                break
            case .toBottomRight:
                startPoint = CGPoint(x: 0.0, y: 0.0)
                endPoint = CGPoint(x: size.width, y: size.height)
                break
            case .toTopLeft:
                startPoint = CGPoint(x: size.width, y: size.height)
                endPoint = CGPoint(x: 0.0, y: 0.0)
                break
            case .toTopRight:
                startPoint = CGPoint(x: 0.0, y: size.height)
                endPoint = CGPoint(x: size.width, y: 0.0)
                break
            }
            
            context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: CGGradientDrawingOptions())
        }
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            return nil
        }
        
        self.init(cgImage: image)
        
        defer { UIGraphicsEndImageContext() }
    }
    
    class func imageFromLayer(_ layer: CALayer) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0)
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
            guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
                return nil
            }
            
            UIGraphicsEndImageContext()
            return image
        }
        return nil
    }
    
    class func base64ToImage(_ bs64: String?) -> UIImage? {
        let imgStr = bs64?.replacingOccurrences(of:"data:image/png;base64,",with:"")
        if imgStr != nil {
            let base64Data = Data(base64Encoded: imgStr!, options: Data.Base64DecodingOptions.init(rawValue: 0))
            if base64Data != nil {
                let img = UIImage(data: base64Data!)
                return img
            }
        }
        return nil
    }
    
    func imgToBase64() -> String? {
        let imgStr = self.pngData()?.base64EncodedString()
        return imgStr
    }
}
