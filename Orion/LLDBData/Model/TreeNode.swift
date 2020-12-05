//
//  TreeNode.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/12/5.
//

import Foundation

class TreeNode {
    var value: String = ""
    var children: [TreeNode] = []

    init(value: String) {
        self.value = value
    }

    private func searchByValue(targetValue: String) -> TreeNode? {
        children.first { node in
            node.value == targetValue
        }
    }

    public func addChildByPath(pathSeg: String) {
        var node = self
        pathSeg.split(separator: "/").forEach { item in
            if let searchedNode = node.searchByValue(targetValue: String(item)) {
                node = searchedNode
            } else {
                let newNode = TreeNode(value: String(item))
                node.children.append(newNode)
                node = newNode
            }
        }
    }
}
