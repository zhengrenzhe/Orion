//
//  Files.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/11/27.
//

import Cache
import Combine
import FileKit
import Foundation
import SwiftEventBus

class FileStore {
    private let fileCache = MemoryStorage<String, String>(config: MemoryConfig(
        expiry: .never, countLimit: 100, totalCostLimit: 100
    ))

    init() {
        SwiftEventBus.onMainThread(self, name: clearData) { _ in
            self.fileCache.removeAll()
        }
    }

    public func hasFile(filePath: String) -> Bool {
        ((try? fileCache.existsObject(forKey: filePath)) == true)
    }

    public func loadFile(filePath: String) {
        if hasFile(filePath: filePath) {
            return
        }

        do {
            let fileContent = try TextFile(path: Path(filePath)).read()
            fileCache.setObject(fileContent, forKey: filePath)
            SwiftEventBus.post(loadFileSuccess, sender: filePath)
            print("load file \(filePath) success")
        } catch {
            print("load file \(filePath) error")
        }
    }
}

let SharedFileStore = FileStore()
