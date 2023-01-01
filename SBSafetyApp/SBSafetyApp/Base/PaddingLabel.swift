//
//  PaddingLabel.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/17.
//

import Foundation
import UIKit

class PaddingLabel: UILabel {
    var _insets : UIEdgeInsets = UIEdgeInsets.zero
    var insets: UIEdgeInsets {
        get { return _insets }
        set {
            _insets = newValue
            self.layoutSubviews()
        }
    }
    
    override func drawText(in rect: CGRect) {
        var actRect = rect.inset(by: self.insets)
        if numberOfLines == 0 {
            actRect = textRect(forBounds: rect.inset(by: self.insets), limitedToNumberOfLines: numberOfLines)
        }
        super.drawText(in: actRect)
    }
    
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize;
        size.width += (self.insets.left + self.insets.right)
        size.height += (self.insets.top + self.insets.bottom)
        return size
    }
}
