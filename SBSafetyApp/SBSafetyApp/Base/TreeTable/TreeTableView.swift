//
//  TreeTableView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/16.
//

import Foundation
import UIKit

protocol TreeTableViewDataSource: AnyObject {
  func configureNodes() -> [Node]
}

protocol TreeTableViewDelegate: UIScrollViewDelegate {
  // MARK: Required Methods
  func treeTableView(_ treeTableView: TreeTableView, cellForRowAt indexPath: IndexPath, node: Node) -> UITableViewCell

  // MARK: Optional Methods
  func treeTableView(_ treeTableView: TreeTableView, didSelectRowAt indexPath: IndexPath, node: Node)
  func treeTableView(_ treeTableView: TreeTableView, didExpandRowAt indexPath: IndexPath, node: Node)
  func treeTableView(_ treeTableView: TreeTableView, didCollapseRowAt indexPath: IndexPath, node: Node)
  func treeTableView(_ treeTableView: TreeTableView, heightForRowAt indexPath: IndexPath) -> CGFloat
  func treeTableView(_ treeTableView: TreeTableView, titleForHeaderInSection section: Int) -> String?
  func treeTableView(_ treeTableView: TreeTableView, heightForHeaderInSection section: Int) -> CGFloat
  func treeTableView(_ treeTableView: TreeTableView, viewForHeaderInSection section: Int) -> UIView?
  func treeTableView(_ treeTableView: TreeTableView, heightForFooterInSection section: Int) -> CGFloat
  func treeTableView(_ treeTableView: TreeTableView, viewForFooterInSection section: Int) -> UIView?
  func treeTableView(_ treeTableView: TreeTableView, titleForFooterInSection section: Int) -> String?
  func treeTableView(_ treeTableView: TreeTableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
  func treeTableView(_ treeTableView: TreeTableView, didEndDisplaying cell: UITableViewCell, forRow indexPath: IndexPath)
  func treeTableView(_ treeTableView: TreeTableView, willDisplayHeaderView view: UIView, forSection section: Int)
  func treeTableView(_ treeTableView: TreeTableView, willDisplayFooterView view: UIView, forSection section: Int)
  func treeTableView(_ treeTableView: TreeTableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool
  func treeTableView(_ treeTableView: TreeTableView, didHighlightRowAt indexPath: IndexPath)
  func treeTableView(_ treeTableView: TreeTableView, didUnhighlightRowAt indexPath: IndexPath)
}

extension TreeTableViewDelegate {
  func treeTableView(_ treeTableView: TreeTableView, didSelectRowAt indexPath: IndexPath, node: Node) { }
  func treeTableView(_ treeTableView: TreeTableView, didExpandRowAt indexPath: IndexPath, node: Node) { }
  func treeTableView(_ treeTableView: TreeTableView, didCollapseRowAt indexPath: IndexPath, node: Node) { }
  func treeTableView(_ treeTableView: TreeTableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return UITableView.automaticDimension }
  func treeTableView(_ treeTableView: TreeTableView, titleForHeaderInSection section: Int) -> String? { return nil }
  func treeTableView(_ treeTableView: TreeTableView, heightForHeaderInSection section: Int) -> CGFloat { return 0 }
  func treeTableView(_ treeTableView: TreeTableView, viewForHeaderInSection section: Int) -> UIView? { return nil }
  func treeTableView(_ treeTableView: TreeTableView, heightForFooterInSection section: Int) -> CGFloat { return 0 }
  func treeTableView(_ treeTableView: TreeTableView, viewForFooterInSection section: Int) -> UIView? { return nil }
  func treeTableView(_ treeTableView: TreeTableView, titleForFooterInSection section: Int) -> String? { return nil }
  func treeTableView(_ treeTableView: TreeTableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) { }
  func treeTableView(_ treeTableView: TreeTableView, didEndDisplaying cell: UITableViewCell, forRow indexPath: IndexPath) { }
  func treeTableView(_ treeTableView: TreeTableView, willDisplayHeaderView view: UIView, forSection section: Int) { }
  func treeTableView(_ treeTableView: TreeTableView, willDisplayFooterView view: UIView, forSection section: Int) { }
  func treeTableView(_ treeTableView: TreeTableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool { return true }
  func treeTableView(_ treeTableView: TreeTableView, didHighlightRowAt indexPath: IndexPath) { }
  func treeTableView(_ treeTableView: TreeTableView, didUnhighlightRowAt indexPath: IndexPath) { }
}

class TreeTableView: UITableView {

  weak var treeDataSource: TreeTableViewDataSource? {
    didSet {
      self.dataSource = self
      guard let dataSource = treeDataSource else { return }
      let nodes = dataSource.configureNodes()
      processor.nodes = nodes
    }
  }
  weak var treeDelegate: TreeTableViewDelegate? {
    didSet {
      self.delegate = self
    }
  }
  private let processor = TreeTableProcessor()

}

//MARK: - UITableViewDataSource implementationn
extension TreeTableView: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    guard treeDelegate != nil else { return 0 }
    return processor.processedNodes.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard treeDelegate != nil else { return 0 }
    return 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let delegate = treeDelegate else { fatalError("treeDelegate must not be nil") }
    let node = processor.processedNodes[indexPath.section]
    return delegate.treeTableView(self, cellForRowAt: indexPath, node: node)
  }
}

//MARK: - UITableViewDelegate implementationn
extension TreeTableView: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let delegate = treeDelegate else { return }
    let node = processor.processedNodes[indexPath.section]
    guard !processor.isLeafNode(node: node) else {
      delegate.treeTableView(self, didSelectRowAt: indexPath, node: node)
      return
    }
    guard node.isExpand else {
      processor.clearIndexPathsToInsert()
      processor.insertChildNode(node: node)
      var indexSet = IndexSet()
      processor.indexPathsToInsert.forEach { indexSet.update(with: $0.section) }
//      CATransaction.begin()
//      CATransaction.setCompletionBlock {
//        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
//      }
      tableView.insertSections(indexSet, with: .top)
//      CATransaction.commit()
      delegate.treeTableView(self, didExpandRowAt: indexPath, node: node)
      return
    }
    processor.clearIndexPathsToDelete()
    processor.deleteChildNode(node: node)
    var indexSet = IndexSet()
    processor.indexPathsToDelete.forEach { indexSet.update(with: $0.section) }
    tableView.deleteSections(indexSet, with: .top)
    delegate.treeTableView(self, didCollapseRowAt: indexPath, node: node)
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    guard let delegate = treeDelegate else { return UITableView.automaticDimension }
    return delegate.treeTableView(self, heightForRowAt: indexPath)
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    guard let delegate = treeDelegate else { return nil }
    return delegate.treeTableView(self, titleForHeaderInSection: section)
  }

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    guard let delegate = treeDelegate else { return 0 }
    return delegate.treeTableView(self, heightForHeaderInSection: section)
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let delegate = treeDelegate else { return nil }
    return delegate.treeTableView(self, viewForHeaderInSection: section)
  }

  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    guard let delegate = treeDelegate else { return 0 }
    return delegate.treeTableView(self, heightForFooterInSection: section)
  }

  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    guard let delegate = treeDelegate else { return nil }
    return delegate.treeTableView(self, viewForFooterInSection: section)
  }
  func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    guard let delegate = treeDelegate else { return nil }
    return delegate.treeTableView(self, titleForFooterInSection: section)
  }

  @objc(tableView:willDisplayCell:forRowAtIndexPath:) func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard let delegate = treeDelegate else { return }
    delegate.treeTableView(self, willDisplay: cell, forRowAt: indexPath)
  }

  func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard let delegate = treeDelegate else { return }
    delegate.treeTableView(self, didEndDisplaying: cell, forRow: indexPath)
  }

  func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    guard let delegate = treeDelegate else { return }
    return delegate.treeTableView(self, willDisplayHeaderView: view, forSection: section)
  }

  func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
    guard let delegate = treeDelegate else { return }
    return delegate.treeTableView(self, willDisplayFooterView: view, forSection: section)
  }

  func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
    guard let delegate = treeDelegate else { return false }
    return delegate.treeTableView(self, shouldHighlightRowAt: indexPath)
  }

  func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
    guard let delegate = treeDelegate else { return }
    return delegate.treeTableView(self, didHighlightRowAt: indexPath)
  }

  func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
    guard let delegate = treeDelegate else { return }
    return delegate.treeTableView(self, didUnhighlightRowAt: indexPath)
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    treeDelegate?.scrollViewDidScroll?(scrollView)
  }

  func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
    treeDelegate?.scrollViewDidScrollToTop?(scrollView)
  }

  func scrollViewDidZoom(_ scrollView: UIScrollView) {
    treeDelegate?.scrollViewDidZoom?(scrollView)
  }
  func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
    treeDelegate?.scrollViewWillBeginZooming?(scrollView, with: view)
  }

  func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
    treeDelegate?.scrollViewDidEndZooming?(scrollView, with: view, atScale: scale)
  }

  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    treeDelegate?.scrollViewWillBeginDragging?(scrollView)
  }
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    treeDelegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
  }

  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    treeDelegate?.scrollViewWillEndDragging?(scrollView, withVelocity:velocity, targetContentOffset: targetContentOffset)
  }

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    treeDelegate?.scrollViewDidEndDecelerating?(scrollView)
  }

  func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    treeDelegate?.scrollViewDidEndScrollingAnimation?(scrollView)
  }

  func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
    treeDelegate?.scrollViewWillBeginDecelerating?(scrollView)
  }

  func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
    return treeDelegate?.scrollViewShouldScrollToTop?(scrollView) ?? false
  }

  func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
    treeDelegate?.scrollViewDidChangeAdjustedContentInset?(scrollView)
  }
}
