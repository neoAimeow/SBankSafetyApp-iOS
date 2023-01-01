//
//  UIColorEx.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/14.
//

import Foundation
import UIKit

extension UIColor {
    class func hex(_ val: String) -> UIColor {
        return UIColor.hex(val, alpha: 1)
    }
    
    class func hex(_ val: String, alpha: Float) -> UIColor {
            
        var cStr = val.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased() as NSString;
        
        if(cStr.length < 6){
            return UIColor.clear;
        }
        
        if(cStr.hasPrefix("0x")){
            cStr = cStr.substring(from: 2) as NSString
        }
        
        if(cStr.hasPrefix("#")){
            cStr = cStr.substring(from: 1) as NSString
        }
        
        if(cStr.length != 6){
            return UIColor.clear
        }
        
        let rStr = (cStr as NSString).substring(to: 2)
        let gStr = ((cStr as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bStr = ((cStr as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r: UInt64 = 0x0
        var g: UInt64 = 0x0
        var b: UInt64 = 0x0
        
        Scanner.init(string: rStr).scanHexInt64(&r)
        Scanner.init(string: gStr).scanHexInt64(&g)
        Scanner.init(string: bStr).scanHexInt64(&b)
        
        return UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(alpha));
        
    }
    
    public class var primary: UIColor { get { return .hex("#0F499E") } }
    public class var primaryH: UIColor { get { return .hex("#0F499E").withAlphaComponent(0.8) } }
    public class var primaryDis: UIColor { get { return .hex("#0F499E").withAlphaComponent(0.6) } }
    
    public class var pmGray: UIColor { get { return .hex("#9AA2B3") } }
    public class var pmB3: UIColor { get { return .hex("#B3B3B3") } }

    public class var unTint: UIColor { get { return .hex("#777777") } }
    
    public class var bg: UIColor { get { return .hex("#F8F8F8") } }
    
    class var randomColor: UIColor {
        get
        {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
    
    class var randomLightColor: UIColor {
        get {
            return UIColor(red: .random(in: 0.7...1), green: .random(in: 0.5...1), blue: .random(in: 0.3...1), alpha: 1.0)
//            let red = CGFloat(min(arc4random() % 76 + 180, 225)) / 255.0
//            let green = CGFloat(min(arc4random() % 36 + 140, 256)) / 255.0
//            let blue = CGFloat(min(arc4random() % 36 + 120, 220)) / 255.0
//            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}
