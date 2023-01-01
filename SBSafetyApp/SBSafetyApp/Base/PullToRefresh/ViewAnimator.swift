//
//  ViewAnimator.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/1.
//

import Foundation

public enum State: Equatable, CustomStringConvertible {
    
    case initial
    case releasing(progress: CGFloat)
    case loading
    case finished
    
    public var description: String {
        switch self {
        case .initial: return "Inital"
        case .releasing(let progress): return "Releasing:\(progress)"
        case .loading: return "Loading"
        case .finished: return "Finished"
        }
    }
}

public func ==(a: State, b: State) -> Bool {
    switch (a, b) {
    case (.initial, .initial): return true
    case (.loading, .loading): return true
    case (.finished, .finished): return true
    case (.releasing, .releasing): return true
    default: return false
    }
}

public typealias PullToRefreshState = State

public protocol RefreshViewAnimator {
    func animate(_ state: State)
}

class ViewAnimator: RefreshViewAnimator {
    
    fileprivate let refreshView: RefreshView
    
    init(refreshView: RefreshView) {
        self.refreshView = refreshView
    }
    
    func animate(_ state: State) {
        switch state {
        case .initial:
            refreshView.activityIndicator.stopAnimating()
            break
        case .releasing(let progress):
            transform(to: progress)
            break
        case .loading:
            transform(to: 1.0)
            refreshView.activityIndicator.startAnimating()
            break
        default: break
        }
    }
    
    private func transform(to progress: CGFloat) {
        refreshView.activityIndicator.isHidden = false
        
        var transform = CGAffineTransform.identity
        transform = transform.scaledBy(x: progress, y: progress)
        transform = transform.rotated(by: CGFloat(Double.pi) * progress * 2)
        refreshView.activityIndicator.transform = transform
    }
}
