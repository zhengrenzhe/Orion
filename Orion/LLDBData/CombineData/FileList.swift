//
//  Files.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/12/5.
//

import Combine
import SwiftEventBus

class FileList: ObservableObject {
    @Published var files: [String] = []
    @Published var fileTree = TreeNode(value: "/")

    init() {
        SwiftEventBus.onMainThread(self, name: clearData) { _ in
            self.files.removeAll()
            self.fileTree = TreeNode(value: "/")
        }

        SwiftEventBus.onMainThread(self, name: loadFileSuccess) { res in
            if let filePath = res?.object {
                self.files.append("\(filePath)")

                let newTree = TreeNode(value: "/")
                self.files.forEach { path in
                    newTree.addChildByPath(path: path)
                }
                self.fileTree = newTree
            }
        }
    }
}
