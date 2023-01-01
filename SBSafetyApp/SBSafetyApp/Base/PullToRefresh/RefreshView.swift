//
//  RefreshView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/1.
//

import Foundation
import UIKit

class RefreshView: UIView {
    
    fileprivate(set) lazy var activityIndicator: UIActivityIndicatorView! = {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        self.addSubview(activityIndicator)
        return activityIndicator
    }()

    override func layoutSubviews() {
        centerActivityIndicator()
        setupFrame(in: superview)
        
        super.layoutSubviews()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        centerActivityIndicator()
        setupFrame(in: superview)
    }
}

private extension RefreshView {
    
    func setupFrame(in newSuperview: UIView?) {
        guard let superview = newSuperview else { return }

        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: superview.frame.width, height: frame.height)
    }
    
     func centerActivityIndicator() {
        activityIndicator.center = convert(center, from: superview)
    }
}
