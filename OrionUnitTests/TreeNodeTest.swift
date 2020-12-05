//
//  OrionUnitTests.swift
//  OrionUnitTests
//
//  Created by Renzhe Zheng on 2020/12/5.
//

import XCTest

@testable import Orion

class TreeNodeTest: XCTestCase {
    func testTreeNode() throws {
        let tree = TreeNode(value: "*")

        tree.addChildByPath(path: "a")
        tree.addChildByPath(path: "b")
        tree.addChildByPath(path: "c")

        XCTAssertTrue(tree.value == "*")
        XCTAssertTrue(tree.children.count == 3)

        tree.addChildByPath(path: "a/a1")
        tree.addChildByPath(path: "a/a2")
        tree.addChildByPath(path: "a/a3")
        tree.addChildByPath(path: "a/a4")
        XCTAssertTrue(tree.children.count == 3)
        XCTAssertTrue(tree.children[0].value == "a")
        XCTAssertTrue(tree.children[0].children.count == 4)
        XCTAssertTrue(tree.children[0].children[0].value == "a1")
        XCTAssertTrue(tree.children[0].children[1].value == "a2")
        XCTAssertTrue(tree.children[0].children[2].value == "a3")
        XCTAssertTrue(tree.children[0].children[3].value == "a4")

        tree.addChildByPath(path: "a/a1/a11")
        tree.addChildByPath(path: "a/a1/a12")
        XCTAssertTrue(tree.children[0].children[0].children.count == 2)
        XCTAssertTrue(tree.children[0].children[0].children[0].value == "a11")
        XCTAssertTrue(tree.children[0].children[0].children[1].value == "a12")
    }
}
