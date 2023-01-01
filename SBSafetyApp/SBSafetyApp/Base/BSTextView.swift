//
//  BSTextView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/23.
//

import Foundation
import UIKit

class BSTextView: UITextView {

    var placeholder: String?
    var placeColor: UIColor? = .hex("#A5A5A5")
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.font = UIFont.systemFont(ofSize: 13)
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        if self.hasText {
            return
        }
        
        let attrs: [NSAttributedString.Key : Any] = [.foregroundColor: self.placeColor as Any, .font: self.font!]
        
        var rect1 = rect
        rect1.origin.x = 12
        rect1.origin.y = 10
        rect1.size.width = rect1.size.width - 2 * rect1.origin.x
        (self.placeholder! as NSString).draw(in: rect1, withAttributes: attrs)
    }
    
    @objc func textDidChange(_ note: Notification) {
        self.setNeedsDisplay()
    }
}
