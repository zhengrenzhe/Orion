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

class FileStoreList: ObservableObject {
    @Published var files: [String] = []

    init() {
        SwiftEventBus.onBackgroundThread(self, name: loadFileSuccess) { res in
            if let filePath = res?.object {
                self.files.append("\(filePath)")
            }
        }
    }
}

enum FileStore {
    private static let fileCache = MemoryStorage<String, String>(
        config: MemoryConfig(expiry: .never, countLimit: 100, totalCostLimit: 100))

    static func loadFile(filePath: String) {
        if hasFile(filePath: filePath) {
            return
        }

        let file = TextFile(path: Path(filePath))
        var fileContent = ""
        do {
            try fileContent = file.read()
            fileCache.setObject(fileContent, forKey: filePath)
            SwiftEventBus.post(loadFileSuccess, sender: filePath)
            print("load file \(filePath) success")
        } catch {
            print("load file \(filePath) error")
        }
    }

    static func hasFile(filePath: String) -> Bool {
        ((try? fileCache.existsObject(forKey: filePath)) == true)
    }
}
