//
//  Utils.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/14.
//

import Foundation
import UIKit
import CoreData

let UserLogined = "UserLogined"
let SafetyToken = "SafetyToken"
let SafetyUserRole = "UserRole"
let SafetyUserInfo = "UserInfo"

let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height

let PageSize: Int64 = 10

class Utils {
    class func delay(second: TimeInterval = 1.0, complete: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + second) {
            complete()
        }
    }

    static var app: AppDelegate {
        let app = UIApplication.shared.delegate as! AppDelegate
        return app
    }

    static var context: NSManagedObjectContext {
        let context = app.persistentContainer.viewContext
        return context
    }

    class func exitApp(msg: String? = "未知错误") {
        exitApp()
        app.window?.showToast(witMsg: msg)
    }
    
    class func exitApp() {
        UserDefaults.standard.set(nil, forKey: SafetyToken)
        UserDefaults.standard.set(nil, forKey: SafetyUserRole)
        Utils.app.setupUI()
    }

    // 获取拼音首字母（大写字母）

    class func findFirstLetter(fromString aString: String) -> String {
        let mutableString = NSMutableString.init(string: aString)
        CFStringTransform(mutableString as CFMutableString, nil, kCFStringTransformToLatin, false)
        let pinyinString = mutableString.folding(options: String.CompareOptions.diacriticInsensitive, locale: NSLocale.current)
        let strPinYin = polyphoneStringHandle(nameString: aString, pinyinString: pinyinString).uppercased()
        let firstString = "\(strPinYin.prefix(1))"
        let regexA = "^[A-Z]$"
        let predA = NSPredicate.init(format: "SELF MATCHES %@", regexA)
        return predA.evaluate(with: firstString) ? firstString : "#"
    }

    // 多音字处理

    class func polyphoneStringHandle(nameString: String, pinyinString: String) -> String {
        if nameString.hasPrefix("长") {
            return "chang"
        }
        if nameString.hasPrefix("沈") {
            return "shen"
        }
        if nameString.hasPrefix("厦") {
            return "xia"
        }
        if nameString.hasPrefix("地") {
            return "di"
        }
        if nameString.hasPrefix("重") {
            return "chong"
        }
        return pinyinString
    }
}
