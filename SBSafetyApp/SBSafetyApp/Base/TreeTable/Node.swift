//
//  Node.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/16.
//

import Foundation

final public class Node {

  public var parentNode: Node? {
    didSet {
      if let parentNode = parentNode, !parentNode.subNodes.contains(self) {
        parentNode.subNodes.append(self)
      }
    }
  }

  public var subNodes: [Node] = [] {
    didSet {
      subNodes.forEach {
        $0.parentNode = self
      }
    }
  }

  public var isLeaf: Bool {
    return subNodes.isEmpty
  }

  public let id: Int64
  public let name: String
  public private(set) var isExpand: Bool
  public var depth: Int {
    if let parentNode = parentNode {
      return parentNode.depth + 1
    }
    return 0
  }

  public init(id: Int64, name: String, isExpand: Bool = false) {
    self.id = id
    self.name = name
    self.isExpand = isExpand
  }

  public func addChildNode(childNode: Node) {
    childNode.parentNode = self
  }

  public func expand() {
    isExpand = true
  }

  public func collaps() {
    isExpand = false
  }

}

extension Node: Equatable {
  public static func == (lhs: Node, rhs: Node) -> Bool {
    return lhs.id == rhs.id
  }
}
