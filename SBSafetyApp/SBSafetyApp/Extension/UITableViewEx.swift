//
//  UITableViewEx.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/17.
//

import Foundation
import UIKit

extension UITableView {
    func tableShowEmpty(withDataCount count: Int) {
        if count == 0 {
            self.backgroundView = EmptyView()
        } else {
            self.backgroundView = nil;
        }
    }
    
    func setCornerRadiusSection(radius: CGFloat = 10.0, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cornerRadius = radius
        let sectionCount = self.numberOfRows(inSection: indexPath.section)
        cell.layer.mask = nil
        if sectionCount > 1 {
            switch indexPath.row {
            case 0:
                cell.makeCorner(corner: [.topLeft,.topRight], radii: cornerRadius)
            case sectionCount - 1:
                cell.makeCorner(corner: [.bottomLeft,.bottomRight], radii: cornerRadius)
            default: break
            }
        }
        else {
            cell.makeCorner(corner: [.allCorners], radii: cornerRadius)
        }
    }
}
