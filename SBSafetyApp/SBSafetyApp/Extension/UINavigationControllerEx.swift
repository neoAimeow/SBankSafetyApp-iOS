//
//  UINavigationControllerEx.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/16.
//

import Foundation
import UIKit

enum NavigationBarStyle {
    case theme   /// navbar APP主题
    case clear   /// navbar 透明
    case white   /// navbar 白色
    case custom  /// 自定义
}

extension UINavigationController {
    func navBarStyle(_ style:NavigationBarStyle, bg: String = "#FEFAF9", alpha: CGFloat = 1) {
        switch style {
        case .theme:
            navigationBar.barStyle = .default
            let attrDic = [NSAttributedString.Key.foregroundColor: UIColor.white,
                           NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium)]
            
            let barApp = UINavigationBarAppearance()
            barApp.configureWithOpaqueBackground()
            barApp.backgroundColor = .primary
            barApp.backgroundEffect = nil
            barApp.shadowColor = nil
            barApp.titleTextAttributes = attrDic
            navigationBar.shadowImage = UIImage()
            navigationBar.scrollEdgeAppearance = barApp
            navigationBar.standardAppearance = barApp
            // 透明设置
            navigationBar.isTranslucent = true
            navigationBar.tintColor = .white
            break
        case .clear:
            navigationBar.barStyle = .default
            let barApp = UINavigationBarAppearance()
            barApp.configureWithOpaqueBackground()
            barApp.backgroundEffect = nil
            barApp.shadowColor = nil
            navigationBar.shadowImage = UIImage()
            navigationBar.scrollEdgeAppearance = nil
            navigationBar.standardAppearance = barApp
            // 透明设置
            navigationBar.isTranslucent = true
            navigationBar.tintColor = .black
            break
        case .white:
            let barApp = UINavigationBarAppearance()
            barApp.configureWithOpaqueBackground()
            barApp.backgroundColor = .white
            barApp.backgroundEffect = nil
            barApp.shadowColor = nil
            navigationBar.shadowImage = UIImage()
            navigationBar.scrollEdgeAppearance = barApp
            navigationBar.standardAppearance = barApp
            navigationBar.isTranslucent = true
            navigationBar.tintColor = .black
            break
        case .custom:
            navigationBar.barStyle = .default
            let attrDic = [NSAttributedString.Key.foregroundColor: UIColor.white,
                           NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium)]
            
            let barApp = UINavigationBarAppearance()
            barApp.configureWithOpaqueBackground()
            barApp.backgroundColor = .hex(bg)
            barApp.backgroundEffect = nil
            barApp.shadowColor = nil
            barApp.titleTextAttributes = attrDic
            navigationBar.shadowImage = UIImage()
            navigationBar.scrollEdgeAppearance = barApp
            navigationBar.standardAppearance = barApp
            // 透明设置
            navigationBar.isTranslucent = true
            navigationBar.tintColor = .white
            break
        }
    }
}
