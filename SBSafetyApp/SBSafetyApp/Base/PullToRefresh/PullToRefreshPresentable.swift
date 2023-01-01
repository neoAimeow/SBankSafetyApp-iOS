//
//  PullToRefreshPresentable.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/1.
//

import Foundation
import UIKit

protocol PullToRefreshPresentable: AnyObject {
    func loadAction()
    func reloadAction()
    func setupPullToRefresh(on scrollView: UIScrollView, bottomRefreshing isRefreshing: Bool?)
}

// MARK: - PullToRefresh

extension PullToRefreshPresentable {
    func setupPullToRefresh(on scrollView: UIScrollView, bottomRefreshing isRefreshing: Bool? = true) {
        scrollView.addPullToRefresh(PullToRefresh()) {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) { [weak self, weak scrollView] in
                self?.reloadAction()
                scrollView?.endRefreshing(at: .top)
            }
        }

        if let isRefreshing {
            if (isRefreshing) {
                scrollView.addPullToRefresh(PullToRefresh(position: .bottom)) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) { [weak self, weak scrollView] in
                        self?.loadAction()
                        scrollView?.endRefreshing(at: .bottom)
                    }
                }
            }
        }
    }

    func loadAction() {
    }

    func reloadAction() {
    }
}
